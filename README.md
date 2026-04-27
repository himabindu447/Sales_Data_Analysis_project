# 📊 Sales Data Analysis Project

**Author:** Hima Bindu  
**Tools:** Python | SQL | Excel | Power BI  
**Dataset:** 10,000 Sales Transactions (2024)

---

## 📁 Project Structure

```
sales-data-analysis/
│
├── sales_data.csv                  ← Raw dataset (10,000 records)
├── Sales_Data_Analysis.xlsx        ← Excel workbook (5 sheets with charts)
├── Sales_Data_Analysis.py          ← Python EDA & visualization script
├── Sales_Data_Analysis.sql         ← SQL queries (19 queries)
├── sales_analysis_charts.png       ← Python-generated charts
├── Sales_Dashboard_PowerBI.pbix    ← Power BI dashboard file
└── README.md
```

---

## 🎯 Objective

Analyze 10,000+ sales transaction records to:
- Identify revenue trends by category, region, and month
- Uncover top-performing products and underperformers
- Build interactive dashboards for business decision-making
- Provide actionable insights to support data-driven strategy

---

## 📊 Dataset Description

| Column | Description |
|--------|-------------|
| Transaction_ID | Unique transaction identifier |
| Date | Transaction date (2024) |
| Month / Quarter | Time dimensions |
| Region | North, South, East, West, Central |
| Category | Electronics, Clothing, Furniture, Food & Beverages, Sports & Outdoors |
| Product | Product name within each category |
| Unit_Price | Price per unit (₹) |
| Quantity | Number of units sold |
| Discount_Percent | Discount applied (0%, 5%, 10%, 15%, 20%) |
| Discount_Amount | Discount value in ₹ |
| Revenue | Final revenue after discount |
| Payment_Method | Credit Card, Debit Card, UPI, Net Banking, Cash |
| Salesperson_ID | Salesperson identifier |
| Customer_ID | Customer identifier |

---

## 🧹 Data Cleaning Steps

- ✅ Checked for null values → **0 null values found**
- ✅ Checked for duplicates → **0 duplicate Transaction IDs**
- ✅ Converted Date column to datetime format
- ✅ Validated Revenue for negative values → **None found**
- ✅ Verified Discount % range → **Valid tiers: 0, 5, 10, 15, 20**
- ✅ Confirmed Category and Region consistency → **No misspellings**

---

## 🔍 Key Insights

1. **Electronics** is the highest revenue category — contributing over **49% of total revenue**
2. **North region** leads in sales performance
3. **Laptop and Smart TV** are the top revenue-generating products
4. **Food & Beverages** is the lowest revenue category — needs pricing/promotion review
5. Revenue is fairly consistent month-over-month with slight peaks in certain quarters

---

## 📈 Excel Workbook Sheets

| Sheet | Contents |
|-------|----------|
| Sales_Data | Full raw dataset (10,000 rows) |
| Revenue_by_Category | Summary table + bar chart |
| Revenue_by_Region | Summary table + bar chart |
| Monthly_Trend | Month-wise revenue + line chart |
| Data_Cleaning_Log | Step-by-step cleaning documentation |

---

## 🐍 Python Analysis

Run the Python script:
```bash
pip install pandas numpy matplotlib seaborn openpyxl
python Sales_Data_Analysis.py
```

Generates:
- Data cleaning validation report
- EDA summary with key metrics
- 6-panel visualization chart saved as `sales_analysis_charts.png`
- Business insights and recommendations

---

## 🗄️ SQL Queries Covered

- Basic KPIs (total revenue, orders, avg order value)
- Revenue by Category, Region, Product
- Monthly & Quarterly trend analysis
- Discount impact analysis
- Payment method distribution
- Advanced: Subqueries, Window Functions (RANK, PERCENTILE)
- Month-over-month growth calculation

---

## 📊 Power BI Dashboard

The `.pbix` file contains:
- **KPI Cards:** Total Revenue, Total Orders, Avg Order Value, Units Sold
- **Bar Chart:** Revenue by Category
- **Map Visual:** Revenue by Region
- **Line Chart:** Monthly Revenue Trend
- **Donut Chart:** Payment Method Distribution
- **Slicers:** Region, Category, Quarter, Month filters

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data cleaning, EDA |
| Python (Matplotlib, Seaborn) | Data visualization |
| SQL | Data querying and aggregation |
| Excel | Data summary, pivot tables, charts |
| Power BI | Interactive dashboard creation |

---

## 📬 Connect

- LinkedIn: [linkedin.com/in/himabindu-s](https://linkedin.com/in/himabindu-s)
- GitHub: [github.com/himabindu447](https://github.com/himabindu447)
- Email: himabindu7503@gmail.com
