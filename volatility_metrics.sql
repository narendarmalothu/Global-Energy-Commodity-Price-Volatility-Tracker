-- 1. Database & Table Creation
CREATE DATABASE IF NOT EXISTS global_energy_markets;
USE global_energy_markets;

DROP TABLE IF EXISTS commodity_pricing;
CREATE TABLE commodity_pricing (
    price_date DATE,
    commodity_name VARCHAR(100),
    spot_price DECIMAL(10, 2)
);

-- (Load your CSV data into this table using MySQL Workbench Data Import Wizard)

-- 2. Advanced Analysis: Monthly Volatility & Growth Tracking
-- This query uses Common Table Expressions (CTEs) and Window Functions 
-- to evaluate market stability, a core requirement for Rystad Energy analysts.

WITH MonthlyAggregates AS (
    SELECT 
        commodity_name,
        DATE_FORMAT(price_date, '%Y-%m-01') AS report_month,
        ROUND(AVG(spot_price), 2) AS avg_monthly_price,
        ROUND(STDDEV(spot_price), 2) AS monthly_volatility,
        MIN(spot_price) AS monthly_low,
        MAX(spot_price) AS monthly_high
    FROM commodity_pricing
    GROUP BY commodity_name, DATE_FORMAT(price_date, '%Y-%m-01')
),
GrowthMetrics AS (
    SELECT 
        commodity_name,
        report_month,
        avg_monthly_price,
        monthly_volatility,
        monthly_high - monthly_low AS price_spread,
        LAG(avg_monthly_price) OVER (PARTITION BY commodity_name ORDER BY report_month) AS prev_month_price
    FROM MonthlyAggregates
)
SELECT 
    commodity_name,
    report_month,
    avg_monthly_price,
    monthly_volatility,
    price_spread,
    ROUND(((avg_monthly_price - prev_month_price) / prev_month_price) * 100, 2) AS mom_growth_pct
FROM GrowthMetrics
ORDER BY commodity_name, report_month DESC;