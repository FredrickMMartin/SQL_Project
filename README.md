# SQL_Project
#### Creating and querying a database from store data.

This was a project that I completed under supervision from my mentor.
The overall goals of the project were to:
1. design an appropriate structure for a relational databse to store a given company's sales data
2. set up said relational database using MySQL  
3. query the databse to provide informative answers to requested questions
4. set up scheduled events and triggers to aid in maintenance of the database

The specific requirements of the project are laid out below.
1. Create an Entity-Relationship Model (ERM) diagram, including a description of the entities, their attributes, and relationships. (draw.io)

2. Create an implementation of the relational database:
    1. Create the tables of the relational database through SQL commands
    2. Import sales data from CSV file to the database through MySQL
    3. Create SQL queries to get the data from the imported sales table to the tables created
    4. Create a “nOrders” in the Customers table and update the column of each customer with the number of orders that customer has made
    5. Create an “is_top_customer” column that states if the customer is one of the company's top customers (if the customer has more than or equals 10 orders).
  

3. Query the database to provide informative answers to requested questions:
    1. Create a stored procedure that takes a state and returns the most 5 profitable products in that state for each of the years in the data
    2. Create a stored procedure that takes a category and year and returns the most popular product (Qty) in that category for that year
    3. Find the most profitable month in each year
    4. Find the details of the transactions with a Profit Ratio < 0%
    5. Find the total revenue generated per vendor (Manufacturer) every year in each segment
    6. Create a view to show the total profit per segment each month with the following information (Year, Month, Product Category, Segment, nOrders, Sales, Revenue)


4.  Set up scheduled events and triggers to aid in maintenance of the database
    1. Create a trigger to increment  “nOrders” for each customer when a purchase of theirs is added to the Orders table
    2. Create an Event Scheduler to run daily and check (and correct if needed) the values of "nOrders"
