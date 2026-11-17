-- ============================================================
-- Load cleaned data into superstore_sales table
-- ============================================================


\copy superstore_sales (row_id, order_id, order_date, ship_date, ship_mode, customer_id, customer_name, segment, country, city, 
state, postal_code, region, product_id, category, sub_category, product_name, sales,
 order_year, order_month, order_month_name, order_quarter, order_dayofweek, shipping_days) 
FROM '/home/ahmed/Documents/projects/DataProject/cleaned_data/superstore_for_sql.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- Verify the load
SELECT COUNT(*) AS total_rows FROM superstore_sales;
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order FROM superstore_sales;
SELECT SUM(sales) AS total_sales FROM superstore_sales;
