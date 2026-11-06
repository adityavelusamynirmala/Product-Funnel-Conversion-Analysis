Product Funnel & Conversion Analysis
Project Overview
This project analyzes an e-commerce purchase journey to understand how sessions progress through the conversion funnel and where users drop out. It compares funnel performance across devices and acquisition channels and examines how session volume and conversion change over time.

SQL is used for data preparation and funnel analysis, while Power BI is used to build interactive dashboards for funnel performance, device comparison, acquisition quality, and trend diagnostics.

Disclaimer: This project uses synthetic data for portfolio and learning purposes. It does not represent the performance of a real company, product, or customer base.

Business Problem
An e-commerce product team wants to understand why a relatively small share of sessions result in completed purchases. The analysis focuses on how users move through the purchase journey, which funnel stages have the largest losses, and whether conversion differs by device and acquisition channel.

Tools Used
SQL (SQLite): Data preparation, joins, conditional aggregation, session-level funnel construction, conversion calculations, and segmentation.
Power BI: KPI cards, funnel visualizations, conversion and drop-off analysis, device and channel comparisons, slicers, and time-based reporting.
Excel: Dataset inspection and validation.
Dataset
The project uses two synthetic datasets, each supplied in raw and cleaned form:

sessions_raw.csv / sessions_clean.csv — session-level information, including session ID, user ID, session date, device, acquisition channel, landing page, and marketing campaign.
funnel_events_raw.csv / funnel_events_clean.csv — event-level records associated with sessions, including event name and event timestamp.
The event journey contains five key stages: landing_page, product_view, add_to_cart, checkout_started, and purchase_completed. Funnel counts are calculated at the session level so that a session is counted no more than once at each stage, even if an event is repeated.

Key Findings
The completed Power BI report shows the following results for the full dataset:

12,000 total sessions.
8,127 sessions reached product view.
4,110 sessions reached add to cart.
2,520 sessions started checkout.
1,519 sessions completed a purchase.
12.66% overall session-to-purchase conversion rate.
Stage-to-stage conversion rates were 67.73% from landing to product view, 50.57% from product view to cart, 61.31% from cart to checkout, and 60.28% from checkout to purchase.
The largest absolute loss of sessions occurs between product view and add to cart (4,017 sessions), making this an important stage for further investigation.
Android contributes the highest session volume (5,638 sessions), while iOS has the highest device-level purchase conversion (approximately 14.49%).
Organic Search contributes the highest session volume (3,614 sessions). Paid Ads has the lowest purchase conversion among the displayed acquisition channels (approximately 10.51%).
These are descriptive findings from synthetic data. They identify where further investigation may be useful but do not establish the reasons users abandon the funnel.

Analysis Approach
Reviewed the raw session and funnel-event datasets.
Inspected and used the cleaned session and event tables for analysis.
Joined event records to sessions using session_id.
Created session-level flags for landing page, product view, add to cart, checkout started, and purchase completed.
Counted distinct sessions reaching each funnel stage to avoid inflating counts from repeated events.
Calculated overall conversion, stage-to-stage conversion, and stage drop-off counts and rates.
Compared funnel volume and purchase conversion across devices.
Compared session volume, funnel progression, and purchase conversion across acquisition channels.
Examined session volume, purchases, and conversion over time using the session date.
Built Power BI dashboards to communicate the results and support interactive exploration.
Dashboard Preview
1. Funnel Overview


2. Device Comparison


3. Acquisition Quality


4. Trend & Diagnostics


Recommendations for Further Investigation
Investigate the product-view-to-add-to-cart stage, where the largest absolute session loss occurs. Review product information clarity, pricing, availability, and the visibility of the add-to-cart action.
Compare the product and checkout experience across Android, iOS, and Desktop to identify possible usability or technical differences.
Examine Paid Ads traffic quality by campaign, landing page, audience, and user intent before making budget decisions.
Review checkout errors, payment failures, form completion, and page performance to understand why some sessions do not complete a purchase.
Monitor funnel conversion over time and validate any apparent changes against traffic mix, campaign activity, and seasonality.
These are proposed investigation steps, not confirmed causes or claims of measured product impact.

Limitations
The dataset is synthetic and does not represent real e-commerce behaviour.
Session-based funnel counts show whether a session reached a stage; they do not measure the order or timing of every action within a session.
The analysis counts each session at most once per funnel stage, so repeated events do not increase stage totals.
Acquisition cost, advertising spend, revenue, and profit are not included, so channel profitability and return on ad spend cannot be evaluated.
Device and channel differences are descriptive associations and do not establish causation.
Time-based patterns should be interpreted alongside changes in traffic volume and acquisition mix.
Project Structure
Product-Funnel-Conversion-Analysis/
├── data/
│   ├── raw/
│   │   ├── sessions_raw.csv
│   │   └── funnel_events_raw.csv
│   └── cleaned/
│       ├── sessions_clean.csv
│       └── funnel_events_clean.csv
├── sql/
│   └── product_funnel_conversion_analysis.sql
├── powerbi/
│   └── product_funnel_conversion_analysis.pbix
├── docs/
│   ├── data_cleaning_guide.pdf
│   ├── data_dictionary.pdf
│   ├── project_workflow.pdf
│   └── dashboard-screenshots/
│       ├── funnel_overview.png
│       ├── device_comparison.png
│       ├── acquisition_quality.png
│       └── trend_diagnostics.png
└── README.md
Skills Demonstrated
SQL joins, CTEs, conditional aggregation, data preparation, session-level funnel analysis, conversion-rate calculation, drop-off analysis, device segmentation, acquisition-channel analysis, time-based analysis, data modeling, DAX, Power BI dashboard development, KPI development, and evidence-based product recommendations.

