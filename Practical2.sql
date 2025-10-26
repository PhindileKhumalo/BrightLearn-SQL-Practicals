-- Display columns from three tables

SELECT *
FROM practical2.shop.customers
LIMIT 10;

SELECT *
FROM practical2.shop.orders
;

SELECT *
FROM practical2.shop.products
LIMIT 10;

-- Question 1: 
-- List all orders along with the customer name and product name. 
-- Expected Output Columns: 
-- • OrderID, OrderDate, CustomerName, ProductName, Quantity 


SELECT A.orderid,
       A.orderdate,
       B.customername,
       C.productname,
       A.quantity
FROM PRACTICAL2.SHOP.ORDERS AS A
INNER JOIN PRACTICAL2.SHOP.CUSTOMERS AS B
ON A.customerid=B.customerid
INNER JOIN PRACTICAL2.SHOP.PRODUCTS AS C
ON A.productid=C.productid;


-- 2. INNER JOIN: Customers Who Placed Orders 
-- Question: 
-- Which customers have placed at least one order? 
-- Expected Output Columns: 
-- • CustomerID, CustomerName, Country, OrderID, OrderDate



SELECT  A.CUSTOMERID,
        A.customername,
        A.country,
        B.orderid,
        B.orderdate
FROM PRACTICAL2.SHOP.CUSTOMERS AS A
INNER JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.CUSTOMERID=B.CUSTOMERID;

-- 3. LEFT JOIN: All Customers and Their Orders 
-- Question: 
-- List all customers and any orders they might have placed. Include customers who have 
-- not placed any orders. 
-- Expected Output Columns: 
-- • CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity


SELECT  A.CUSTOMERID,
        A.customername,
        A.country,
        B.orderid,
        B.orderdate,
       B.productid,
        B.quantity
        
FROM PRACTICAL2.SHOP.CUSTOMERS AS A
LEFT JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.CUSTOMERID=B.CUSTOMERID
 ;


--  4. LEFT JOIN: Product Order Count 
-- Question: 
-- List all products and how many times each was ordered (if any). 
-- Expected Output Columns: 
-- • ProductID, ProductName, TotalOrders 
-- (TotalOrders is the count of how many times the product appears in orders)

SELECT A.productid,
        productname,
        COUNT(B.orderid) AS TotalOrders
FROM PRACTICAL2.SHOP.PRODUCTS AS A
LEFT JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.PRODUCTID=B.PRODUCTID

GROUP BY A.PRODUCTID,productname;



-- 5. RIGHT JOIN: Orders with Product Info (Include Products Not Ordered) 
-- Question: 
-- Find all orders along with product details, including any products that might not have 
-- been ordered. 
-- Expected Output Columns: 
-- • OrderID, OrderDate, ProductID, ProductName, Price, Quantity 


SELECT A.orderid,
        A.orderdate,
        A.productid,
        B.productname,
        B.price,
        A.quantity

FROM PRACTICAL2.SHOP.ORDERS AS A
RIGHT JOIN PRACTICAL2.SHOP.PRODUCTS AS B
ON A.PRODUCTID=B.PRODUCTID
;

-- 6. RIGHT JOIN: Customer Info with Orders (Include All Customers) 
-- Question: 
-- Which customers have made orders, and include customers even if they have never 
-- placed an order. 
-- Expected Output Columns: 
-- • CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity

SELECT A.customerid,
       A.customername,
        A.country,
       B.orderid,
       B.orderdate,
        B.productid,
       B.quantity
FROM PRACTICAL2.SHOP.CUSTOMERS AS A 
RIGHT JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.CUSTOMERID=B.CUSTOMERID;


-- 7. FULL OUTER JOIN: All Customers and All Orders 
-- Question: 
-- List all customers and orders, showing NULLs where customers have not ordered or 
-- where orders have no customer info. 
-- Expected Output Columns: 
-- • CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity 



        
SELECT A.customerid,
       A.customername,
        A.country,
       B.orderid,
       B.orderdate,
        B.productid,
       B.quantity
FROM PRACTICAL2.SHOP.CUSTOMERS AS A 
FULL OUTER JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.CUSTOMERID=B.CUSTOMERID;


-- 8. FULL OUTER JOIN: All Products and Orders 
-- Question: 
-- List all products and orders, showing NULLs where products were never ordered or 
-- orders are missing product info. 
-- Expected Output Columns: 
-- • ProductID, ProductName, Price, OrderID, OrderDate, CustomerID, Quantity


SELECT A.productid,
       A.productname,
        A.price,
       B.orderid,
       B.orderdate,
     B.customerid,
     B.quantity
FROM PRACTICAL2.SHOP.PRODUCTS AS A 
FULL OUTER JOIN PRACTICAL2.SHOP.ORDERS AS B
ON A.PRODUCTID=B.PRODUCTID;
