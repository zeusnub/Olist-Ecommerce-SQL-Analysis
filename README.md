# Olist E-Commerce Analysis with SQL

An end-to-end SQL analysis of the Brazilian **Olist** e-commerce marketplace: sales trends, customer behaviour, delivery performance, and customer satisfaction. 33 queries across 8 tables, from basic filtering to joins, CTEs and customer segmentation.

> **Tools:** MySQL 8 · MySQL Workbench
> **Dataset:** [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
> **Dashboard:** [TODO: add link, or remove this line]

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
olist-sql-analysis/
├── README.md
├── sql/
│   ├── 01_SQL_Fundamentals.sql
│   ├── 02_Aggregations_Filtering.sql
│   ├── 03_Joins_Business_Analysis.sql
│   └── 04_Advanced_Business_Analytics.sql
└── images/            # screenshots of results and the dashboard
```

| File | Queries | Topics |
|---|---|---|
| `01_SQL_Fundamentals.sql` | 1-8 | `SELECT`, `WHERE`, `DISTINCT`, `ORDER BY`, `LIMIT`, `NULL` checks |
| `02_Aggregations_Filtering.sql` | 9-16 | `COUNT`, `SUM`, `AVG`, `GROUP BY`, `HAVING` |
| `03_Joins_Business_Analysis.sql` | 17-26 | Multi-table `INNER JOIN`, subqueries, revenue, ratings, payments |
| `04_Advanced_Business_Analytics.sql` | 27-33 | Date functions, `CASE WHEN`, CTEs, delivery analysis, customer segmentation |

---

## Key Findings

> **TODO:** Run the queries, then replace each placeholder with a real result from your own output. Delete any row you can't back up with a number.

| Question | Query | Finding |
|---|---|---|
| How does monthly revenue change? | 27 | [TODO: e.g. trend, peak month] |
| Which categories earn the most? | 18 | [TODO: top 3 categories and their share] |
| Which states have the slowest delivery? | 28 | [TODO: slowest states and average days] |
| What share of orders arrive late? | 29 | [TODO: late delivery %] |
| Do late deliveries lower review scores? | 32 | [TODO: average score late vs on time] |
| How many customers order more than once? | 31 | [TODO: repeat customer %] |
| Who are the most valuable customers? | 33 | [TODO: segment sizes or top spend] |

**Recommendation:** [TODO: one or two sentences on what the business should do based on these findings.]

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
4. Run the files in the `sql/` folder in order, one query at a time.

---

## Skills Demonstrated

- Writing and reading multi-table SQL (joins across up to 4 tables)
- Aggregation, grouping and filtering with `HAVING`
- Subqueries and CTEs
- Conditional logic with `CASE WHEN` for segmentation
- Date calculations for delivery-time analysis
- Spotting and handling data-quality issues (duplicate keys, NULLs, double counting)
- Turning query results into business recommendations

---

## Limitations

- The data covers 2016-2018 and is a sample of one marketplace, so results may not reflect current behaviour.
- Customer segments in query 33 use simple thresholds (spend and order count) chosen for illustration, not a statistical model.

---

## About

**[TODO: Your Name]**
Computer Science (Data Science) student
[LinkedIn: TODO] · [GitHub: TODO] · [Email: TODO]

*Dataset credit: Olist and the Kaggle community. Please check the dataset's license on Kaggle before reuse.*
