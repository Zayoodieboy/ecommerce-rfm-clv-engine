## 🔍 SQL Implementation & Analysis
Please take a look at the SQL analysis: 

```sql
-- E-Commerce RFM Customer Segmentation & CLV Engine
-- Author: Mid-Level Data Analyst & Marketing Strategist

-- Step 1 & 2: Database Schema & Sample Data Setup
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    signup_date DATE,
    acquisition_channel VARCHAR(50)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    order_amount DECIMAL(10, 2),
    product_category VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, signup_date, acquisition_channel) VALUES
(101, '2025-01-15', 'Paid Search'),
(102, '2025-02-10', 'Social'),
(103, '2025-03-01', 'Organic'),
(104, '2025-04-12', 'Paid Search'),
(105, '2025-05-20', 'Email'),
(106, '2025-06-05', 'Social');

INSERT INTO transactions (transaction_id, customer_id, transaction_date, order_amount, product_category) VALUES
(1, 101, '2025-01-20', 150.00, 'Apparel'),
(2, 101, '2025-04-10', 250.00, 'Footwear'),
(3, 101, '2026-01-05', 300.00, 'Apparel'),
(4, 101, '2026-09-15', 200.00, 'Accessories'),
(5, 102, '2025-02-15', 75.00, 'Apparel'),
(6, 102, '2025-06-20', 85.00, 'Footwear'),
(7, 102, '2026-03-10', 95.00, 'Apparel'),
(8, 103, '2025-03-05', 500.00, 'Footwear'),
(9, 103, '2025-03-12', 120.00, 'Accessories'),
(10, 104, '2026-09-01', 60.00, 'Apparel'),
(11, 104, '2026-10-01', 110.00, 'Footwear'),
(12, 105, '2025-05-25', 45.00, 'Accessories'),
(13, 106, '2025-06-10', 400.00, 'Footwear'),
(14, 106, '2025-08-15', 350.00, 'Apparel');

-- Step 3 & 4: Automated RFM Customer Segmentation Engine (The Core Analytical Query)
WITH customer_rfm AS (
    SELECT 
        c.customer_id,
        c.acquisition_channel,
        CAST(julianday('2026-10-12') - julianday(MAX(t.transaction_date)) AS INTEGER) AS recency_days,
        COUNT(t.transaction_id) AS frequency_count,
        SUM(t.order_amount) AS total_monetary_spend
    FROM customers c
    JOIN transactions t ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.acquisition_channel
)
SELECT 
    customer_id,
    acquisition_channel,
    recency_days,
    frequency_count,
    total_monetary_spend,
    CASE 
        WHEN frequency_count >= 3 AND total_monetary_spend >= 500 THEN 'Champions (VIP)'
        WHEN recency_days <= 400 AND frequency_count >= 2 THEN 'Loyal Customers'
        WHEN recency_days > 400 AND total_monetary_spend >= 400 THEN 'At-Risk High Value'
        ELSE 'Recent / Low Engagement'
    END AS customer_segment
FROM customer_rfm
ORDER BY total_monetary_spend DESC;
