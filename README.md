# Market News Coverage Across Bull and Bear Market Conditions  
### S&P 500 News Coverage Analysis (SQL / GDELT)

---

## Project Overview

This project examines whether **large daily declines in the S&P 500 receive more media coverage than large daily gains**, using a fully SQL-based workflow.

It serves as a **replication and validation** of the following Python analysis:

**Python Project:**  
[Market News Coverage Across Bull and Bear Market Conditions — Python / MediaCloud](https://github.com/Tmax95644/Market-News-Asymmetry-Analysis)

The analysis combines:

- **Daily S&P 500 (^GSPC) price data** from Yahoo Finance  
- **Daily global financial news article counts** from the GDELT database  

A widely held assumption in financial commentary is tested:

> *“Bad market days attract more news coverage than good market days.”*

By reproducing the analysis in SQL and using an independent news dataset, this project evaluates whether the original findings are **robust, reproducible, and tool-independent**.

---

## Research Question

**Do large negative market moves generate more media coverage than similarly large positive moves?**

---

## Data Sources

### Market Data
- **S&P 500 (^GSPC)** daily prices  
- Source: *Yahoo Finance*  
- Daily return defined as **open-to-close percentage change**  
- Small market datasets are included in the repository  

### News Data
- **GDELT Global News Database**  
- Daily global news article counts aggregated at the day level  

> Raw GDELT data files are not included due to file size and licensing constraints.  
> See `data/README.md` for instructions on sourcing and reproducing the dataset locally.

---

## Tools & Technologies

- SQL (SQLite)  
- Aggregate functions  
- Window functions  
- Date-based filtering and classification  

---

## Methodology

### 1. Data Preparation
- Parsed and aligned dates across market and news datasets  
- Aggregated GDELT records to obtain **daily article counts**  
- Calculated daily S&P 500 returns using:

\[
\text{Return} = \frac{\text{Close} - \text{Open}}{\text{Open}} \times 100
\]

---

### 2. Market Day Classification
To enable a like-for-like comparison with the Python analysis, trading days were classified using **symmetric thresholds**:

- **Large Loss:** ≤ −3%  
- **Large Gain:** ≥ +3%  

This ensured consistent definitions of “extreme” market moves across projects.

---

### 3. Coverage Comparison
Daily article counts were aggregated separately for:

- Large positive market moves  
- Large negative market moves  

Key metrics evaluated:
- Number of qualifying days  
- Mean article count  
- Median article count  

All calculations were performed entirely in SQL.

---

### 4. Cross-Project Validation
To validate the robustness of the original findings:

- Identical return definitions, thresholds, and grouping logic were applied  
- Results were compared directionally rather than numerically, reflecting differences in news coverage sources  
- Queries were structured for full reproducibility once data is loaded  

---

## Key Findings

- Both **large gains and large losses** attracted substantially more news coverage than typical trading days  
- Extreme positive and negative market moves received **broadly similar levels of media attention**  
- Results were **directionally consistent** with the Python / MediaCloud analysis  

---

## Interpretation

These findings reinforce the conclusion that **media coverage is driven more by market extremity and narrative significance** than by negative direction alone.

Across both datasets and analytical tools, large and unusual market moves — regardless of whether markets rise or fall — attract disproportionate media attention.

---

## Limitations

- GDELT article counts do not capture **sentiment or tone**  
- Differences in news source composition compared to MediaCloud  
- Daily aggregation obscures intraday sequencing between market moves and coverage  

---

## Conclusion

This SQL-based replication strengthens confidence in the original analysis by demonstrating that the results are:

- **Tool-independent:** Python vs SQL  
- **Dataset-independent:** MediaCloud vs GDELT  
- **Reproducible:** Using standard SQL workflows  

Together, both projects provide robust evidence that **market extremity, rather than direction alone**, is a primary driver of financial news coverage.
