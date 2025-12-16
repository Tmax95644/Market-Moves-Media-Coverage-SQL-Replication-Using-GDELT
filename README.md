Market News Coverage Asymmetry — SQL Replication (GDELT)
Project Context

This project is a SQL-based replication of the following Python analysis:

🔗 Python Project: https://github.com/Tmax95644/Market-News-Asymmetry-Analysis
Market News Coverage Across Bull and Bear Market Conditions — Python / MediaCloud

The purpose of this project is to test whether the original findings remain consistent when:

Using an independent global news dataset

Performing the full analysis entirely in SQL

Replicating the same classification logic and thresholds

This approach mirrors real-world analytical validation, where results are tested across tools and data sources.

Research Question

Do large negative market moves receive more news coverage than similarly large positive market moves?

Data Sources
Market Data

S&P 500 daily price data

Daily returns calculated using the same open-to-close methodology as the Python analysis

Small market datasets are included in the repository

News Data

GDELT Global News Database

Global news coverage aggregated at the daily level

Note:
Raw GDELT CSV files are not included in this repository due to file size and data licensing constraints.
See data/README.md for instructions on sourcing and reproducing the dataset locally.

Tools

SQL (SQLite)

Aggregate functions

Window functions

Date-based filtering and classification

Methodology

Classified trading days using symmetric return thresholds (e.g. ±3%)

Aggregated daily article counts for:

Large positive market moves

Large negative market moves

Compared mean and median article volumes across categories

Applied identical classification logic to the Python analysis to ensure consistency

Structured queries to allow full reproducibility once data is loaded

Key Findings

Results were directionally consistent with the Python / MediaCloud analysis

Both large gains and large losses attracted significantly more coverage than normal trading days

Extreme positive and negative market moves received similar levels of media attention

Conclusion

This SQL replication strengthens confidence in the original analysis by demonstrating that the findings are:

Tool-independent (Python vs SQL)

Dataset-independent (MediaCloud vs GDELT)

Reproducible using standard SQL workflows

The results suggest that market extremity, rather than direction alone, is a primary driver of financial news coverage.
