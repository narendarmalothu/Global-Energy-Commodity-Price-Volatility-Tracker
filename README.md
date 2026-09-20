# Global Energy Commodity & Price Volatility Tracker

## Business Context
Understanding macroeconomic market shocks and energy price volatility is critical for upstream optimization, investment timing, and global energy market forecasting. This project automates the extraction of daily spot prices for major energy commodities (Brent Crude, WTI, Natural Gas) to analyze historical trends, calculate month-over-month (MoM) growth, and measure price volatility.

## Tech Stack
* **Python (Jupyter Notebook):** Data extraction (REST APIs), Pandas (Data manipulation), Matplotlib/Seaborn (Exploratory Data Analysis).
* **MySQL:** Relational database design, Common Table Expressions (CTEs), and Window Functions for time-series aggregation.
* **Power BI:** Interactive dashboarding for client-facing market insights.

## Dataset
* **Source:** U.S. Energy Information Administration (EIA) Open Data API v2.
* **Commodities Tracked:** Europe Brent Spot Price FOB, Cushing OK WTI Spot Price FOB, Henry Hub Natural Gas Spot Price.

## Project Architecture
1. **Data Pipeline:** Python script connects to the EIA API to fetch daily spot prices, cleans the JSON payload, standardizes data types, and handles missing values.
2. **Database Ingestion:** Cleaned time-series data is loaded into a MySQL database.
3. **Advanced SQL Analytics:** Advanced queries utilizing Window Functions and CTEs calculate rolling averages and standard deviations (volatility metrics) for each commodity.
4. **Visualization:** Matplotlib/Seaborn generate static EDA distributions, while Power BI is used to build an interactive volatility dashboard.

