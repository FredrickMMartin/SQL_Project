"""4.i. creating_after_orders_insert trigger"""

DELIMITER $$
CREATE TRIGGER after_orders_insert
AFTER INSERT
ON orders FOR EACH ROW
BEGIN
UPDATE customer
SET nOrders = nOrders + 1
WHERE CustomerID = NEW.CustomerID;
END$$

"""4.ii. creating_nOrders_check"""
"""The event scheduler was created using the GUI on MySQL and the following code: """

UPDATE customer AS Cu
SET Cu.nOrders = (SELECT Count(*) AS nOrders
                  FROM customer AS C
                  JOIN orders AS O
                  ON O.CustomerID = C.CustomerID
                  WHERE Cu.CustomerID = C.CustomerID
                  GROUP BY C.customerID)






 



	