This project is a SQL-based replication of the following Python analysis:

🔗 **Python Project:**  
[Market News Coverage Across Bull and Bear Market Conditions — Python / MediaCloud](https://github.com/Tmax95644/Market-News-Asymmetry-Analysis)

The purpose of this project is to validate whether the original findings remain consistent when:

Using an independent global news dataset

Performing the analysis entirely in SQL

Replicating the same classification logic and return thresholds

This mirrors real-world analytical validation, where results are tested across tools, workflows, and data sources.

Research Question

Do large negative market moves receive more news coverage than similarly large positive market moves?

Data Sources
Market Data

S&P 500 daily price data

Daily returns calculated using the same open-to-close percentage change methodology as the Python analysis

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
1. Market Day Classification

Trading days were classified using symmetric return thresholds:

Large Loss: ≤ −3%

Large Gain: ≥ +3%

2. Coverage Aggregation

Daily article counts were aggregated for:

Large positive market moves

Large negative market moves

Both mean and median article volumes were calculated

3. Consistency with Python Analysis

Identical return definitions, thresholds, and grouping logic were applied

Queries were structured to allow full reproducibility once data is loaded

Key Findings

Results were directionally consistent with the Python / MediaCloud analysis

Both large gains and large losses attracted significantly more coverage than typical trading days

Extreme positive and negative market moves received similar levels of media attention

Conclusion

This SQL replication strengthens confidence in the original findings by demonstrating that the results are:

Tool-independent (Python vs SQL)

Dataset-independent (MediaCloud vs GDELT)

Reproducible using standard SQL workflows

Overall, the evidence suggests that market extremity, rather than direction alone, is a primary driver of financial news coverage.
