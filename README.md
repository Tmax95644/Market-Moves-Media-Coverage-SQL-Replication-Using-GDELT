# Market News Coverage Asymmetry — SQL Replication (GDELT)

## Project Context

This project is a **SQL-based replication** of the following Python analysis:

🔗 **Python Project:**  
[Market News Coverage Across Bull and Bear Market Conditions — Python / MediaCloud](https://github.com/Tmax95644/Market-News-Asymmetry-Analysis)

The goal is to validate whether the original findings hold when:
- Using **a different news dataset**
- Performing the analysis **entirely in SQL**

---

## Research Question

Do large negative market moves receive more news coverage than similarly large positive moves?

---

## Data Sources

### Market Data
- **S&P 500 daily returns**
- Same return definitions and thresholds as the Python analysis

### News Data
- **GDELT Global News Database**
- Global coverage across a broader set of news sources

---

## Tools

- SQL (SQLite)
- Aggregation and window functions
- Date-based filtering and classification

---

## Methodology

- Classified trading days using symmetric thresholds (e.g. ±3%)
- Aggregated article counts for:
  - Large gains
  - Large losses
- Compared mean and median coverage
- Applied identical logic to the Python analysis for consistency

---

## Key Findings

- Results were **directionally consistent** with the Python / MediaCloud analysis
- Large market moves attracted more coverage than typical days
- Positive and negative extremes showed **similar levels of attention**

---

## Conclusion

This SQL replication strengthens confidence in the original findings by demonstrating that the results are:
- Not tool-specific
- Not dataset-specific
- Reproducible using standard SQL workflows
