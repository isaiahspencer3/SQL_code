--Table Information
SELECT *
FROM IBMInsurance

--Number of People Insured by Gender
SELECT Gender, COUNT(*) as NumPeople
FROM IBMInsurance
GROUP BY Gender

--Type of Coverage by Gender
SELECT Coverage, Gender, COUNT(*) as NumPeople
FROM IBMInsurance
GROUP BY Coverage, Gender
ORDER BY Coverage DESC, NumPeople DESC

--Percentage of Coverage by Coverage Type
SELECT Coverage, COUNT(*) as NumPeople,
CAST(COUNT(*) * 100 as float) / (SELECT COUNT(*) FROM IBMInsurance) as PercentOfCustomers
FROM IBMInsurance
GROUP BY Coverage
ORDER BY PercentOfCustomers DESC

--All customers with complaints
SELECT AVG([Number of Open Complaints]) as AvgComplaints, [Policy Type], Policy
FROM IBMInsurance
WHERE [Number of Open Complaints] > 0
GROUP BY [Policy Type], Policy

--Average Customer Value based on Sales Channel
SELECT AVG([Customer Lifetime Value]) as AvgValue, [Sales Channel]
FROM IBMInsurance
GROUP BY [Sales Channel]
ORDER BY AvgValue DESC

--Average Customer Value based on Education
SELECT AVG([Customer Lifetime Value]) as AvgValue, Education
FROM IBMInsurance
GROUP BY Education
ORDER BY AvgValue DESC

--Average Customer Value based on Employment Status
SELECT AVG([Customer Lifetime Value]) as AvgValue, EmploymentStatus
FROM IBMInsurance
GROUP BY EmploymentStatus
ORDER BY AvgValue DESC

--Average Customer Value based on Marital Status
SELECT AVG([Customer Lifetime Value]) as AvgValue, [Marital Status]
FROM IBMInsurance
GROUP BY [Marital Status]
ORDER BY AvgValue DESC

--Average Customer Value based on Location Code
SELECT AVG([Customer Lifetime Value]) as AvgValue, [Location Code]
FROM IBMInsurance
GROUP BY [Location Code]
ORDER BY AvgValue DESC

--Average Customer Value based on State
SELECT AVG([Customer Lifetime Value]) as AvgValue, State
FROM IBMInsurance
GROUP BY State
ORDER BY AvgValue DESC

--Average Customer Value based on State and Average Months Since Inception
SELECT State, AVG([Customer Lifetime Value]) as AvgValue, AVG([Months Since Policy Inception]) as AvgMonths
FROM IBMInsurance
GROUP BY State
ORDER BY State

--Average Number of Policies based on State
SELECT AVG([Number of Policies]) as AvgPolicies, State
FROM IBMInsurance
GROUP BY State
ORDER BY AvgPolicies DESC

--Average Complaints based on State
SELECT AVG([Number of Open Complaints]) as AvgComplaints, State
FROM IBMInsurance
GROUP BY State
ORDER BY AvgComplaints DESC

--Combining the Averages by State
SELECT  State, AVG([Number of Open Complaints]) as AvgComplaints, AVG([Number of Policies]) as AvgPolicies,
AVG([Total Claim Amount]) as AvgClaimAmount
FROM IBMInsurance
GROUP BY State
ORDER BY State

--Average Income based on State
SELECT AVG(Income) as AvgIncome, State
FROM IBMInsurance
GROUP BY State
ORDER BY AvgIncome DESC

--Percentage of Coverage Type by Sales Channel
WITH CTE_Sales
AS (
SELECT [Sales Channel], COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY [Sales Channel]
)
SELECT cte.[Sales Channel], Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Sales cte
JOIN IBMInsurance ibm
ON ibm.[Sales Channel] = cte.[Sales Channel]
GROUP BY cte.[Sales Channel], Coverage, TotalPeople
ORDER BY [Sales Channel] 

--Percentage of Coverage Type by Education
WITH CTE_Education
AS (
SELECT Education, COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY Education
)
SELECT cte.Education, Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Education cte
JOIN IBMInsurance ibm
ON ibm.Education = cte.Education
GROUP BY cte.Education, Coverage, TotalPeople
ORDER BY Education 

--Percentage of Coverage Type by Average Months Since Policy Inception
SELECT AVG([Months Since Policy Inception]) as AvgMonths, Coverage
FROM IBMInsurance
GROUP BY Coverage

--Percentage of Coverage Type by Average LifetimeValue
SELECT AVG([Customer Lifetime Value]) as AvgValue, Coverage
FROM IBMInsurance
GROUP BY Coverage
ORDER BY AvgValue DESC

--Percentage of Coverage Type by Marital Status
WITH CTE_Marital
AS (
SELECT [Marital Status], COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY [Marital Status]
)
SELECT cte.[Marital Status], Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Marital cte
JOIN IBMInsurance ibm
ON ibm.[Marital Status] = cte.[Marital Status]
GROUP BY cte.[Marital Status], Coverage, TotalPeople
ORDER BY [Marital Status] 

--Percentage of Coverage Type by Average Income
SELECT AVG(Income) as AvgIncome, Coverage
FROM IBMInsurance
GROUP BY Coverage

--Percentage of Coverage Type by Vehicle Class
WITH CTE_Vehicle
AS (
SELECT [Vehicle Class], COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY [Vehicle Class]
)
SELECT cte.[Vehicle Class], Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Vehicle cte
JOIN IBMInsurance ibm
ON ibm.[Vehicle Class] = cte.[Vehicle Class]
GROUP BY cte.[Vehicle Class], Coverage, TotalPeople
ORDER BY [Vehicle Class]

--Percentage of Coverage Type by Vehicle Size
WITH CTE_VehicleSize
AS (
SELECT [Vehicle Size], COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY [Vehicle Size]
)
SELECT cte.[Vehicle Size], Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_VehicleSize cte
JOIN IBMInsurance ibm
ON ibm.[Vehicle Size] = cte.[Vehicle Size]
GROUP BY cte.[Vehicle Size], Coverage, TotalPeople
ORDER BY [Vehicle Size]

--Percentage of Coverage Type by Employment Status
WITH CTE_Employment
AS (
SELECT EmploymentStatus, COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY EmploymentStatus
)
SELECT cte.EmploymentStatus, Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Employment cte
JOIN IBMInsurance ibm
ON ibm.EmploymentStatus = cte.EmploymentStatus
GROUP BY cte.EmploymentStatus, Coverage, TotalPeople
ORDER BY EmploymentStatus

--Percentage of Coverage Type by Location Code
WITH CTE_Location
AS (
SELECT [Location Code], COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY [Location Code]
)
SELECT cte.[Location Code], Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_Location cte
JOIN IBMInsurance ibm
ON ibm.[Location Code] = cte.[Location Code]
GROUP BY cte.[Location Code], Coverage, TotalPeople
ORDER BY [Location Code]

--Percentage of Coverage Type by State
WITH CTE_State
AS (
SELECT State, COUNT(*) as TotalPeople
FROM IBMInsurance
GROUP BY State
)
SELECT sta.State, Coverage, CAST(Count(*) as float) * 100 / TotalPeople as PercentageCoverage
FROM CTE_State sta
JOIN IBMInsurance ibm
ON ibm.State = sta.State
GROUP BY sta.State, Coverage, TotalPeople
ORDER BY State

--Percentage of Coverage by Location Code
SELECT [Location Code], Coverage, COUNT(*) as NumPeople,
CAST(COUNT(*) * 100 as float) / (SELECT COUNT(*) FROM IBMInsurance) as PercentOfCustomers
FROM IBMInsurance
GROUP BY [Location Code], Coverage
ORDER BY PercentOfCustomers DESC

--Percentage of Coverage of Employed Customers
SELECT EmploymentStatus, Coverage, COUNT(*) as NumPeople,
CAST(COUNT(*) * 100 as float) / (SELECT COUNT(*) FROM IBMInsurance) as PercentOfCustomers
FROM IBMInsurance
WHERE EmploymentStatus ='Employed'
GROUP BY Coverage, EmploymentStatus
ORDER BY PercentOfCustomers DESC

--Percentage of Coverage of All Customers by Employment Status
SELECT EmploymentStatus, Coverage, COUNT(*) as NumPeople,
CAST(COUNT(*) * 100 as float) / (SELECT COUNT(*) FROM IBMInsurance) as PercentOfCustomers
FROM IBMInsurance
GROUP BY Coverage, EmploymentStatus
ORDER BY PercentOfCustomers DESC

--Percentage of Coverage of Unemployed Customers
SELECT EmploymentStatus, Coverage, COUNT(*) as NumPeople,
CAST(COUNT(*) * 100 as float) / (SELECT COUNT(*) FROM IBMInsurance) as PercentOfCustomers
FROM IBMInsurance
WHERE EmploymentStatus ='Unemployed'
GROUP BY Coverage, EmploymentStatus
ORDER BY PercentOfCustomers DESC