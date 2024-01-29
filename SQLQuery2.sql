0S0elect * from diwali_sales_data

-- Diwali Sales Data exploration  

Select Distinct Product_Category from diwali_sales_data

Select Product_Category, Count (Product_Category) as Quatity_sales from diwali_sales_data
group by Product_Category

-- Check for Null values in each column 


DECLARE @tb NVARCHAR (255) = N'dbo.diwali_sales_data';
DECLARE @sql NVARCHAR (MAX) = N'SELECT * FROM ' + @tb + ' WHERE 1 = 0';
SELECT @sql += N' OR ' + QUOTENAME (name) + ' IS NULL'
FROM sys.columns
WHERE object_id = OBJECT_ID (@tb);
EXEC sp_executesql @sql;

--Determine distribution by Age 

SELECT gender, age_group, COUNT(*) AS frequency, 100.0 * COUNT(*) / SUM(COUNT(*)) OVER(PARTITION BY gender) AS percentage
FROM (
  SELECT gender, CASE
           WHEN age BETWEEN 0 AND 17 THEN '0-17'
           WHEN age BETWEEN 18 AND 25 THEN '18-25'
           WHEN age BETWEEN 26 AND 35 THEN '26-35'
           WHEN age BETWEEN 36 AND 45 THEN '36-45'
           WHEN age BETWEEN 46 AND 55 THEN '46-55'
           WHEN age >= 55 THEN '55'
           ELSE '90+'
         END AS age_group
  FROM diwali_sales_data
) AS age_groups
GROUP BY gender, age_group
Order by age_group;

SELECT gender, age_group, COUNT(*) AS frequency
FROM (
  SELECT gender, CASE
           WHEN age BETWEEN 0 AND 17 THEN '0-17'
           WHEN age BETWEEN 18 AND 25 THEN '18-25'
           WHEN age BETWEEN 26 AND 35 THEN '26-35'
           WHEN age BETWEEN 36 AND 45 THEN '36-45'
           WHEN age BETWEEN 46 AND 55 THEN '46-55'
           WHEN age >= 55 THEN '55'
           ELSE '90+'
         END AS age_group
  FROM diwali_sales_data
) AS age_groups
GROUP BY gender, age_group
Order by age_group;

-- Spending Distribution by  Age_Group  

  Select Gender,Age_Group, Sum(Amount) as Spending 
  from diwali_sales_data
  group by Gender,Age_Group
  order by Age_Group

  -- Determine the User with  highest spending

  SELECT User_ID,Cust_name, Amount
FROM diwali_sales_data
WHERE Amount = ( SELECT MAX(Amount) FROM diwali_sales_data );

--  Determine User Id with Overall highest amount spend

--Select  Top 10 User_ID,  SUM (Amount ) as Amount     
--from diwali_sales_data
-- Group By diwali_sales_data.User_ID

--Try
WITH MaxCTE  AS (
Select  User_ID,  SUM (Amount ) as Amount     
from diwali_sales_data
Group By User_ID
)
SELECT diwali_sales_data.User_ID, diwali_sales_data.Amount
FROM diwali_sales_data
JOIN MaxCTE
ON diwali_sales_data.User_ID= MaxCTE.User_ID
where Amount=(Select  User_ID,  SUM (Amount ) as Amount     
from diwali_sales_data
Group By User_ID)

SELECT diwali_sales_data.User_ID, diwali_sales_data.Amount
FROM diwali_sales_data
where Amount=(Select  User_ID,  Max (Amount ) as Amount     
from diwali_sales_data
Group By User_ID)

-- Number  of orders and amount spend by each states

Select  State, Sum(Orders) Number_Of_Orders
from diwali_sales_data
group by State
order by Number_Of_Orders Desc

-- Determine the distribution  by Occupation

Select Occupation, COUNT(*) as Number  
from diwali_sales_data
group by Occupation


-- Determine distribution per product Category

Select Product_Category, COUNT(*) as Number  
from diwali_sales_data
group by Product_Category

-- Distribution Per Age

SELECT age_group, COUNT(*) AS frequency
FROM (
  SELECT gender, CASE
           WHEN age BETWEEN 0 AND 17 THEN '0-17'
           WHEN age BETWEEN 18 AND 25 THEN '18-25'
           WHEN age BETWEEN 26 AND 35 THEN '26-35'
           WHEN age BETWEEN 36 AND 45 THEN '36-45'
           WHEN age BETWEEN 46 AND 55 THEN '46-55'
           WHEN age >= 55 THEN '55'
           ELSE '90+'
         END AS age_group
  FROM diwali_sales_data
) AS age_groups
GROUP BY  age_group
Order by age_group;

-- Product category distribution by number of orders for each State

SELECT State, Product_Category, SUM(Orders) AS TotalOrders
FROM diwali_sales_data
GROUP BY State, Product_Category
ORDER BY State, Product_Category

-- Amount spent by people (considering occupation)

SELECT Occupation, SUM(Amount) AS TotalSpend
FROM diwali_sales_data
GROUP BY Occupation
ORDER BY TotalSpend Desc

-- Age distribution across zones

 SELECT Zone,age_group, COUNT(*) AS frequency
FROM (
  SELECT Zone ,gender, CASE
           WHEN age BETWEEN 0 AND 17 THEN '0-17'
           WHEN age BETWEEN 18 AND 25 THEN '18-25'
           WHEN age BETWEEN 26 AND 35 THEN '26-35'
           WHEN age BETWEEN 36 AND 45 THEN '36-45'
           WHEN age BETWEEN 46 AND 55 THEN '46-55'
           WHEN age >= 55 THEN '55'
           ELSE '90+'
         END AS age_group
  FROM diwali_sales_data
) AS age_groups
GROUP BY  age_group,Zone
Order by Zone,age_group

-- Spendings by people Marital Status 

 Select Gender,Marital_Status, Sum(Amount) as Spending 
  from diwali_sales_data
  group by Gender,Marital_Status
  order by Gender

  --- Total Number of Orders for each product categories in the " Maharashtra State"

  SELECT State, Product_Category, SUM(Orders) AS TotalOrders
FROM diwali_sales_data
Where State='Maharashtra'
GROUP BY State, Product_Category
ORDER BY State, Product_Category
						
						
						


	
				
			




