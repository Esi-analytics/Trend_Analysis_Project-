/*Number of orders from customers by state*/
SELECT customers.State, COUNT(orders.OrderID) AS NumberOfOrders
FROM primez.customers AS customers
JOIN primez.orders AS orders ON customers.CustomerID = orders.CustomerID
GROUP BY customers.State;

/*Most popular router by state*/
SELECT customers.State, orders.Description AS MostPopularRouter, COUNT(orders.Description) AS RouterCount
FROM primez.customers AS customers
JOIN primez.orders AS orders ON customers.CustomerID = orders.CustomerID
GROUP BY customers.State, orders.Description
ORDER BY customers.State, RouterCount DESC;


/*Router type that was returned the least*/
SELECT orders.Description AS LeastReturnedRouter, COUNT(orders.Description) AS ReturnCount
FROM primez.orders AS orders
JOIN primez.router_info AS router_info ON orders.OrderID = router_info.OrderID
WHERE router_info.Step = 'Complete'
GROUP BY orders.Description
ORDER BY ReturnCount ASC
LIMIT 1;

/*Query with the term GROUP BY: number of customers per state*/
SELECT customers.State, COUNT(customers.CustomerID) AS CustomerCount
FROM primez.customers AS customers
GROUP BY customers.State;

/*Query with the term HAVING: count of customers by state, which have more than 9 members*/
SELECT customers.State, COUNT(customers.CustomerID) AS CustomerCount
FROM primez.customers AS customers
GROUP BY customers.State
HAVING CustomerCount > 9;

/*Query with the term DISTINCT COUNT: unique customer count*/
SELECT COUNT(DISTINCT customers.CustomerID) AS UniqueCustomerCount
FROM primez.customers AS customers;

/*Query with the term NOT: show entries that are not basic from the description column*/
SELECT * 
FROM primez.orders 
WHERE Description NOT LIKE '%Basic%';

/*Query with the term BUT (using AND to simulate "but")*/
SELECT * 
FROM primez.router_info
WHERE Step = 'Complete' AND Reason = 'Incorrect';

/*ADVANCED QUERIES WITH JOINS*/

/*List of all orders along with customer details*/
SELECT orders.OrderID, customers.FirstName, customers.LastName, orders.Description
FROM primez.orders AS orders
JOIN primez.customers AS customers ON orders.CustomerID = customers.CustomerID;

/*Number of returns by customer state*/
SELECT customers.State, COUNT(router_info.RMAID) AS ReturnCount
FROM primez.customers AS customers
JOIN primez.orders AS orders ON customers.CustomerID = orders.CustomerID
JOIN primez.router_info AS router_info ON orders.OrderID = router_info.OrderID
WHERE router_info.Step = 'Complete'
GROUP BY customers.State;

/*Total number of routers by type in each city*/
SELECT customers.City, orders.Description, COUNT(orders.OrderID) AS TotalRouters
FROM primez.customers AS customers
JOIN primez.orders AS orders ON customers.CustomerID = orders.CustomerID
GROUP BY customers.City, orders.Description;

/*Customer details for those who returned routers*/
SELECT customers.CustomerID, customers.FirstName, customers.LastName, customers.City
FROM primez.customers AS customers
JOIN primez.orders AS orders ON customers.CustomerID = orders.CustomerID
JOIN primez.router_info AS router_info ON orders.OrderID = router_info.OrderID
WHERE router_info.Step = 'Complete';

/*List of router types and corresponding return reasons*/
SELECT orders.Description AS RouterType, router_info.Reason AS ReturnReason, COUNT(router_info.RMAID) AS ReasonCount
FROM primez.orders AS orders
JOIN primez.router_info AS router_info ON orders.OrderID = router_info.OrderID
GROUP BY orders.Description, router_info.Reason;
