-- ============================================================
-- SALES DATA ANALYSIS — SQL Queries
-- Author  : Hima Bindu
-- Dataset : sales_data (10,000 transactions, 2024)
-- Tools   : MySQL / PostgreSQL
-- ============================================================

-- ──────────────────────────────────────────────────────────
-- TABLE STRUCTURE
-- ──────────────────────────────────────────────────────────

CREATE TABLE sales_data (
    Transaction_ID   VARCHAR(10)    PRIMARY KEY,
    Date             DATE,
    Month            VARCHAR(15),
    Quarter          VARCHAR(5),
    Region           VARCHAR(20),
    Category         VARCHAR(30),
    Product          VARCHAR(30),
    Unit_Price       DECIMAL(10,2),
    Quantity         INT,
    Discount_Percent INT,
    Discount_Amount  DECIMAL(10,2),
    Revenue          DECIMAL(12,2),
    Payment_Method   VARCHAR(20),
    Salesperson_ID   VARCHAR(10),
    Customer_ID      VARCHAR(10)
);

-- ──────────────────────────────────────────────────────────
-- SECTION 1: BASIC OVERVIEW
-- ──────────────────────────────────────────────────────────

-- Q1: Total number of transactions
SELECT COUNT(*) AS Total_Transactions
FROM sales_data;

-- Q2: Overall KPIs — Total Revenue, Orders, Avg Order Value, Units Sold
SELECT
    COUNT(Transaction_ID)        AS Total_Orders,
    ROUND(SUM(Revenue), 2)       AS Total_Revenue,
    ROUND(AVG(Revenue), 2)       AS Avg_Order_Value,
    SUM(Quantity)                AS Total_Units_Sold,
    ROUND(SUM(Discount_Amount),2) AS Total_Discount_Given
FROM sales_data;

-- Q3: Date range of the dataset
SELECT
    MIN(Date) AS Start_Date,
    MAX(Date) AS End_Date
FROM sales_data;

-- ──────────────────────────────────────────────────────────
-- SECTION 2: REVENUE BY CATEGORY
-- ──────────────────────────────────────────────────────────

-- Q4: Total revenue, orders, and average order value by category
SELECT
    Category,
    COUNT(Transaction_ID)         AS Total_Orders,
    SUM(Quantity)                 AS Total_Units_Sold,
    ROUND(SUM(Revenue), 2)        AS Total_Revenue,
    ROUND(AVG(Revenue), 2)        AS Avg_Order_Value,
    ROUND(SUM(Discount_Amount),2) AS Total_Discount
FROM sales_data
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- Q5: Revenue contribution % by category
SELECT
    Category,
    ROUND(SUM(Revenue), 2) AS Category_Revenue,
    ROUND(
        SUM(Revenue) * 100.0 / (SELECT SUM(Revenue) FROM sales_data), 2
    ) AS Revenue_Percentage
FROM sales_data
GROUP BY Category
ORDER BY Revenue_Percentage DESC;

-- ──────────────────────────────────────────────────────────
-- SECTION 3: REVENUE BY REGION
-- ──────────────────────────────────────────────────────────

-- Q6: Total revenue and orders by region
SELECT
    Region,
    COUNT(Transaction_ID)   AS Total_Orders,
    SUM(Quantity)           AS Total_Units_Sold,
    ROUND(SUM(Revenue), 2)  AS Total_Revenue,
    ROUND(AVG(Revenue), 2)  AS Avg_Order_Value
FROM sales_data
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- Q7: Revenue by Region and Category (cross-analysis)
SELECT
    Region,
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    COUNT(Transaction_ID)  AS Total_Orders
FROM sales_data
GROUP BY Region, Category
ORDER BY Region, Total_Revenue DESC;

-- ──────────────────────────────────────────────────────────
-- SECTION 4: MONTHLY TREND ANALYSIS
-- ──────────────────────────────────────────────────────────

-- Q8: Monthly revenue and orders
SELECT
    Month,
    COUNT(Transaction_ID)  AS Total_Orders,
    SUM(Quantity)          AS Total_Units,
    ROUND(SUM(Revenue), 2) AS Monthly_Revenue,
    ROUND(AVG(Revenue), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Month
ORDER BY MIN(Date);

-- Q9: Quarterly revenue comparison
SELECT
    Quarter,
    COUNT(Transaction_ID)  AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Avg_Revenue_Per_Order
FROM sales_data
GROUP BY Quarter
ORDER BY Quarter;

-- ──────────────────────────────────────────────────────────
-- SECTION 5: PRODUCT PERFORMANCE
-- ──────────────────────────────────────────────────────────

-- Q10: Top 10 best-selling products by revenue
SELECT
    Product,
    Category,
    COUNT(Transaction_ID)  AS Total_Orders,
    SUM(Quantity)          AS Total_Units_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM sales_data
GROUP BY Product, Category
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Q11: Bottom 5 products by revenue (underperformers)
SELECT
    Product,
    Category,
    COUNT(Transaction_ID)  AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM sales_data
GROUP BY Product, Category
ORDER BY Total_Revenue ASC
LIMIT 5;

-- ──────────────────────────────────────────────────────────
-- SECTION 6: DISCOUNT ANALYSIS
-- ──────────────────────────────────────────────────────────

-- Q12: Revenue impact by discount percentage
SELECT
    Discount_Percent,
    COUNT(Transaction_ID)         AS Total_Orders,
    ROUND(SUM(Revenue), 2)        AS Total_Revenue,
    ROUND(AVG(Revenue), 2)        AS Avg_Order_Value,
    ROUND(SUM(Discount_Amount),2) AS Total_Discount_Given
FROM sales_data
GROUP BY Discount_Percent
ORDER BY Discount_Percent;

-- ──────────────────────────────────────────────────────────
-- SECTION 7: PAYMENT METHOD ANALYSIS
-- ──────────────────────────────────────────────────────────

-- Q13: Orders and revenue by payment method
SELECT
    Payment_Method,
    COUNT(Transaction_ID)  AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- ──────────────────────────────────────────────────────────
-- SECTION 8: ADVANCED QUERIES (JOINs & SUBQUERIES)
-- ──────────────────────────────────────────────────────────

-- Q14: Customers with above-average order value (Subquery)
SELECT
    Customer_ID,
    COUNT(Transaction_ID)  AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Spent,
    ROUND(AVG(Revenue), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Customer_ID
HAVING AVG(Revenue) > (SELECT AVG(Revenue) FROM sales_data)
ORDER BY Total_Spent DESC
LIMIT 10;

-- Q15: Best performing salesperson by revenue (using GROUP BY + ORDER BY)
SELECT
    Salesperson_ID,
    COUNT(Transaction_ID)  AS Total_Orders,
    SUM(Quantity)          AS Total_Units_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Avg_Order_Value
FROM sales_data
GROUP BY Salesperson_ID
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Q16: Month-over-month revenue growth using subquery
SELECT
    curr.Month,
    curr.Monthly_Revenue,
    prev.Monthly_Revenue                                              AS Prev_Month_Revenue,
    ROUND(curr.Monthly_Revenue - prev.Monthly_Revenue, 2)            AS Revenue_Change,
    ROUND(
        (curr.Monthly_Revenue - prev.Monthly_Revenue)
        * 100.0 / NULLIF(prev.Monthly_Revenue, 0), 2
    )                                                                 AS Growth_Pct
FROM (
    SELECT Month, MIN(Date) AS Month_Date,
           ROUND(SUM(Revenue), 2) AS Monthly_Revenue
    FROM sales_data
    GROUP BY Month
) curr
LEFT JOIN (
    SELECT Month, MIN(Date) AS Month_Date,
           ROUND(SUM(Revenue), 2) AS Monthly_Revenue
    FROM sales_data
    GROUP BY Month
) prev
  ON curr.Month_Date = prev.Month_Date + INTERVAL '1 month'
ORDER BY curr.Month_Date;

-- Q17: Category performance ranked within each region (Window Function)
SELECT
    Region,
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    RANK() OVER (
        PARTITION BY Region
        ORDER BY SUM(Revenue) DESC
    ) AS Revenue_Rank_In_Region
FROM sales_data
GROUP BY Region, Category
ORDER BY Region, Revenue_Rank_In_Region;

-- ──────────────────────────────────────────────────────────
-- SECTION 9: KEY BUSINESS INSIGHTS (SUMMARY QUERIES)
-- ──────────────────────────────────────────────────────────

-- Q18: Identify top revenue-driving category per region
SELECT
    Region,
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM sales_data
GROUP BY Region, Category
HAVING SUM(Revenue) = (
    SELECT MAX(reg_cat.cat_rev)
    FROM (
        SELECT Region AS r, Category AS c, SUM(Revenue) AS cat_rev
        FROM sales_data
        GROUP BY Region, Category
    ) reg_cat
    WHERE reg_cat.r = sales_data.Region
)
ORDER BY Region;

-- Q19: High-value transactions (revenue above 75th percentile)
SELECT
    Transaction_ID, Date, Region, Category, Product,
    Quantity, Unit_Price, Revenue
FROM sales_data
WHERE Revenue > (
    SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Revenue)
    FROM sales_data
)
ORDER BY Revenue DESC
LIMIT 20;

-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================
