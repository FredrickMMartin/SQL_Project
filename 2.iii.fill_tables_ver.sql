INSERT INTO shipping (ShippingMode, Cost)
VALUES ('First Class', 20),
	('Same Day', 25),
        ('Second Class', 15),
        ('Standard Class', 10);
        
INSERT INTO productcategory (ProductCategory)
SELECT DISTINCT ProductCategory FROM rowdata;

INSERT INTO productsubcategory (ProductSubcategory, ProductCategoryID)
SELECT DISTINCT R.ProductSubcategory, C.ProductCategoryID 
FROM rowdata AS R 
JOIN productcategory AS C
ON R.ProductCategory = C.ProductCategory;

INSERT INTO manufacturer (Manufacturer)
SELECT DISTINCT Manafacturer FROM rowdata;

INSERT INTO product (ProductName, ManufacturerID, ProductSubcategoryID)
SELECT DISTINCT R.ProductName, M.ManufacturerID, S.ProductSubcategoryID
FROM rowdata AS R
JOIN manufacturer AS M
ON R.manafacturer = M.manufacturer
JOIN productsubcategory AS S
ON R.productsubcategory = S.productsubcategory;

INSERT INTO country (Country)
SELECT DISTINCT Country
FROM rowdata;

INSERT INTO region (Region, CountryID)
SELECT DISTINCT R.Region, C.CountryID
FROM rowdata AS R
JOIN country AS C
ON R.country = C.country;

INSERT INTO state (state, RegionID)
SELECT DISTINCT R.state, Re.RegionID
FROM rowdata AS R
JOIN Region AS Re
ON R.region = Re.region;

INSERT INTO city (City, StateID)
SELECT DISTINCT R.city, S.stateID
FROM rowdata AS R
JOIN state AS S
ON R.state = S.state;

INSERT INTO customersegment (CustomerSegment)
SELECT DISTINCT CustomerSegment
FROM rowdata;

INSERT INTO customer (CustomerName, CustomerSegmentID)
SELECT DISTINCT R.CustomerName, Cs.CustomerSegmentID
FROM rowdata AS R
JOIN customersegment AS Cs
ON R.customersegment = Cs.customersegment;


CREATE INDEX idx_StateID_Ci ON city(StateID);
CREATE INDEX idx_StateID_St ON State(StateID);
CREATE INDEX idex_CustomerName_Cu ON customer(CustomerName);
CREATE INDEX idex_CustomerName_Ro ON rowdata(CustomerName);

INSERT INTO orders (OrderKey, OrderDate, ShipDate, ShippingModeID, CustomerID, CityID)
SELECT DISTINCT R.OrderKey, R.OrderDate, R.ShipDate, Sh.ShippingModeID, Cus.CustomerID, Ci.CityID
FROM city as Ci
JOIN state AS St
ON St.stateID = Ci.StateID
JOIN rowdata as R
ON R.city = Ci.City
AND R.state = St.State
JOIN 
	(SELECT Cu.CustomerName AS CustomerName, Cu.CustomerSegmentID As CustomerSegmentID, Cu.CustomerID as CustomerID, Cs.CustomerSegment AS CustomerSegment
	FROM customer AS Cu 
	JOIN customersegment AS Cs
	ON Cs.CustomerSegmentID = Cu.CustomerSegmentID) AS Cus
ON Cus.CustomerName = R.CustomerName
AND Cus.CustomerSegment = R.CustomerSegment
JOIN shipping AS Sh
ON R.ShipmentMode = Sh.ShippingMode;


CREATE INDEX idx_OrderKey_rd ON rowdata(OrderKey);
CREATE INDEX idx_OrderKey_ord ON orders(OrderKey);
CREATE INDEX idx_ProductName_rd ON rowdata(ProductName);
CREATE INDEX idx_ProductName_pr ON product(ProductName);
INSERT INTO orderline (DiscountPercent, OrderID, ProductID, Profit, ProfitRatio, Qty, Sale)
SELECT DISTINCT R.Discount, O.OrderID, P.ProductID, R.Profit, R.ProfitRatio, R.Qty,  R.Sale
FROM rowdata AS R
JOIN orders AS O
ON R.OrderKey = O.OrderKey
JOIN product AS P
ON P.ProductName = R.ProductName;

/*
OR


INSERT INTO orderline (DiscountPercent, OrderID, ProductID, Profit, ProfitRatio, Qty, Sale)
SELECT DISTINCT R.Discount, O.OrderID, P.ProductID, R.Profit, R.ProfitRatio, R.Qty,  R.Sale
FROM 
	(SELECT Discount, OrderKey, ProductName, Profit, ProfitRatio, Qty, Sale
	FROM rowdata) AS R
JOIN 
	(SELECT OrderKey, OrderID 
	FROM orders) AS O	
ON R.OrderKey = O.OrderKey
JOIN product AS P
ON P.ProductName = R.ProductName;


OR


INSERT INTO orderline (DiscountPercent, OrderID, ProductID, Profit, ProfitRatio, Qty, Sale)
SELECT DISTINCT R.Discount, O.OrderID, P.ProductID, R.Profit, R.ProfitRatio, R.Qty,  R.Sale
FROM rowdata AS R
JOIN orders AS O
ON R.OrderKey = O.OrderKEy
JOIN product AS P
ON P.ProductName = R.ProductName;


*/





