# Product Funnel & Conversion Analysis

## Project Overview
This project analyzes an e-commerce purchase journey to understand where sessions drop out of the funnel and how conversion differs across devices and acquisition channels. The analysis uses SQL and Power BI.

**Dataset:** Synthetic portfolio practice data; it does not represent a real company or real customers.

## Business Questions
- How many sessions reach each stage of the purchase funnel?
- At which stage is the largest loss of sessions observed?
- How does conversion vary by device?
- Which acquisition channels generate the most sessions and purchases?
- How do session volume and conversion change over time?

## Funnel Stages
1. Landing Page
2. Product View
3. Add to Cart
4. Checkout Started
5. Purchase Completed

## Dashboard Preview
Add the exported screenshots to `docs/dashboard-screenshots/` using the filenames below.

### 1. Funnel Overview
![Funnel Overview](docs/dashboard-screenshots/funnel_overview.png)

### 2. Device Comparison
![Device Comparison](docs/dashboard-screenshots/device_comparison.png)

### 3. Acquisition Quality
![Acquisition Quality](docs/dashboard-screenshots/acquisition_quality.png)

### 4. Trend & Diagnostics
![Trend & Diagnostics](docs/dashboard-screenshots/trend_diagnostics.png)

## Key Metrics
- Total Sessions
- Landing Page Sessions
- Product View Sessions
- Add to Cart Sessions
- Checkout Sessions
- Purchase Sessions
- Overall Session-to-Purchase Conversion Rate
- Stage-to-Stage Conversion Rates
- Stage Drop-off Counts and Rates

## Initial Dashboard Observations
Based on the completed dashboard at the full-dataset level:
- The dataset contains 12,000 sessions and 1,519 purchase sessions.
- Overall session-to-purchase conversion is approximately 12.66%.
- 8,127 sessions reached product view, 4,110 reached add to cart, and 2,520 reached checkout.
- iOS has the highest purchase conversion among the three device categories shown; Android has the largest session volume.
- Organic Search contributes the highest session volume among the displayed acquisition channels.
- Paid Ads has the lowest purchase conversion among the displayed channels.

These are descriptive observations from synthetic data, not proof of why users behave this way. Channel quality should also be assessed using spend, acquisition cost, campaign objectives, and traffic mix, which are outside the scope of the available measures.

## Repository Structure
```text
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
```

## Tools & Skills
- SQL: conditional aggregation, CTEs, joins, funnel analysis, conversion calculations, segmentation, and time-based analysis.
- Power BI: data modeling, calculated tables, DAX measures, funnel visualization, KPI cards, matrix analysis, slicers, and trend reporting.
- Product Analytics: funnel conversion, stage drop-off, device comparison, acquisition-channel analysis, and evidence-based recommendations.

## Limitations
- Data is synthetic and intended for portfolio practice.
- Observed differences are associations and do not establish causation.
- Marketing spend and acquisition cost are not included, so channel profitability cannot be evaluated.
- Funnel stage counts are session-based; each session is counted at most once per stage.

## Files
- Cleaned and raw CSV datasets are provided in `data/`.
- SQL analysis queries are provided in `sql/`.
- The Power BI report belongs in `powerbi/`.
- Dashboard screenshots belong in `docs/dashboard-screenshots/`.
