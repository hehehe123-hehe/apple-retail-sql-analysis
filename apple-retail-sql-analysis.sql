/* ================================================================================
APPLE RETAIL DATA ANALYSIS REPORT (JAN 2023 - DEC 2023)
================================================================================
Description: Comprehensive analysis of sales performance, regional distribution, 
             and after-sales service quality.
Organized by: Business Functional Area
Database: Myportoproject
Author : Ruki
================================================================================ */

--------------------------------------------------------------------------------
-- SECTION 1: SALES & REVENUE PERFORMANCE (BY CATEGORY)
-- Focus: Understanding revenue drivers and top products within the 2023 fiscal year.
--------------------------------------------------------------------------------

-- 1.1 Revenue per Category
 SELECT
    c.category_name,
    SUM(CAST(s.quantity AS INT)) AS total_units_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- 1.2 Recent Tablet Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Tablet'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.3 Recent Accessories Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Accessories'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.4 Recent Smartphone Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Smartphone'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.5 Recent Audio Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Audio'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.6 Recent Laptop Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Laptop'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.7 Recent Wearable Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Wearable'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.8 Recent Desktop Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name = 'Desktop'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.9 Recent Subscription Service Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name LIKE '%Sub%'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.10 Recent Streaming Device Service Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name LIKE '%Stream%'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 1.11 Recent Smart Speaker Service Performance (2023)
SELECT TOP 10
    p.product_name,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold,
    SUM(CAST(s.quantity AS DECIMAL(10,2)) * p.price) AS total_revenue
FROM Myportoproject..sales s
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE c.category_name LIKE '%Speaker%'
    AND TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_revenue DESC;


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
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
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
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY st.City
ORDER BY total_revenue DESC;

-- 2.3 Top 10 Stores by Transaction Volume
SELECT TOP 10
    st.store_name, 
    st.city,
    COUNT(s.sale_id) AS total_transactions,
    SUM(CAST(s.quantity AS INT)) AS total_items_sold
FROM Myportoproject..sales s
JOIN Myportoproject..stores st ON s.store_id = st.store_id
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY st.store_name, st.city
ORDER BY total_items_sold DESC;


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
LEFT JOIN Myportoproject..warranty w ON s.sale_id = w.sale_id
WHERE w.claim_id IS NOT NULL and 
    TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY p.product_name
ORDER BY total_claims DESC;

-- 3.2 Average Days to Claim (Reliability Metric)
SELECT
    c.category_name,
    AVG(DATEDIFF(DAY, TRY_CAST(s.sale_date AS DATETIME), w.claim_date)) AS avg_days_to_claim,
    COUNT(w.claim_id) AS total_claims
FROM Myportoproject..sales s
JOIN Myportoproject..warranty w ON s.sale_id = w.sale_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY c.category_name
ORDER BY avg_days_to_claim ASC;

-- 3.3 Repair Operations Efficiency (Pivot View)
SELECT 
    c.category_name,
    COUNT(CASE WHEN w.repair_status = 'Pending' THEN 1 END) AS [Pending],
    COUNT(CASE WHEN w.repair_status = 'In Progress' THEN 1 END) AS [In Progress],
    COUNT(CASE WHEN w.repair_status = 'Completed' THEN 1 END) AS [Completed],
    COUNT(CASE WHEN w.repair_status = 'Rejected' THEN 1 END) AS [Rejected],
    CAST(COUNT(claim_id) * 100.0 / SUM(COUNT(claim_id)) OVER() AS DECIMAL(10,2)) AS persentase,
    COUNT(w.claim_id) AS total_claims
FROM Myportoproject..warranty w
JOIN Myportoproject..sales s ON w.sale_id = s.sale_id
JOIN Myportoproject..products p ON s.product_id = p.product_id
JOIN Myportoproject..category c ON p.category_id = c.category_id
WHERE TRY_CAST(s.sale_date AS DATETIME) > '2022-12-31'
GROUP BY c.category_name
ORDER BY total_claims DESC;