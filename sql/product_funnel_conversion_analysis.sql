-- Product Funnel & Conversion Analysis
-- Synthetic portfolio dataset. Run against the cleaned CSV tables imported into SQL.

-- 1. Session-level funnel: one row per session, preventing repeated events
-- from inflating stage counts.
WITH event_flags AS (
    SELECT
        session_id,
        MAX(CASE WHEN event_name = 'landing_page' THEN 1 ELSE 0 END) AS landing_flag,
        MAX(CASE WHEN event_name = 'product_view' THEN 1 ELSE 0 END) AS product_view_flag,
        MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS cart_flag,
        MAX(CASE WHEN event_name = 'checkout_started' THEN 1 ELSE 0 END) AS checkout_flag,
        MAX(CASE WHEN event_name = 'purchase_completed' THEN 1 ELSE 0 END) AS purchase_flag
    FROM funnel_events_clean
    GROUP BY session_id
),
session_funnel AS (
    SELECT
        s.session_id, s.user_id, s.session_date, s.device,
        s.acquisition_channel, s.landing_page, s.marketing_campaign,
        COALESCE(e.landing_flag, 0) AS landing_flag,
        COALESCE(e.product_view_flag, 0) AS product_view_flag,
        COALESCE(e.cart_flag, 0) AS cart_flag,
        COALESCE(e.checkout_flag, 0) AS checkout_flag,
        COALESCE(e.purchase_flag, 0) AS purchase_flag
    FROM sessions_clean s
    LEFT JOIN event_flags e ON s.session_id = e.session_id
)
SELECT * FROM session_funnel;

-- 2. Overall funnel counts and step-to-step conversion.
WITH flags AS (
    SELECT session_id,
      MAX(CASE WHEN event_name='landing_page' THEN 1 ELSE 0 END) landing_flag,
      MAX(CASE WHEN event_name='product_view' THEN 1 ELSE 0 END) product_view_flag,
      MAX(CASE WHEN event_name='add_to_cart' THEN 1 ELSE 0 END) cart_flag,
      MAX(CASE WHEN event_name='checkout_started' THEN 1 ELSE 0 END) checkout_flag,
      MAX(CASE WHEN event_name='purchase_completed' THEN 1 ELSE 0 END) purchase_flag
    FROM funnel_events_clean GROUP BY session_id
), totals AS (
    SELECT COUNT(*) total_sessions,
      SUM(landing_flag) landing_sessions,
      SUM(product_view_flag) product_view_sessions,
      SUM(cart_flag) cart_sessions,
      SUM(checkout_flag) checkout_sessions,
      SUM(purchase_flag) purchase_sessions
    FROM sessions_clean s LEFT JOIN flags f ON s.session_id=f.session_id
)
SELECT *,
  1.0 * product_view_sessions / NULLIF(landing_sessions,0) AS landing_to_product_rate,
  1.0 * cart_sessions / NULLIF(product_view_sessions,0) AS product_to_cart_rate,
  1.0 * checkout_sessions / NULLIF(cart_sessions,0) AS cart_to_checkout_rate,
  1.0 * purchase_sessions / NULLIF(checkout_sessions,0) AS checkout_completion_rate,
  1.0 * purchase_sessions / NULLIF(total_sessions,0) AS overall_conversion_rate
FROM totals;

-- 3. Device performance.
WITH flags AS (
 SELECT session_id,
  MAX(CASE WHEN event_name='product_view' THEN 1 ELSE 0 END) product_view_flag,
  MAX(CASE WHEN event_name='add_to_cart' THEN 1 ELSE 0 END) cart_flag,
  MAX(CASE WHEN event_name='checkout_started' THEN 1 ELSE 0 END) checkout_flag,
  MAX(CASE WHEN event_name='purchase_completed' THEN 1 ELSE 0 END) purchase_flag
 FROM funnel_events_clean GROUP BY session_id
)
SELECT s.device, COUNT(*) total_sessions,
 SUM(COALESCE(f.product_view_flag,0)) product_view_sessions,
 SUM(COALESCE(f.cart_flag,0)) cart_sessions,
 SUM(COALESCE(f.checkout_flag,0)) checkout_sessions,
 SUM(COALESCE(f.purchase_flag,0)) purchase_sessions,
 1.0 * SUM(COALESCE(f.purchase_flag,0)) / COUNT(*) purchase_conversion_rate
FROM sessions_clean s LEFT JOIN flags f ON s.session_id=f.session_id
GROUP BY s.device ORDER BY total_sessions DESC;

-- 4. Acquisition-channel performance.
WITH flags AS (
 SELECT session_id,
  MAX(CASE WHEN event_name='product_view' THEN 1 ELSE 0 END) product_view_flag,
  MAX(CASE WHEN event_name='add_to_cart' THEN 1 ELSE 0 END) cart_flag,
  MAX(CASE WHEN event_name='checkout_started' THEN 1 ELSE 0 END) checkout_flag,
  MAX(CASE WHEN event_name='purchase_completed' THEN 1 ELSE 0 END) purchase_flag
 FROM funnel_events_clean GROUP BY session_id
)
SELECT s.acquisition_channel, COUNT(*) total_sessions,
 SUM(COALESCE(f.product_view_flag,0)) product_view_sessions,
 SUM(COALESCE(f.cart_flag,0)) cart_sessions,
 SUM(COALESCE(f.checkout_flag,0)) checkout_sessions,
 SUM(COALESCE(f.purchase_flag,0)) purchase_sessions,
 1.0 * SUM(COALESCE(f.purchase_flag,0)) / COUNT(*) purchase_conversion_rate
FROM sessions_clean s LEFT JOIN flags f ON s.session_id=f.session_id
GROUP BY s.acquisition_channel ORDER BY total_sessions DESC;

-- 5. Monthly trend (preserve year + month; do not group by month name alone).
WITH flags AS (
 SELECT session_id,
  MAX(CASE WHEN event_name='purchase_completed' THEN 1 ELSE 0 END) purchase_flag
 FROM funnel_events_clean GROUP BY session_id
)
SELECT EXTRACT(YEAR FROM s.session_date) AS session_year,
       EXTRACT(MONTH FROM s.session_date) AS session_month,
       COUNT(*) AS total_sessions,
       SUM(COALESCE(f.purchase_flag,0)) AS purchases,
       1.0 * SUM(COALESCE(f.purchase_flag,0)) / COUNT(*) AS conversion_rate
FROM sessions_clean s LEFT JOIN flags f ON s.session_id=f.session_id
GROUP BY EXTRACT(YEAR FROM s.session_date), EXTRACT(MONTH FROM s.session_date)
ORDER BY session_year, session_month;
