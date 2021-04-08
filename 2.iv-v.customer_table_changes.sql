
"""2.iv. adding nOrders column""""

ALTER TABLE customer
ADD nOrders int;

"""2.iv. updating customer table"""

CREATE TEMPORARY TABLE orders_nums  
(SELECT C.customerID AS customerID, COUNT(*) AS nOrders
FROM customer AS C
JOIN orders AS O
ON O.CustomerID = C.CustomerID
GROUP BY C.customerID)

UPDATE customer AS Cu, orders_nums AS O 
SET Cu.nOrders = O.nOrders 
WHERE Cu.CustomerID = O.CustomerID

"""2.v adding is_top_customer column""""

ALTER TABLE customer
ADD is_top_customer bool;

"""2.v updating is_top_customer column""""

UPDATE customer
SET is_top_customer = CASE
WHEN nOrders >= 10 THEN TRUE
ELSE FALSE
END	