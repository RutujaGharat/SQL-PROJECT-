 create database SQLPROJECT;     /*DATABASE CREATED*/
 show databases;
USE SQLPROJECT; 

/*TABLE CREATION & ROW INSERTION*/

create table customers ( customerID INT PRIMARY KEY,
    Name VARCHAR(20),
    Email VARCHAR(20),
    RegistrationDate DATE
); 
INSERT INTO customers (customerID, Name, Email, RegistrationDate) VALUES 
(1, 'Alice Smith', 'alice@example.com', '2023-01-15'),
(2, 'Bob Johnson', 'bob@example.com', '2023-02-20'),
(3, 'Charlie Brown', 'charlie@example.com', '2023-03-25'),
(4, 'Diana Prince', 'diana@example.com', '2023-04-30'),
(5, 'Ethan Hunt', 'ethan@example.com', '2023-05-05'),
(6, 'Fiona Gallagher', 'fiona@example.com', '2023-06-10'),
(7, 'George Costanza', 'george@example.com', '2023-07-15'),
(8, 'Hannah Baker', 'hannah@example.com', '2023-08-20'),
(9, 'Ian Malcolm', 'ian@example.com', '2023-09-25'),
(10, 'Julia Childs', 'julia@example.com', '2023-10-30');

select * from customers;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(200),
    Price DECIMAL(10, 2),
    CategoryID INT, FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Products (ProductID, ProductName, Price, CategoryID) 
VALUES 
(201, 'Product A', 19.99, 1),
(202, 'Product B', 29.99, 1),
(203, 'Product C', 39.99, 2),
(204, 'Product D', 49.99, 2),
(205, 'Product E', 59.99, 3),
(206, 'Product F', 69.99, 3),
(207, 'Product G', 79.99, 4),
(208, 'Product H', 89.99, 4),
(209, 'Product I', 99.99, 5),
(210, 'Product J', 109.99, 5);


select * from products;



CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(30)
);

INSERT INTO Categories (CategoryID, CategoryName)
VALUES 
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Home & Kitchen'),
(5, 'Sports & Outdoors'),
(6, 'Toys & Games'),
(7, 'Health & Beauty'),
(8, 'Automotive'),
(9, 'Music'),
(10, 'Movies & TV');
select * from Categories;

	CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
SHOW TABLES;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 2, '2023-01-02', 150.50),
(3, 3, '2023-01-03', 200.75),
(4, 4, '2023-01-04', 250.25),
(5, 5, '2023-01-05', 300.00),
(6, 1, '2023-01-06', 350.50),
(7, 2, '2023-01-07', 400.75),
(8, 3, '2023-01-08', 450.00),
(9, 4, '2023-01-09', 500.25),
(10, 5, '2023-01-10', 550.50),
(11,5,'2023-01-11', 860.56),
 (201,5,'2023-01-11', 860.56);

select * from Orders;


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES 
(1,1,201,2,19.99),
(2,2,202,1,29.99),
(3,3,203,5,9.99),
(4,4,204,3,15.49),
(5,5,205,10,5.99),
(6,6,206,4,12.49),
(7,7,207,6,8.99),
(8,8,208,2,25.00),
(9 ,9 ,209 ,1 ,100.00),
(10 ,10 ,210 ,7 ,-15.00);

select * from OrderDetails;

/* SELECT RECORD FROM OREDER TABLE WHERE TOTAL AMT IS >100 */
SELECT * 
FROM Orders 
WHERE TotalAmount > 100;

/*	Where Clause (AND/OR)*/
SELECT * 
FROM Products 
WHERE Price BETWEEN 20 AND 70
AND CategoryID = 3;


/*	LIKE Operator */
SELECT * FROM Customers WHERE Name LIKE 'A%';

/*	CASE Statement*/

SELECT 
    ProductName,
    CASE 
        WHEN Price > 50 THEN Price * 0.9 
        ELSE Price 
    END AS DiscountedPrice
FROM 
    Products;
select * from products;

    /*	Subquery*/
    
  SELECT CustomerID
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > 500
);  

/*  	Group By   */
SELECT CustomerID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY CustomerID;

/* 	Having Clause */
SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 2;

/*	Limit    */

SELECT ProductName 
FROM Products 
ORDER BY ProductName ASC 
LIMIT 5;

/*	Inner Join */

SELECT Customers.Name, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

/* OUTER JOIN */

SELECT 
    p.ProductID,
    p.ProductName,
    o.OrderID,
    o.OrderDate
FROM 
    Products p
LEFT OUTER JOIN 
    Orders o ON p.productID = o.OrderID;
    
    /* Join with Aggregation */
    
  SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold
FROM 
    OrderDetails od
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName;



/* 	Subquery with Join */


SELECT p.ProductID, p.ProductName
FROM Products p
JOIN Orderdetails o ON p.ProductID = o.ProductID
WHERE o.Quantity > (SELECT AVG(Quantity) FROM Orderdetails);


/* 	Advanced Join: */


SELECT 
    c.Name,
    o.OrderDate,
    p.ProductName
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID;