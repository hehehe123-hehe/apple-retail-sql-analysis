/* ================================================================================
APPLE RETAIL DATA ANALYSIS REPORT (JAN 2023 - DEC 2023)
================================================================================
Description: Comprehensive analysis of sales performance, regional distribution, 
             and after-sales service quality.
Organized by: Business Functional Area
Database: Myportoproject
Author : Rukoyah(Hehe)
================================================================================ */

--------------------------------------------------------------------------------
-- SECTION 1: SALES & REVENUE PERFORMANCE (BY CATEGORY)
-- Focus: Understanding revenue drivers and top products within the 2023 fiscal year.
--------------------------------------------------------------------------------

-- 1.0 Data check : date range and failed cast
SELECT MIN(TRY_CAST(sale_date AS DATETIME)) AS min_date,
       MAX(TRY_CAST(sale_date AS DATETIME)) AS max_date,
       COUNT(*) AS total_rows,
       SUM(CASE WHEN TRY_CAST(sale_date AS DATETIME) IS NULL THEN 1 ELSE 0 END) AS failed_cast
FROM 
    Myportoproject..sales;
-- 1.1 Revenue per Category
 SELECT
    c.category_name,
    SUM(CAST(s.quantity AS INT)) AS total_units_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE 
    TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
    and TRY_CAST(s.sale_date AS DATETIME) < '2024-01-01'
GROUP BY 
    c.category_name
ORDER BY
    total_revenue DESC;

-- 1.2 Top 10 Products per Category by Revenue(2023)
WITH product_revenue AS (
    SELECT c.category_name, p.product_name,
           COUNT(s.sale_id) AS total_transactions,
           SUM(CAST(s.quantity AS INT)) AS total_items_sold,
           SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
    FROM Myportoproject..sales s
    JOIN Myportoproject..products p ON s.product_id = p.product_id
    JOIN Myportoproject..category c ON p.category_id = c.category_id
    WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
    GROUP BY c.category_name, p.product_name
),
ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY category_name
                              ORDER BY total_revenue DESC) AS rank_in_category
    FROM product_revenue
)
SELECT *
FROM ranked
WHERE rank_in_category <= 10
ORDER BY total_revenue DESC, category_name, rank_in_category;

-- 1.3 Monthly Revenue and Month-over-Month Change (2023)
WITH monthly AS (
    SELECT DATEFROMPARTS(YEAR(TRY_CAST(s.sale_date AS DATETIME)),
                         MONTH(TRY_CAST(s.sale_date AS DATETIME)), 1) AS month_start,
           SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
    FROM Myportoproject..sales s
    JOIN Myportoproject..products p ON s.product_id = p.product_id
    WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
    GROUP BY DATEFROMPARTS(YEAR(TRY_CAST(s.sale_date AS DATETIME)),
                           MONTH(TRY_CAST(s.sale_date AS DATETIME)), 1)
)
SELECT month_start,
       total_revenue,
       CAST((total_revenue - LAG(total_revenue) OVER (ORDER BY month_start)) * 100.0
            / LAG(total_revenue) OVER (ORDER BY month_start) AS DECIMAL(10,2)) AS mom_pct
FROM monthly
ORDER BY month_start;

--------------------------------------------------------------------------------
-- SECTION 2: STORE & GEOGRAPHIC DISTRIBUTION
-- Focus: Identifying high-traffic locations and regional market leaders.
--------------------------------------------------------------------------------

-- 2.1 country-Level Product Revenue Analysis
SELECT
    st.Country,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..stores st ON s.store_id = st.store_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY st.Country
ORDER BY total_revenue DESC;

-- 2.2 city-Level Product Revenue Analysis
SELECT
    st.City,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..stores st ON s.store_id = st.store_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY st.City
ORDER BY total_revenue DESC;

-- 2.3 Top 10 Stores by Transaction Volume
SELECT TOP 10
    st.Store_ID,
    st.Store_Name,
    st.city,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold
FROM Myportoproject..sales s
JOIN Myportoproject..stores st ON s.store_id = st.store_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY st.Store_ID, st.city, st.Store_Name
ORDER BY total_transactions DESC;


--------------------------------------------------------------------------------
-- SECTION 3: WARRANTY & QUALITY ASSURANCE
-- Focus: Monitoring after-sales reliability and repair efficiency.
--------------------------------------------------------------------------------

-- 3.1 Warranty Claim Volume by Product
SELECT
    p.product_name,
    COUNT(w.claim_id) AS total_claims
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..warranty w ON s.sale_id = w.sale_id
WHERE w.claim_id IS NOT NULL and 
    TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
    AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY p.product_name
ORDER BY total_claims DESC;

-- 3.2 Average Days from Purchase to Claim 
SELECT
    c.category_name,
    AVG(CAST(DATEDIFF(DAY, TRY_CAST(s.sale_date AS DATETIME), w.claim_date) AS DECIMAL(10,2))) AS avg_days_to_claim,
    COUNT(w.claim_id) AS total_claims
FROM Myportoproject..sales s
JOIN Myportoproject..warranty w ON s.sale_id = w.sale_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY c.category_name
ORDER BY avg_days_to_claim ASC;

-- 3.3 Repair completion
SELECT 
    c.category_name,
    COUNT(CASE WHEN w.repair_status = 'Pending' THEN 1 END) AS [Pending],
    COUNT(CASE WHEN w.repair_status = 'In Progress' THEN 1 END) AS [In Progress],
    COUNT(CASE WHEN w.repair_status = 'Completed' THEN 1 END) AS [Completed],
    COUNT(CASE WHEN w.repair_status = 'Rejected' THEN 1 END) AS [Rejected],
    COUNT(w.claim_id) AS total_claims,
    CAST(COUNT(CASE WHEN w.repair_status = 'Completed' THEN 1 END) * 100.0
     / COUNT(w.claim_id) AS DECIMAL(10,2)) AS completion_pct
FROM Myportoproject..warranty w
JOIN Myportoproject..sales s ON w.sale_id = s.sale_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
      AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY c.category_name
ORDER BY total_claims DESC;

-- claim rate
SELECT
    c.category_name,
    COUNT(s.sale_id) AS total_transactions,
    COUNT(w.claim_id) AS total_claims,
    CAST(COUNT(w.claim_id) * 100.0 / COUNT(s.sale_id) AS DECIMAL(10,2)) AS claim_rate_pct
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
LEFT JOIN Myportoproject..warranty w ON s.sale_id = w.sale_id
WHERE TRY_CAST(s.sale_date AS DATETIME) >= '2023-01-01'
  AND TRY_CAST(s.sale_date AS DATETIME) <  '2024-01-01'
GROUP BY c.category_name
ORDER BY claim_rate_pct DESC;

