/* This code was used alongside the GUI when creating stored procedures.
The variables listed are those that were used.
Other queries were run as they are here.*/


""" 3. i. top_5_products_in_a_state_each_year, variables: state1"

SELECT * 
FROM
(SELECT *, RANK()
OVER (PARTITION BY S.year ORDER BY totalprofit DESC) AS Rank
FROM (SELECT P.productname AS prod, YEAR(O.orderdate) AS year, SUM(OL.profit) AS totalprofit
	FROM orderline AS OL
	JOIN product AS P
	ON OL.ProductID = P.ProductID
	JOIN orders AS O
	ON O.OrderID = OL.OrderID
	JOIN City AS Ci
	ON Ci.CityID = O.CityID
	JOIN State AS S
	ON S.StateID = Ci.StateID
	WHERE S.State = state1
	GROUP BY P.ProductName, YEAR(O.orderdate)
      ) AS S
 ) AS S1
 WHERE Rank < 6


"""3. ii. most_popular_product_in_cat_in_year, variables: ProdCat1, year1"""


SELECT P.productname AS prod, SUM(OL.Qty) AS totalsold
FROM orderline AS OL
JOIN product AS P
ON P.ProductID = OL.ProductID
JOIN ProductSubcategory AS PS
ON PS.ProductSubcategoryID = P.ProductSubcategoryID
JOIN ProductCategory AS PC
ON PC.ProductCategoryID = PS.ProductCategoryID
JOIN orders AS O
ON O.OrderID = OL.OrderID
WHERE PC.ProductCategory = ProdCat1 
AND YEAR(O.OrderDate) = year1
GROUP BY P.ProductName
ORDER BY totalsold DESC
LIMIT 1

"""3. iii. most_profitable_month_each_year"""

SELECT *
FROM
(
    SELECT MONTH(O.OrderDate) AS month, YEAR(O.OrderDate) AS year, SUM(OL.profit) AS totalprofit, 
	RANK() OVER (PARTITION BY YEAR(O.OrderDate) ORDER BY totalprofit DESC) AS Rank
	FROM orderline AS OL
	JOIN orders AS O
	ON O.OrderID = OL.OrderID
	GROUP BY MONTH(O.OrderDate), YEAR(O.OrderDate) 
) AS S1
WHERE Rank < 2

"""3. iv. negative_profit_ratio"""

SELECT * 
FROM
Orders AS O
JOIN OrderLine AS OL
ON O.OrderID = OL.OrderID
JOIN product AS P
ON P.ProductID = OL.ProductID
JOIN manufacturer as M
ON M.ManufacturerID = P.ManufacturerID
JOIN customer AS C
ON C.CustomerID = O.CustomerID
WHERE OL.ProfitRatio < 0


"""3. v. returning manufacturer revenue per year and segment, variables: manufacturer1"""

SELECT YEAR(O.OrderDate), CS.CustomerSegment, SUM(OL.Sale)
FROM orderline as OL
JOIN orders AS O
ON OL.OrderID = O.OrderID
JOIN customer AS C
ON C.CustomerID = O.CustomerID
JOIN customersegment AS CS
ON CS.CustomerSegmentID = C.CustomerSegmentID
JOIN product AS P
ON P.ProductID = OL.ProductID
JOIN manufacturer AS M
ON M.ManufacturerID = P.ManufacturerID
WHERE M.Manufacturer = manufacturer1
GROUP BY YEAR(O.OrderDate), CS.CustomerSegment

"""3. vi. creating view category_segment_sales"""

CREATE VIEW category_segment_sales AS 
SELECT YEAR(O.OrderDate) AS Year, MONTH(O.OrderDate) AS Month, PC.ProductCategory AS Product_Category, CS.CustomerSegment AS Segment, COUNT(*) as nOders, SUM(sale) AS Revenue
FROM orderline AS OL
JOIN orders AS O
ON OL.OrderID = O.OrderID
JOIN customer AS C 
ON C.CustomerID = O.CustomerID
JOIN customersegment AS CS
ON CS.CustomerSegmentID = C.CustomerSegmentID
JOIN product AS P
ON P.ProductID = OL.ProductID
JOIN productsubcategory AS PS
ON PS.ProductSubcategoryID = P.ProductSubcategoryID
JOIN productcategory AS PC
ON PC.ProductCategoryID = PS.ProductCategoryID
GROUP BY Year, Month, Product_Category, Segment;








 



	
