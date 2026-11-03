# Apple Retail 2023: Sales, Geography & Warranty Analysis (T-SQL)

SQL Server (SSMS 22) analysis of the [Apple Retail Sales Dataset](https://www.kaggle.com/datasets/amangarg08/apple-retail-sales-dataset) on Kaggle, by Aman Garg. The data is synthetic.

## Project overview

End-to-end analysis of 2023 (213,453 transactions, $1.26B revenue) across three business areas:

1. **Revenue performance:** which categories and products drove sales.
2. **Geographic distribution:** which countries, cities and stores lead.
3. **Warranty and service quality:** how often products are claimed and how efficient the repair pipeline is.

The 2023 figures were reconciled across **T-SQL, Python (Google Colab) and Power BI**, and all three return identical results.

## Key findings (2023)

- **Revenue:** $1,261,440,123. Tablet leads ($195.2M, 15.5%), followed by Accessories ($191.0M) and Smartphone ($176.0M).
- **Geography:** the United States contributes $254.1M (20.1%). Dubai, London and Paris tie at about $67M each because each has four stores; revenue per store is about $16.6M to $17.0M everywhere.
- **Warranty:** 6,109 claims, a claim rate of 2.86% of transactions. 50.5% of claims are still Pending or In Progress. The highest product claim rate is Beats Fit Pro (3.83%).

Full breakdown: [INSIGHTS.md](INSIGHTS.md)

## SQL techniques used

- Multi-table INNER and LEFT JOINs with GROUP BY aggregations (SUM, COUNT, AVG)
- CTE with `ROW_NUMBER() OVER (PARTITION BY ...)` for the top 10 products per category
- `CASE WHEN` pivot for repair status
- Data cleaning: `TRY_CAST` for text-formatted dates, with a data check (0 failed casts across 1,040,200 rows)
- Date arithmetic: `DATEDIFF` for days from purchase to claim; half-open date range filters

## Files

- `apple-retail-sql-analysis.sql`: the analysis script, in three sections (sales, geography, warranty)
- `INSIGHTS.md`: findings written for non-technical readers

## How to run

1. Download the dataset from Kaggle.
2. Import the CSV files into a SQL Server database named `Myportoproject`.
3. Run `apple-retail-sql-analysis.sql`.

## Data notes

- The dataset covers January 2020 to November 2024. All analysis is limited to 2023.
- Different stores can share one name (for example, two stores are called "Apple The Dubai Mall"), and two products are both called "HomePod mini". Queries group by ID, not by name.

Author: Rukoyah (Hehe)
