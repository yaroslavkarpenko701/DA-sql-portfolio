# Data Analytics Portfolio: SQL Projects

Welcome to my portfolio! Here you will find practical SQL queries and scripts developed to solve real-world business problems using data analytics techniques (BigQuery).

---

## Projects Overview

### 1. [Emails Sent by Month](./Emails%20Sent%20by%20Month/)
* **Description:** Calculates the percentage of emails received by each account out of the total monthly volume, and determines the first and last email dispatch dates per client.
* **Key Skills:** Window functions (`OVER (PARTITION BY)`), date transformations (`DATE_TRUNC`, `DATE_ADD`, `INTERVAL`), subqueries, aggregation (`COUNT`, `MIN`, `MAX`).

### 2. [Prediction Fulfillment with CTE](./Prediction%20Fulfillment%20with%20CTE/)
* **Description:** Analyzes cumulative revenues and compares them against projected targets (`predict`) on a daily basis, calculating the exact target fulfillment percentage.
* **Key Skills:** Common Table Expressions (CTE), `UNION ALL`, running totals using cumulative window functions (`SUM() OVER(ORDER BY)`), data aggregation.

### 3. [Aggregated Data with SQL Views](./Aggregated%20Data%20with%20SQL%20Views/)
* **Description:** Encapsulates complex multi-table analytical logic into a reusable virtual table (`CREATE VIEW`) for streamlined reporting and data sharing.
* **Key Skills:** DDL statements (`CREATE VIEW`), encapsulating CTEs and joins.
