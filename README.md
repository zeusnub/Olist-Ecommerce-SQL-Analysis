# Olist E-Commerce Analysis: SQL + Power BI Dashboard

An end-to-end analysis of the Brazilian **Olist** e-commerce marketplace: sales trends, customer behaviour, delivery performance, and customer satisfaction. 33 SQL queries across 8 tables (basic filtering to joins, CTEs and customer segmentation), followed by an interactive **Power BI dashboard**.

> **Tools:** MySQL 8 · MySQL Workbench · Power BI Desktop
> **Dataset:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
> **Live dashboard:** [View the Power BI dashboard](ADD_DASHBOARD_LINK_HERE)

![Dashboard overview](images/dashboard_overview.png)

---

## Business Questions

This project answers questions a marketplace business would actually ask:

1. How does revenue change month by month?
2. Which product categories and sellers generate the most revenue?
3. Which states bring in the most customers and the most revenue?
4. How long do deliveries take, and what share arrive late?
5. Do late deliveries lead to lower review scores?
6. How many customers come back for a second order?
7. Who are the most valuable customers?

---

## Power BI Dashboard

The dashboard is built on the same MySQL database used for the SQL analysis, with four pages:

| Page | What it shows | Based on |
|---|---|---|
| **Overview** | Total revenue, total orders, average order value, monthly revenue trend | Queries 15, 21, 27 |
| **Products and Sellers** | Top categories and sellers by revenue, items sold, shipping cost | Queries 18, 19, 24, 30 |
| **Delivery and Satisfaction** | Average delivery days by state, late delivery %, review score for late vs. on-time orders | Queries 28, 29, 32 |
| **Customers** | Revenue by state, repeat-customer rate, customer value segments | Queries 20, 31, 33 |

Filters (such as year and state) let you slice every page interactively.

---

## Key Findings

- **Revenue trend (Query 27):** monthly revenue grew from about R$ 120K in January 2017 to a peak of about R$ 1.0M in November 2017 (+52% over October), then held at roughly R$ 850K-990K a month through mid-2018. January-August 2018 revenue was about 138% higher than the same months of 2017. Early 2016 data is sparse and September 2018 is a partial month, so both were excluded from the trend.

---

## Dataset

Real, anonymised order data from Olist covering roughly 100,000 orders placed between 2016 and 2018. I loaded the following 8 tables into a MySQL schema called `olist_ecommerce`:

| Table | Rows | What it holds |
|---|---|---|
| `customers` | 99,441 | One row per order's customer record, with city and state |
| `orders` | 99,441 | Order status and purchase, delivery and estimated delivery dates |
| `order_items` | 112,650 | Products in each order, with price and freight value |
| `order_payments` | 103,886 | Payment type, instalments and value |
| `order_reviews` | 99,224 | Review score and comments |
| `products` | 32,951 | Product category and size/weight details |
| `sellers` | 3,095 | Seller city and state |
| `category_translation` | 71 | Portuguese to English category names |

**How the tables connect:** `orders` links to `customers` (via `customer_id`), and to `order_items`, `order_payments` and `order_reviews` (via `order_id`). `order_items` links to `products` (via `product_id`) and `sellers` (via `seller_id`).

---

## Repository Structure

```
Olist-Ecommerce-SQL-Analysis/
├── README.md
├── 01_SQL_Fundamentals.sql
├── 02_Aggregations_Filtering.sql
├── 03_Joins_Business_Analysis.sql
├── 04_Advanced_Business_Analytics.sql
├── Olist_Dashboard.pbix
└── images/
```

| File | Queries | Topics |
|---|---|---|
| `01_SQL_Fundamentals.sql` | 1-8 | `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `LIMIT`, `NULL` checks |
| `02_Aggregations_Filtering.sql` | 9-16 | `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING` |
| `03_Joins_Business_Analysis.sql` | 17-26 | Multi-table `INNER JOIN`, subqueries, revenue, ratings, payments |
| `04_Advanced_Business_Analytics.sql` | 27-33 | Date functions, `CASE WHEN`, CTEs, delivery analysis, customer segmentation |
| `Olist_Dashboard.pbix` | n/a | Power BI report file |

---

## Data Notes and Decisions

- **Customers vs. orders:** `customer_id` is created for each order, so the same person can appear many times. `customer_unique_id` identifies the real customer and is used for repeat-customer analysis (queries 25, 31, 33).
- **Revenue definition:** revenue is item `price` and excludes freight. Queries 27 and 33 exclude `canceled` and `unavailable` orders. Earlier queries include all order statuses.
- **Delivery analysis:** queries 28, 29 and 32 only use delivered orders that have a delivery date.
- **Reviews:** `review_id` is not unique in the source data, so it isn't used as a primary key. Some review comments contain line breaks, which broke the MySQL Workbench import wizard, so the reviews table was loaded from a generated SQL script instead.
- **Missing categories:** some products have no category and don't match the translation table.

---

## How to Reproduce

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).
2. Create a schema: `CREATE DATABASE olist_ecommerce;`
3. Load the CSV files into tables with the names listed above (MySQL Workbench: **Server → Data Import**, or `LOAD DATA`).
4. Run the four `.sql` files in order, one query at a time.
5. Open `Olist_Dashboard.pbix` in Power BI Desktop (Windows) to explore the dashboard.

---

## Skills Demonstrated

- Writing and reading multi-table SQL (joins across up to 4 tables)
- Aggregation, grouping and filtering with `HAVING`
- Subqueries and CTEs
- Conditional logic with `CASE WHEN` for segmentation
- Date calculations for delivery-time analysis
- Spotting and handling data-quality issues (duplicate keys, NULLs, double counting)
- Building an interactive Power BI dashboard on a MySQL database
- Turning query results into business recommendations

---

## Limitations

- The data covers 2016-2018 and is a sample of one marketplace, so results may not reflect current behaviour.
- Customer segments in query 33 use simple thresholds (spend and order count) chosen for illustration, not a statistical model.

---

## About

**Ajith B**
Computer Science (Data Science) Graduate

[LinkedIn](https://www.linkedin.com/in/ajith-b-7549b2376) · [GitHub](https://github.com/zeusnub) · [Email](mailto:ajithbalachandran911@gmail.com)

*Dataset credit: Olist and the Kaggle community. Please check the dataset's license on Kaggle before reuse.*
