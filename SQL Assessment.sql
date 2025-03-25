create database Techshop
go

use TechShop
go

create table Customers(
	CustomerID INT primary key,
	Firstname varchar(100),
    Lastname varchar(100),
    Email varchar(100),
    Phone bigint,
    Address varchar(100)
); 

create table Products(
	ProductID int primary key,
    ProductName varchar(100),
    Description varchar(100),
    Price decimal(10,2)
); 

create table Orders(
    OrderID int primary key,
    CustomerID int foreign key references Customers(CustomerID),
    OrderDate datetime,
    TotalAmount decimal(10,2)
); 

create table OrderDetails(
    OrderDetailID int primary key,
    OrderID int foreign key references Orders(OrderID),
    ProductID int foreign key references Products(ProductID),
    Quantity bigint
); 

create table Inventory(
    InventoryID int primary key,
    ProductID int foreign key references Products(ProductID),
    QuantityInStock int,
    LastStockUpdate date
);

INSERT INTO Customers(CustomerID, Firstname,Lastname, Email, Phone,Address) VALUES
(1, 'John','Doe', 'john@gmail.com', '9876543210','123 Main St'),
(2, 'Alice','Smith', 'alice@gmail.com', '1234567899','456 Elm St'),
(3, 'Bob','John', 'bob@gmail.com', '9876543212','789 Oak St'),
(4, 'Eve','Adams', 'eve@gmail.com', '6543234456','321 Pine St'),
(5, 'Charlie','Brown', 'charlie@gmail.com', '3456789123','555 Maple St'),
(6, 'David','White', 'david@gmail.com', '9876543213','678 Cedar St'),
(7, 'Grace','Miller', 'grace@gmail.com', '9876543216','901 Birch St'),
(8, 'Sophia','Wilson', 'sophia@gmail.com', '8877665544','234 Walnut St'),
(9, 'Liam','Harris', 'liam@gmail.com', '1122334455','567 Ash St'),
(10, 'Emma','Clark', 'emma@gmail.com', '9876543219','890 Sycamore St');

INSERT INTO Products (ProductID,ProductName, Description, Price) VALUES 
(1,'Tablet', 'Electronics', 90000),
(2,'Watch', 'Accessory', 2700.99),
(3,'Earphone', 'Electronics', 400),
(4,'Wireless Mouse', 'Accessory', 700.99),
(5,'Coolers', 'Accessory', 12000.75),
(6,'Smart Watch', 'Electronics', 4000),
(7,'Bluetooth Speaker', 'Accessory', 19000.99),
(8,'Gaming Monitor', 'Electronics', 50000),
(9,'Hard Drive', 'Storage', 15000),
(10,'Laptop', 'Electronics', 60000);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 3, '2025-03-10', 90000),
(2, 6, '2025-03-11', 65000),
(3, 9, '2025-03-12', 13000),
(4, 2, '2025-03-13', 15000),
(5, 4, '2025-03-14', 50000),
(6, 8, '2025-03-15', 17000),
(7, 1, '2025-03-16', 40000),
(8, 5, '2025-03-17', 7000),
(9, 10, '2025-03-18', 60000),
(10, 7, '2025-03-19', 8000);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 3),
(2, 2, 2, 1),
(3, 2, 3, 2),
(4, 3, 8, 3),
(5, 4, 4, 1),
(6, 5, 5, 4),
(7, 5, 6, 2),
(8, 6, 7, 1),
(9, 7, 9, 2),
(10, 8, 10, 5);

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 1, '250', '2025-03-10'),
(2, 2, '100', '2025-03-11'),
(3, 3, '200', '2025-03-12'),
(4, 4, '75', '2025-03-13'),
(5, 5, '60', '2025-03-14'),
(6, 6, '150', '2025-03-15'),
(7, 7, '120', '2025-03-16'),
(8, 8, '490', '2025-03-17'),
(9, 9, '40', '2025-03-18'),
(10, 10, '110', '2025-03-19');

---*****************************************************************************************-
--------------------------------TASK 2-------------------------------------------------------

---1. fullname & email of all customers
select CONCAT(Firstname,' ',Lastname) AS Name,Email from Customers;

---2.list all orders with their order dates and corresponding customer name.
select o.OrderID , o.OrderDate ,CONCAT (c.firstname,' ',c.lastname) as Customername
from Orders o
inner join Customers c
on o.OrderID=c.CustomerID

---3. insert new record into customers
insert into Customers(CustomerID, Firstname, Lastname, Email, Phone, Address) 
values (11,'Abdul','Kalam','abdul@gmail.com','6677889901','123 New St');

---4.update products Price by 10% for electronic products
UPDATE Products SET Price = Price * 1.10 WHERE Description = 'Electronics';

---5. delete a specific order and order details from the "Orders" and "OrderDetails" 
delete from OrderDetails
where OrderID = 4;
delete from Orders
where OrderID = 4;

---6.insert new records into orders
insert into Orders(OrderID,CustomerID,OrderDate,TotalAmount)
values (11,8,'2025-03-20',12000);

---7.update new mail , address for specific customerid 
update Customers set Email='eveadam@gmail.com' , Address='123 Laporte St'
where CustomerID=4

---8.recalculate and update the total cost of each order in the "Orders"  table based on the prices and quantities in the "OrderDetails" 
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(od.quantity * p.price)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = Orders.OrderID
);

---9. details for a specific customer from the "Orders" and "OrderDetails" tables
delete from OrderDetails
where OrderID = 4;
delete from Orders
where OrderID = 4;

---10.insert new records into Products
insert into Products(ProductID, ProductName, Description, Price)
values (11,'Television','Electronics',16000);

---11. adding new columnorderstatus  and update it
alter table Orders
add OrderStatus varchar(20)

update Orders set OrderStatus = 'Pending'
where OrderStatus IS NULL;
update Orders set OrderStatus = 'Shipped'
where CustomerID <=5;

---12.number of orders placed by each customer based on data on orders table
select CustomerID, COUNT(OrderID) as OrderCount
from Orders
group by CustomerID;

---******************************************************************************************
------------------------------------TASK 3--------------------------------------------------

---1. retrieve a list of all orders along with customer information
select o.orderId,o.OrderDate,concat (c.firstname,' ',c.lastname)Fullname,c.Email,C.phone 
from Orders as o join Customers as c
on o.CustomerID=c.CustomerID

---2.to find the total revenue generated by each electronic gadget product
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC;

---3. list all customers who have made at least one purchase
SELECT DISTINCT c.CustomerID, CONCAT(c.firstname, ' ', c.lastname) 
AS Custname,c.email,c.phone FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NOT NULL;

---4.find the most popular electronic gadget with  highest total quantity ordered
select top 1 p.productname , sum(od.quantity) as totquan from Products p 
join OrderDetails od on p.productID= od.ProductID 
where p.Description='Electronics'
group by p.ProductID,p.ProductName
order by totquan desc 

select * from Products
select * from OrderDetails

---5.retrieve a list of electronic gadgets along with their corresponding categories.
select productname,description from Products where Description='Electronics'

---6.Calculate the average order value for each customer
select c.customerID,CONCAT(c.firstname, ' ', c.lastname) custname , avg(o.totalAmount) avgamt
from Customers c join Orders o 
on c.CustomerID=o.CustomerID 
group by c.CustomerID,c.Firstname,c.Lastname

---7. find the order with the highest total revenue
select top 1 o.OrderID , c.customerID, CONCAT(c.firstname, ' ', c.lastname) custname, o.TotalAmount 
from Customers c join Orders o
on c.CustomerID=o.CustomerID
order by o.TotalAmount desc

---8. list electronic gadgets and the number of times each product has been ordered
select p.productname,count(od.orderdetailID) OrderCount
from Products p join OrderDetails od
on p.ProductID=od.ProductID
group by p.ProductID , p.Productname

---9. customers who have purchased a specific electronic gadget product
declare @ProductName varchar(50) = 'Tablet' 
select distinct c.customerID, CONCAT(c.firstname, ' ', c.lastname) custname,
c.email, c.phone from Customers c join Orders o on c.CustomerID=o.CustomerID
join OrderDetails od on o.OrderID=od.OrderID 
join Products p on p.ProductID=od.ProductID
where ProductName=@ProductName and Description='Electronics'

---10.Total revenue within given date
select SUM(TotalAmount) AS TotalRevenue from Orders
where OrderDate between '2025-03-11' and '2025-03-16'

---******************************************************************************************
-------------------------------------TASK 4-------------------------------------------------

select * from Customers
select * from OrderDetails
select * from Inventory

---1.which customers have not placed any orders.
select customerID,CONCAT(firstname, ' ', lastname) custname , email, Phone
from Customers where CustomerID NOT IN (select CustomerID from Orders where Orders.CustomerID=Customers.CustomerID)

---2. the total number of products available for sale. 
select sum(cast(QuantityInStock as int)) as total_avalabile_pro from Inventory

---3.total revenue generated by TechShop
select sum(TotalAmount) as Total_revenue from Orders

---4.the average quantity ordered for products in a specific category
SELECT AVG(o.Quantity) AS AverageQuantityOrdered, p.Description FROM OrderDetails o JOIN Products p ON o.ProductID = p.ProductID WHERE p.Description = 'Electronics' 
GROUP BY p.Description

---5. total revenue generated by a specific customer.
declare @CustomerID int = 6;
select c.customerID, CONCAT(c.firstname, ' ', c.lastname) custname,
sum(o.totalAmount) as TotalRevenue from Customers c join
Orders o on C.CustomerID=o.CustomerID
where c.CustomerID=@CustomerID
group by c.CustomerID,c.Firstname,c.Lastname

Select SUM(TotalAmount)TotalRevenue From Orders Where CustomerID = 6

---6.customers who have placed the most orders
select top 1  c.customerID, CONCAT(c.firstname, ' ', c.lastname) custname, 
count (o.orderID) Totalorders
from Customers c join Orders o
on c.CustomerID=o.CustomerID
group by c.CustomerID,c.Firstname,c.Lastname
order by Totalorders desc

---7. most popular product category, which is the one with the highest total quantity ordered
Select TOP 1 p.Description, o.Quantity FROM Products p JOIN OrderDetails o ON p.ProductID = o.ProductID ORDER BY o.Quantity DESC

---8.customer who has spent the most money (highest total revenue) on electronic gadgets
SELECT TOP 1 c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description = 'Electronics'
GROUP BY c.FirstName, c.LastName ORDER BY TotalSpending DESC

---9.calculate the average order value for all customers. 
select avg(TotalAmount) Avg_order from Orders

---10.total number of orders placed by each customer
SELECT CONCAT(c.firstname, ' ', c.lastname) custname, COUNT(o.OrderID) AS OrderCount FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;