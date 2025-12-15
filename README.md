Market Moves & Media Coverage
SQL Replication Using GDELT
Project Overview

This project replicates and validates the findings of a Python-based analysis that examined whether large daily market declines receive more media coverage than large daily gains.

While the original analysis used MediaCloud and pandas, this project:

uses SQL as the primary analysis tool

leverages GDELT, a much larger global news database

tests whether the original conclusions hold across datasets and toolchains

Research Question

Are large negative S&P 500 moves associated with higher news coverage than similarly large positive moves?

Data Sources
1. Market Data

S&P 500 (^GSPC) daily prices

Source: Yahoo Finance

Return definition: open-to-close daily percentage change

2. News Data

GDELT DOC 2.1 API

Daily global article counts

Query terms:

stock market

financial markets

equity markets

share market

Raw data files are not included due to size and licensing constraints.

Tools & Technologies

SQLite

SQL

Python (used only for data export and preprocessing)

Methodology
1. Data Cleaning (SQL)

Imported raw CSV files into SQLite

Preserved raw tables for reproducibility

Created clean tables:

spx_prices — daily market returns

gdelt_daily — daily global article counts

All transformations (casting, date normalization, return calculation) were performed in SQL.

2. Market Day Classification

Market days were categorised using symmetric return thresholds:

Large Loss: ≤ −2.5%

Large Gain: ≥ +2.5%

Normal Day: all other days

A stricter ±3% threshold was also tested to assess robustness.

3. Aggregation & Comparison

Using SQL joins and aggregation:

Market data and news data were joined by date

Average article counts were compared across market regimes

Results were summarised directly in SQL

4. Lag Analysis

To test whether news coverage peaks after market declines:

Article counts were analysed on:

Same day

1 day after

2 days after

This helped assess whether media response is delayed or immediate.

Key SQL Query (Example)
SELECT
    CASE
        WHEN s.gain_loss <= -2.5 THEN 'Large Loss'
        WHEN s.gain_loss >=  2.5 THEN 'Large Gain'
        ELSE 'Normal Day'
    END AS move_type,
    COUNT(*) AS days,
    ROUND(AVG(g.gdelt_count), 0) AS avg_articles
FROM spx_prices s
JOIN gdelt_daily g
    ON s.date = g.date
GROUP BY move_type
ORDER BY move_type;

Results Summary
Market Day Type	Number of Days	Avg. Daily Articles
Large Gain	7	~73,000
Large Loss	13	~66,000
Normal Day	1,221	~57,000
Interpretation

Both large gains and large losses attract substantially more news coverage than normal trading days

Contrary to common assumptions, large positive market moves received higher average coverage than large negative moves

Results were directionally consistent with the Python / MediaCloud analysis

This consistency across:

datasets (MediaCloud vs GDELT)

tools (pandas vs SQL)

strengthens confidence in the findings.

Limitations

Sample sizes for extreme market days are small

GDELT measures article volume, not sentiment

Global news coverage may amplify large international events

Daily aggregation obscures intraday publication timing

Relationship to Python Project

This SQL analysis serves as a replication and validation study for the following project:

Do Markets Get More News Coverage on Big Down Days? (Python / MediaCloud)

Together, the two projects demonstrate:

hypothesis-driven analysis

replication across independent datasets

fluency in both Python and SQL

analytical judgement when results challenge expectations
