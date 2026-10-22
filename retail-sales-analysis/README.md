# Retail Sales Analysis — SQL Server & Power BI

A beginner data analyst portfolio project using a small **synthetic practice dataset**. It demonstrates SQL analysis and provides a dataset for an Excel/Power BI dashboard.

## Business questions
- What are total revenue and units sold?
- Which products and regions generate the most revenue?
- Which product leads in each region?
- Which regions meet transaction-count and average-revenue criteria?
- What data-quality checks should be performed?

## Tools
- Microsoft SQL Server (T-SQL)
- Excel
- Microsoft Power BI

## Repository structure
- `data/sales_data.csv` — dataset
- `sql/retail_sales_analysis.sql` — SQL Server table definition and analysis queries
- `docs/data_dictionary.md` — column definitions
- `docs/key_findings.md` — sample findings and limitations

## Dataset
Each row is a transaction line. Revenue is `Quantity × UnitPrice`; currency is INR. The data is synthetic, not real company data.

## How to use
1. Create/select a SQL Server practice database.
2. Run the table-creation section in `sql/retail_sales_analysis.sql`.
3. Import `data/sales_data.csv` into `dbo.SalesData`, matching the column names.
4. Run the analysis queries individually.
5. Import the CSV into Power BI and build KPI cards, product/region charts, a matrix, and Product/Region slicers.

Suggested DAX:
```DAX
Total Revenue = SUM(SalesData[Revenue])
Total Units Sold = SUM(SalesData[Quantity])
Transaction Count = COUNTROWS(SalesData)
Average Transaction Revenue = AVERAGE(SalesData[Revenue])
```

## Sample results
- Total revenue: ₹223,000
- Units sold: 20
- Revenue by region: Bangalore ₹126,000; Chennai ₹97,000
- Revenue by product: Laptop ₹145,000; Mobile ₹55,000; Monitor ₹12,000; Headphones ₹11,000

## Resume entry — edit to reflect what you personally completed
**Retail Sales Analysis | SQL Server, Excel, Power BI**
- Analyzed a sample retail dataset using SQL aggregation, `GROUP BY`, `HAVING`, CTEs and window functions.
- Built a Power BI dashboard with revenue KPIs, product/region charts and interactive slicers.
- Summarized product and regional revenue patterns and documented data-quality checks.

Only claim the dashboard bullet if you have completed and saved the Power BI report yourself. If you have a `.pbix` file, add it to the repository if it is within GitHub's file-size limits, or include a dashboard screenshot.

## GitHub checklist
- [ ] Create a repository named `retail-sales-analysis`
- [ ] Upload all files in this folder
- [ ] Add your Power BI `.pbix` or screenshot, if available
- [ ] Verify the README and links
- [ ] Add the repository URL to your resume and LinkedIn
