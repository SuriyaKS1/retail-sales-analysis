/*
Retail Sales Analysis — Microsoft SQL Server (T-SQL)
Import data/sales_data.csv into dbo.SalesData after creating this table.
*/
IF OBJECT_ID('dbo.SalesData', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.SalesData (
        Product VARCHAR(50) NOT NULL,
        Region VARCHAR(50) NOT NULL,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(12,2) NOT NULL,
        Revenue DECIMAL(14,2) NOT NULL
    );
END;
GO

-- 1. Overall KPIs
SELECT SUM(Revenue) AS TotalRevenue,
       SUM(Quantity) AS TotalUnitsSold,
       COUNT(*) AS TransactionCount,
       AVG(Revenue) AS AverageTransactionRevenue
FROM dbo.SalesData;

-- 2. Revenue by product
SELECT Product, SUM(Revenue) AS TotalRevenue,
       SUM(Quantity) AS UnitsSold, COUNT(*) AS TransactionCount
FROM dbo.SalesData
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- 3. Revenue by region
SELECT Region, SUM(Revenue) AS TotalRevenue,
       SUM(Quantity) AS UnitsSold, COUNT(*) AS TransactionCount
FROM dbo.SalesData
GROUP BY Region
ORDER BY TotalRevenue DESC;

-- 4. Product-region breakdown
SELECT Region, Product, SUM(Revenue) AS TotalRevenue,
       SUM(Quantity) AS UnitsSold
FROM dbo.SalesData
GROUP BY Region, Product
ORDER BY Region, TotalRevenue DESC;

-- 5. Regions with at least 2 transactions and average transaction revenue > 25,000
SELECT Region, SUM(Revenue) AS TotalRevenue,
       AVG(Revenue) AS AverageTransactionRevenue, COUNT(*) AS TransactionCount
FROM dbo.SalesData
GROUP BY Region
HAVING COUNT(*) >= 2 AND AVG(Revenue) > 25000
ORDER BY SUM(Revenue) DESC;

-- 6. Highest-revenue product in each region (ties retained)
WITH ProductRegionRevenue AS (
    SELECT Region, Product, SUM(Revenue) AS TotalRevenue
    FROM dbo.SalesData
    GROUP BY Region, Product
),
RankedProducts AS (
    SELECT Region, Product, TotalRevenue,
           RANK() OVER (PARTITION BY Region ORDER BY TotalRevenue DESC) AS RevenueRank
    FROM ProductRegionRevenue
)
SELECT Region, Product, TotalRevenue
FROM RankedProducts
WHERE RevenueRank = 1
ORDER BY Region;

-- 7. Transactions above the overall average transaction revenue
SELECT Product, Region, Revenue
FROM dbo.SalesData
WHERE Revenue > (SELECT AVG(Revenue) FROM dbo.SalesData)
ORDER BY Revenue DESC;

-- 8. Revenue per unit by product
SELECT Product, SUM(Revenue) AS TotalRevenue, SUM(Quantity) AS UnitsSold,
       CAST(SUM(Revenue) / NULLIF(SUM(Quantity), 0) AS DECIMAL(12,2)) AS RevenuePerUnit
FROM dbo.SalesData
GROUP BY Product
ORDER BY RevenuePerUnit DESC;

-- 9. Basic data-quality checks
SELECT *
FROM dbo.SalesData
WHERE Product IS NULL OR Region IS NULL OR Quantity <= 0
   OR UnitPrice < 0 OR Revenue < 0;
