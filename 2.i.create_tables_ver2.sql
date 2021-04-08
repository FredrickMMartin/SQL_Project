CREATE TABLE Country (
	CountryID int NOT NULL AUTO_INCREMENT,
	Country varchar(90) NOT NULL,
	PRIMARY KEY (CountryID)
);

CREATE TABLE Region (
	RegionID int NOT NULL AUTO_INCREMENT,
	Region varchar(20),
	CountryID int,
	PRIMARY KEY (RegionID),
	CONSTRAINT fk_Country_Region FOREIGN KEY (CountryID) 
	REFERENCES Country(CountryID)
);

CREATE TABLE State (
	StateID int NOT NULL AUTO_INCREMENT,
	State varchar(25),
	RegionID int,
	PRIMARY KEY (StateID),
	CONSTRAINT fk_Region_State FOREIGN KEY (RegionID)
	REFERENCES Region(RegionID)
);

CREATE TABLE City (
	CityID int NOT NULL AUTO_INCREMENT,
	City varchar(189),
	StateID int,
	PRIMARY KEY (CityID),
	CONSTRAINT fk_State_City FOREIGN KEY (StateID)
	REFERENCES State(StateID)
);

CREATE TABLE CustomerSegment (
	CustomerSegmentID int NOT NULL AUTO_INCREMENT,
	CustomerSegment varchar(50),
	PRIMARY KEY (CustomerSegmentID)
);

CREATE TABLE Customer (
	CustomerID int NOT NULL AUTO_INCREMENT,
	CustomerName varchar(50),
	CustomerSegmentID int,
	PRIMARY KEY (CustomerID),
	CONSTRAINT fk_CustomerSegment_Customer FOREIGN KEY (CustomerSegmentID)
	REFERENCES CustomerSegment(CustomerSegmentID)
);


CREATE TABLE Shipping (
	ShippingModeID int NOT NULL AUTO_INCREMENT,
	ShippingMode varchar (25),
	Cost int,
	PRIMARY KEY (ShippingModeID)
);

CREATE TABLE Orders (
	OrderID int NOT NULL AUTO_INCREMENT,
	OrderKey varchar(20),
	CustomerID int,
	CityID int,
	ShippingModeID int,
	OrderDate date,
	ShipDate date,
	PRIMARY KEY (OrderID),
	CONSTRAINT fk_Customer_Orders FOREIGN KEY (CustomerID)
	REFERENCES Customer(CustomerID),
	CONSTRAINT fk_Shipping_Orders FOREIGN KEY (ShippingModeID)
	REFERENCES Shipping(ShippingModeID),
	CONSTRAINT fk_City_Orders FOREIGN KEY (CityID)
	REFERENCES City(CityID)
);

CREATE TABLE ProductCategory (
	ProductCategoryID int NOT NULL AUTO_INCREMENT,
	ProductCategory varchar(50),
	PRIMARY KEY (ProductCategoryID)
);

CREATE TABLE ProductSubcategory (
	ProductSubcategoryID int NOT NULL AUTO_INCREMENT,
	ProductSubcategory varchar(50),
	ProductCategoryID int,
	PRIMARY KEY (ProductSubcategoryID),
	CONSTRAINT fk_ProductCategory_ProductSubcategory FOREIGN KEY (ProductCategoryID)
	REFERENCES ProductCategory(ProductCategoryID)
);

CREATE TABLE Manufacturer (
	ManufacturerID int NOT NULL AUTO_INCREMENT,
	Manufacturer varchar(50),
	PRIMARY KEY (ManufacturerID)
);

CREATE TABLE Product (
	ProductID int NOT NULL AUTO_INCREMENT,
	ProductName varchar(150),
	ManufacturerID int,
	ProductSubcategoryID int,
	PRIMARY KEY (ProductID),
	CONSTRAINT fk_Manufacturer_Products FOREIGN KEY (ManufacturerID)
	REFERENCES Manufacturer(ManufacturerID),
	CONSTRAINT fk_ProductSubcategory_Product FOREIGN KEY (ProductSubcategoryID)
	REFERENCES ProductSubcategory(ProductSubcategoryID)
);

CREATE TABLE OrderLine (
	OrderLineID int NOT NULL AUTO_INCREMENT,
	OrderID int,
	ProductID int,
	ProfitRatio int,
	Qty int,
	DiscountPercent int,
	Profit int,
	Sale int,
	PRIMARY KEY (OrderLineID),
	CONSTRAINT fk_Orders_OrderLine FOREIGN KEY (OrderID)
	REFERENCES Orders(OrderID),
	CONSTRAINT fk_Product_OrderLine FOREIGN KEY (ProductID)
	REFERENCES Product(ProductID)
);
	
	
	
	 
