-- ============================================================
-- Superstore Sales - SQL Analysis Queries
-- Run these after the table is created and data is loaded
-- ============================================================


-- ------------------------------------------------------------
-- 1. HIGH-LEVEL KPIs
-- ------------------------------------------------------------
SELECT
    COUNT(*)                            AS total_line_items,
    COUNT(DISTINCT order_id)            AS total_orders,
    COUNT(DISTINCT customer_id)         AS total_customers,
    COUNT(DISTINCT product_id)          AS total_products,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND(AVG(sales)::NUMERIC, 2)       AS avg_line_sales,
    ROUND( (SUM(sales) / COUNT(DISTINCT order_id))::NUMERIC, 2 ) AS avg_order_value
FROM superstore_sales;


-- ------------------------------------------------------------
-- 2. SALES BY YEAR
-- ------------------------------------------------------------
SELECT
    order_year,
    COUNT(DISTINCT order_id)            AS orders,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND(AVG(sales)::NUMERIC, 2)       AS avg_sales
FROM superstore_sales
GROUP BY order_year
ORDER BY order_year;


-- ------------------------------------------------------------
-- 3. YEAR-OVER-YEAR GROWTH
-- ------------------------------------------------------------
WITH yearly AS (
    SELECT
        order_year,
        SUM(sales) AS total_sales
    FROM superstore_sales
    GROUP BY order_year
)
SELECT
    order_year,
    ROUND(total_sales::NUMERIC, 2) AS total_sales,
    ROUND(
        ( (total_sales - LAG(total_sales) OVER (ORDER BY order_year))
          / LAG(total_sales) OVER (ORDER BY order_year) * 100 )::NUMERIC
    , 2) AS yoy_growth_pct
FROM yearly
ORDER BY order_year;


-- ------------------------------------------------------------
-- 4. SALES BY REGION
-- ------------------------------------------------------------
SELECT
    region,
    COUNT(DISTINCT order_id)            AS orders,
    COUNT(DISTINCT customer_id)         AS customers,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND( (SUM(sales) * 100.0 / SUM(SUM(sales)) OVER ())::NUMERIC, 1 ) AS pct_of_total
FROM superstore_sales
GROUP BY region
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 5. TOP 10 STATES BY SALES
-- ------------------------------------------------------------
SELECT
    state,
    region,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    COUNT(DISTINCT order_id)      AS orders
FROM superstore_sales
GROUP BY state, region
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 6. SALES BY CUSTOMER SEGMENT
-- ------------------------------------------------------------
SELECT
    segment,
    COUNT(DISTINCT customer_id)         AS customers,
    COUNT(DISTINCT order_id)            AS orders,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND( (SUM(sales) * 100.0 / SUM(SUM(sales)) OVER ())::NUMERIC, 1 ) AS pct_of_total
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 7. SALES BY CATEGORY
-- ------------------------------------------------------------
SELECT
    category,
    COUNT(*)                            AS line_items,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND(AVG(sales)::NUMERIC, 2)       AS avg_sales,
    ROUND( (SUM(sales) * 100.0 / SUM(SUM(sales)) OVER ())::NUMERIC, 1 ) AS pct_of_total
FROM superstore_sales
GROUP BY category
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 8. SALES BY SUB-CATEGORY
-- ------------------------------------------------------------
SELECT
    category,
    sub_category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    COUNT(*)                      AS line_items
FROM superstore_sales
GROUP BY category, sub_category
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 9. TOP 10 PRODUCTS BY SALES
-- ------------------------------------------------------------
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    COUNT(*)                      AS times_sold
FROM superstore_sales
GROUP BY product_id, product_name, category, sub_category
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 10. TOP 10 CUSTOMERS BY SALES
-- ------------------------------------------------------------
SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id)      AS orders,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM superstore_sales
GROUP BY customer_id, customer_name, segment
ORDER BY total_sales DESC
LIMIT 10;


-- ------------------------------------------------------------
-- 11. SHIPPING ANALYSIS
-- ------------------------------------------------------------
SELECT
    ship_mode,
    COUNT(*)                            AS line_items,
    COUNT(DISTINCT order_id)            AS orders,
    ROUND(SUM(sales)::NUMERIC, 2)       AS total_sales,
    ROUND(AVG(shipping_days)::NUMERIC, 2) AS avg_shipping_days,
    MIN(shipping_days)                  AS min_days,
    MAX(shipping_days)                  AS max_days
FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;


-- ------------------------------------------------------------
-- 12. MONTHLY SALES TREND
-- ------------------------------------------------------------
SELECT
    order_year,
    order_month,
    order_month_name,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    COUNT(DISTINCT order_id)      AS orders
FROM superstore_sales
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;


-- ------------------------------------------------------------
-- 13. SALES BY REGION AND CATEGORY (cross analysis)
-- ------------------------------------------------------------
SELECT
    region,
    category,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM superstore_sales
GROUP BY region, category
ORDER BY region, total_sales DESC;


-- ------------------------------------------------------------
-- 14. QUARTERLY PERFORMANCE
-- ------------------------------------------------------------
SELECT
    order_year,
    order_quarter,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales,
    COUNT(DISTINCT order_id)      AS orders
FROM superstore_sales
GROUP BY order_year, order_quarter
ORDER BY order_year, order_quarter;


-- ------------------------------------------------------------
-- 15. AVERAGE SHIPPING DAYS BY REGION
-- ------------------------------------------------------------
SELECT
    region,
    ROUND(AVG(shipping_days)::NUMERIC, 2) AS avg_shipping_days,
    COUNT(*) AS line_items
FROM superstore_sales
GROUP BY region
ORDER BY avg_shipping_days;


-- ------------------------------------------------------------
-- 16. BEST AND WORST MONTHS (overall)
-- ------------------------------------------------------------
SELECT
    order_month_name,
    ROUND(SUM(sales)::NUMERIC, 2) AS total_sales
FROM superstore_sales
GROUP BY order_month, order_month_name
ORDER BY total_sales DESC;
