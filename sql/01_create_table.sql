-- ============================================================
-- Superstore Sales Analysis - PostgreSQL Scripts
-- Table: superstore_sales
-- ============================================================

-- 1. Create the table

DROP TABLE IF EXISTS superstore_sales;

CREATE TABLE superstore_sales (
    row_id              INTEGER PRIMARY KEY,
    order_id            VARCHAR(20) NOT NULL,
    order_date          DATE NOT NULL,
    ship_date           DATE NOT NULL,
    ship_mode           VARCHAR(20),
    customer_id         VARCHAR(15),
    customer_name       VARCHAR(50),
    segment             VARCHAR(20),
    country             VARCHAR(30),
    city                VARCHAR(50),
    state               VARCHAR(30),
    postal_code         INTEGER,
    region              VARCHAR(15),
    product_id          VARCHAR(20),
    category            VARCHAR(30),
    sub_category        VARCHAR(30),
    product_name        TEXT,
    sales               NUMERIC(12, 4),
    order_year          INTEGER,
    order_month         INTEGER,
    order_month_name    VARCHAR(15),
    order_quarter       INTEGER,
    order_dayofweek     VARCHAR(15),
    shipping_days       INTEGER
);

--  Add indexes for better query performance
CREATE INDEX idx_order_date ON superstore_sales(order_date);
CREATE INDEX idx_region ON superstore_sales(region);
CREATE INDEX idx_category ON superstore_sales(category);
CREATE INDEX idx_segment ON superstore_sales(segment);
CREATE INDEX idx_customer_id ON superstore_sales(customer_id);
CREATE INDEX idx_order_year ON superstore_sales(order_year);

COMMENT ON TABLE superstore_sales IS 'Cleaned Superstore sales data for analysis (2015-2018)';
