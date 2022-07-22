SELECT *
FROM store

-- Total profit by state --
SELECT State, ROUND(SUM(profit),2) as TotalProfit
FROM store
GROUP BY State
ORDER BY TotalProfit DESC

-- T1 Overall Profit by year -- 
SELECT YEAR([Order Date]) as Year, ROUND(SUM(profit),2) as TotalProfit
FROM store
GROUP BY YEAR([Order Date])
ORDER BY YEAR([Order Date]) DESC

-- T2 Profit by year and month --
SELECT YEAR([Order Date]) as Year, MONTH([Order Date]) as Month, ROUND(SUM(profit),2) as TotalProfit
FROM store
GROUP BY YEAR([Order Date]), MONTH([Order Date])
ORDER BY YEAR([Order Date]) DESC, MONTH([Order Date]) DESC

-- T3 Profit by year and month for each category --
SELECT YEAR([Order Date]) as Year, MONTH([Order Date]) as Month, Category, ROUND(SUM(profit),2) as TotalProfit
FROM store
GROUP BY YEAR([Order Date]),MONTH([Order Date]), Category
ORDER BY Category, YEAR([Order Date]) DESC, MONTH([Order Date]) DESC, TotalProfit DESC
-- ^ This table shows a trend that the Furniture category saw a huge decrease in profit from 2016-2017 and has been inconsistent since 2014. --

-- Profit by Sub Category -- 
SELECT YEAR([Order Date]) as Year, Category, [Sub-Category], ROUND(SUM(profit),2) as TotalProfit
FROM store
GROUP BY YEAR([Order Date]), Category, [Sub-Category]
ORDER BY Category, [Sub-Category], YEAR([Order Date]) DESC, TotalProfit DESC

-- T3 Profit for Furniture Sub Category -- 
SELECT YEAR([Order Date]) as Year, [Sub-Category], ROUND(SUM(profit),2) as TotalProfit
FROM store
WHERE Category = 'Furniture'
GROUP BY YEAR([Order Date]), Category, [Sub-Category]
ORDER BY Category, [Sub-Category], YEAR([Order Date]) DESC, TotalProfit DESC
-- ^ This table shows that Tables and Bookcases are consistently causing negative profit with tables having a significant drop in 2017. --
