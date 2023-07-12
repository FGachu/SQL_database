# Company Database Setup and SQL Queries

This repository contains the SQL code and database setup instructions for creating and manipulating a company database. The SQL statements provided cover table creation, data insertion, data transformation, and various SQL queries.

## Database Structure

The database consists of several tables:
- **employee**: Contains employee details such as first_name, emp_id, last_name, birth_date, sex, salary, supplier_id, and branch_id.
- **branch**: Stores information about branches including branch_id, branch_name, mgr_start_date, and mgr_id.
- **client**: Stores client information with columns client_id, client_name, and branch_id.
- **works_with**: Tracks the relationship between employees and clients, including emp_id, client_id, and total_sales.
- **branch_supplier**: Contains information about suppliers for each branch, including branch_id, supplier_name, and supply_type.

## SQL Queries

The SQL code includes various queries that demonstrate data manipulation and retrieval. Some examples include:
- Aggregation queries to calculate sums or counts based on specific conditions.
- Wildcard queries using the LIKE operator to search for patterns in data.
- UNION queries to combine and retrieve distinct values from multiple tables.
- JOIN queries to retrieve information from multiple tables based on common columns.



