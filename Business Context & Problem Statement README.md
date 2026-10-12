# 🛒 E-Commerce RFM & CLV Segmentation Engine

## 📊 Business Context & Problem Statement
* **Company:** Mid-sized global e-commerce apparel and lifestyle brand.
* **The Problem:** The marketing team is running broad acquisition campaigns with a fixed budget. However, they are treating a one-time buyer who spent $20 the exact same way as a repeat VIP customer who has spent $1,200 over the past year. 
* **The Objective:** Build an end-to-end SQL data pipeline that ingests relational transaction data, calculates **Recency, Frequency, and Monetary (RFM)** scores, and automatically segments customers into actionable marketing tiers (*Champions, At-Risk, Loyal*) to optimize retention budgets.

---

## 💻 Tech Stack & Tools
* **Database Management:** DB Browser for SQLite
* **Query Language:** SQL (CTEs, Window Functions, Conditional Aggregation, Date Math)
* **Version Control:** GitHub

## 🔍 SQL Implementation & Analysis
Please take a look at the SQL analysis on the next file (`rfm_segmentation_query.sql`)

---

## Results & Business Impact
When executed against the relational dataset, the segmentation engine successfully classifies customers into behavioral tiers:

| customer_id | acquisition_channel | recency_days | frequency_count | total_monetary_spend | customer_segment |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | Paid Search | 27 | 4 | $900.00 | 🏆 Champions (VIP) |
| 106 | Social | 424 | 2 | $750.00 | ⚠️ At-Risk High Value |
| 103 | Organic | 586 | 2 | $620.00 | ⚠️ At-Risk High Value |
| 102 | Social | 216 | 3 | $255.00 | ⭐ Loyal Customers |
| 104 | Paid Search | 11 | 2 | $170.00 | ⭐ Loyal Customers |
| 105 | Email | 505 | 1 | $45.00 | 🌱 Recent / Low Engagement |

**Strategic Takeaway:** 
Instead of spending generic acquisition budget, marketing can now instantly target Customer 106 with an automated win-back campaign to protect high-value revenue.
