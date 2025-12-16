-- ============================================================
-- PROJECT: Do markets get more news coverage on big down days?
-- DATA: GDELT Daily Article Counts + S&P 500 (Yahoo Finance)
-- PURPOSE:
--   Replicate and validate a Python/Pandas analysis using SQL.
--   Compare news coverage on large market loss vs gain days,
--   and test robustness with different thresholds and lag effects.
-- ============================================================


-- ============================================================
-- 1. CLEAN GDELT DATA
-- ============================================================
-- Source table: gdelt
-- Columns: Date, Series, Value
-- We keep only daily article counts

CREATE TABLE gdelt_daily AS
SELECT
    DATE(Date) AS date,
    CAST(Value AS INTEGER) AS gdelt_count
FROM gdelt
WHERE Series = 'Article Count';


-- ============================================================
-- 2. CLEAN S&P 500 DATA
-- ============================================================
-- Source table: spx_raw
-- Columns: date, open, close

CREATE TABLE spx_prices AS
SELECT
    DATE(date) AS date,
    ROUND(((close - open) / open) * 100, 2) AS gain_loss
FROM spx_raw;


-- ============================================================
-- 3. MERGE MARKET DATA WITH NEWS DATA
-- ============================================================

CREATE TABLE market_news AS
SELECT
    s.date,
    s.gain_loss,
    g.gdelt_count
FROM spx_prices s
JOIN gdelt_daily g
    ON s.date = g.date;


-- ============================================================
-- 4. BASELINE CHECK: SAMPLE DATA
-- ============================================================

SELECT *
FROM market_news
ORDER BY date
LIMIT 10;


-- ============================================================
-- 5. LIKE-FOR-LIKE ANALYSIS (±2.5%)
-- ============================================================
-- Compare large losses vs large gains of similar magnitude

SELECT
    CASE
        WHEN gain_loss <= -2.5 THEN 'Large Loss (≤ -2.5%)'
        WHEN gain_loss >=  2.5 THEN 'Large Gain (≥ +2.5%)'
        ELSE 'Normal Day'
    END AS move_type,
    COUNT(*) AS days,
    ROUND(AVG(gdelt_count), 0) AS avg_articles,
    ROUND(
        AVG(
            CASE
                WHEN gdelt_count IS NOT NULL THEN gdelt_count
            END
        ), 0
    ) AS avg_articles_check
FROM market_news
GROUP BY move_type
ORDER BY move_type;


-- ============================================================
-- 6. ROBUSTNESS CHECK (±3%)
-- ============================================================

SELECT
    CASE
        WHEN gain_loss <= -3 THEN 'Large Loss (≤ -3%)'
        WHEN gain_loss >=  3 THEN 'Large Gain (≥ +3%)'
        ELSE 'Normal Day'
    END AS move_type,
    COUNT(*) AS days,
    ROUND(AVG(gdelt_count), 0) AS avg_articles
FROM market_news
GROUP BY move_type
ORDER BY move_type;


-- ============================================================
-- 7. NEWS LAG ANALYSIS (1–2 DAY DELAY)
-- ============================================================
-- Test whether coverage increases after large loss days

SELECT
    m1.date AS loss_day,
    m1.gain_loss,
    m1.gdelt_count AS same_day_articles,
    m2.gdelt_count AS day_plus_1_articles,
    m3.gdelt_count AS day_plus_2_articles
FROM market_news m1
LEFT JOIN market_news m2
    ON DATE(m1.date, '+1 day') = m2.date
LEFT JOIN market_news m3
    ON DATE(m1.date, '+2 day') = m3.date
WHERE m1.gain_loss <= -3
ORDER BY m1.date;


-- ============================================================
-- 8. AVERAGE LAGGED COVERAGE AFTER LARGE LOSSES
-- ============================================================

SELECT
    ROUND(AVG(same_day_articles), 0) AS same_day_avg,
    ROUND(AVG(day_plus_1_articles), 0) AS day_plus_1_avg,
    ROUND(AVG(day_plus_2_articles), 0) AS day_plus_2_avg
FROM (
    SELECT
        m1.gdelt_count AS same_day_articles,
        m2.gdelt_count AS day_plus_1_articles,
        m3.gdelt_count AS day_plus_2_articles
    FROM market_news m1
    LEFT JOIN market_news m2
        ON DATE(m1.date, '+1 day') = m2.date
    LEFT JOIN market_news m3
        ON DATE(m1.date, '+2 day') = m3.date
    WHERE m1.gain_loss <= -3
);


-- ============================================================
-- 9. INTERPRETATION NOTES
-- ============================================================
-- Findings:
-- - Large market gains often receive comparable or higher coverage
--   than large losses in the GDELT dataset.
-- - This contrasts with the initial hypothesis that negative
--   market events dominate news.
-- - Results suggest news coverage is driven by magnitude and
--   narrative importance, not just negativity.
-- - Replicating the analysis in SQL validates the Python results
--   across an independent dataset.
