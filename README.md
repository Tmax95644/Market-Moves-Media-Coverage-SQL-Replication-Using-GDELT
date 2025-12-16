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
- Conditional logic (`CASE`)  
- Date-based filtering and joins  

> SQL was chosen to demonstrate large-dataset aggregation, reproducibility, and analytical workflows outside a Python environment.

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

A wider **±2.5% threshold** was also tested to increase sample size and assess result stability.

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

## Results

### Key Findings
- Large market gains often receive **equal or greater media coverage** than large losses  
- News coverage peaks **on the same day** as extreme market moves  
- Coverage declines steadily in the days following major losses  
- Market extremity appears to drive attention more than negative direction  

---

### Like-for-like comparison
When comparing days with similar magnitude market moves:

- For thresholds of **±2.5% and ±3%**, large gain days consistently showed **equal or higher average article counts** than large loss days  
- Normal trading days had substantially lower coverage than either type of extreme move  

This suggests that media attention increases with the **size of market movement**, regardless of direction.

---

### Lag analysis
A 1–2 day lag analysis following large market losses showed:

- Peak article counts on the **same day** as the market move  
- A steady decline in coverage over subsequent days  

This indicates that news coverage reacts immediately rather than with a delayed spike.

---

### Interpretation
Contrary to the initial hypothesis that negative market moves dominate news coverage, the results suggest that **large positive rallies often attract comparable or greater attention**. This implies that **narrative significance and volatility** may be stronger drivers of media coverage than negativity alone.

---

## Interpretation (Cross-Project Summary)

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
