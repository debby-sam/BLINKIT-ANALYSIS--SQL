SELECT *
FROM blinkit_data

-- COUNTING THE TOTAL ROWS/ITEMS IN THE DATASET

SELECT COUNT(*) AS No_Of_Items
FROM blinkit_data

-- TO CHANGE OR CORRECT THE DATA

UPDATE blinkit_data
SET Item_Fat_Content =
CASE 
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT DISTINCT(Item_Fat_Content)
FROM blinkit_data


-- TO GET THE TOTAL SALES

SELECT SUM(Sales) AS Total_Sales
FROM blinkit_data

-- TO CHANGE THE DECIMAL POINTS TO MILLIONS

SELECT CAST( SUM(Sales)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data

-- TO GET THE AVERAGE OF TOTAL SALES

SELECT AVG (Sales) AS Average_Sales
FROM blinkit_data

SELECT CAST (AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales
FROM blinkit_data


-- TO FIND LOW FAT ITEMS

SELECT CAST( SUM(Sales)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Item_Fat_Content = 'Low Fat'

-- TO GET OUTLET ESTABLISHMENT FOR YEAR 2022

SELECT CAST( SUM(Sales)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

-- TO GET AVERAGE SALES OF OUTLET ESTABLISHMENT FOR YEAR 2022

SELECT CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

-- TO FIND THE AVERAGE RATING

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
From blinkit_data

-- TO GET TOTAL SALES BY FAT CONTENT

SELECT Item_Fat_Content, SUM(Sales) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

SELECT Item_Fat_Content, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

SELECT Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC 


SELECT Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC


SELECT Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC

-- CONVERTING TOTAL SALES TO THOUSANDS
SELECT Item_Fat_Content,
		CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC 


-- TO GET TOTAL SALES BY ITEM TYPE
SELECT Item_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC 


-- TO GET THE TOP 5 FOR ITEM TYPE
SELECT TOP 5 Item_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC 


--TO GET THE BOTTOM 5 FOR ITEM TYPE
SELECT TOP 5 Item_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales ASC

-- FAT CONTENT BY OUTLET FOR TOTAL SALES
SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG (Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Average_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales ASC


-- FAT CONTENT BY OUTLET FOR TOTAL SALES
SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Total_Sales ASC



SELECT Outlet_Location_Type,
		ISNULL([Low Fat], 0) AS Low_Fat,
		ISNULL([Regular], 0) AS Regular
FROM
(
	SELECT Outlet_Location_Type, Item_Fat_Content,
			CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
	FROM blinkit_data
	GROUP BY Outlet_Location_Type, Item_Fat_Content
) As SourceTable
PIVOT
(
	SUM(Total_Sales)
	For Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;


--TO FIND TOTAL SALES BY OUTLET ESTABLISHMENT
SELECT Outlet_Establishment_Year,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year DESC


-- FIND PERCENTAGE OF SALES BY OUTLET SIZE
SELECT 
	Outlet_Size,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


--FIND SALES BY OUTLET LOCATION
SELECT Outlet_Location_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC


-- AVERAGE SALES FOR 2022
SELECT Outlet_Location_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year =2022
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC


-- AVERAGE SALES FOR 2020
SELECT Outlet_Location_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year =2020
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC


-- FIND ALL METRICS BY OUTLET TYPE
SELECT Outlet_Type,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL(10,1)) AS Average_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC



-- 



