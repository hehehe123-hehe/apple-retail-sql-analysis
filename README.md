# apple-retail-sql-analysis
Apple Retail Ecosystem: 2023 Performance & Warranty Analysis

* Dataset: [Apple Retail Sales Dataset](https://www.kaggle.com/datasets/amangarg08/apple-retail-sales-dataset?resource=download) oleh Aman Garg.
📌 Project Overview

This project provides an end-to-end data analysis of a global Apple Retail dataset ($200M+ simulated revenue) for the 2023 fiscal year. Using T-SQL (SSMS 22), I analyzed three core business pillars: Revenue Performance, Geographic Distribution, and Service Quality (Warranty Operations).

📊 Business Key Performance Indicators (KPIs)

Total Revenue: Identified $133M+ revenue in the Smartphone category alone.

Market Share: Calculated the percentage of warranty claims per category using window functions to identify operational pressure points.

Service Reliability: Measured the "Average Days to Claim" to flag product durability trends across 11 categories.

Operational Efficiency: Created a repair status dashboard (Pivot) to monitor the "In Progress" vs. "Completed" pipeline.

🛠️ Technical Skills Demonstrated

Advanced Aggregations: Using SUM, COUNT, and AVG across complex multi-table joins.

Window Functions: Utilizing OVER() to calculate relative percentages without subqueries.

Data Transformation: Implementing CASE WHEN logic to pivot status data for executive reporting.

Data Integrity: Safe casting of types using TRY_CAST and DATEDIFF for time-series analysis.

Shorthand Schema: Optimized for SSMS 22 using the .. database shorthand.

📁 Repository Structure

apple_retail_analysis.sql: The complete script containing all 17 strategic business queries.

INSIGHTS.md: A detailed breakdown of the business findings for non-technical stakeholders.

Developed as a professional portfolio project to demonstrate SQL proficiency in retail and operations analytics.
