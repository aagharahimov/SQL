CREATE DATABASE ShopApp
USE ShopApp

CREATE TABLE Sellers(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
)
CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	City NVARCHAR(50) NOT NULL,
)
CREATE TABLE Orders(
	Id INT PRIMARY KEY IDENTITY(1,1),
	OrderDate DATE NOT NULL CHECK(OrderDate <= GETDATE()),
	Amount DECIMAL(10,2) NOT NULL,
	State NVARCHAR(30) CHECK(State = 'catdirilmada' OR State = 'catib'),
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
	SellerId INT FOREIGN KEY REFERENCES Sellers(Id)
)
INSERT INTO Orders
VALUES
('2024-06-15', 1100, 'catib', 2, 5),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-15', 500, 'catib', 2, 3),
('2024-02-19', 500, 'catib', 1, 3),
('2024-02-23', 500, 'catib', 1, 3),
('2023-12-23', 1299.99, 'catib', 1, 2),
('2024-02-13', 500, 'catib', 2, 3),
('2024-05-30', 999.99, 'catib', 3, 3),
('2024-06-25', 1499.99, 'catdirilmada', 4, 4),
('2024-06-13', 1100, 'catdirilmada', 2, 5)

SELECT * FROM Orders
INSERT INTO Customers
VALUES
('test1', 'testov1', 'Baku'),
('test2', 'testov2', 'Sumqayit'),
('test3', 'testov3', 'Baku'),
('test4', 'testov4', 'Gence'),
('test5', 'testov5', 'Baku')
SELECT * FROM Customers
INSERT INTO Sellers
VALUES
('AAA', 'AAAA', 'Baku'),
('BBB', 'BBBB', 'Ankara'),
('CCC', 'CCCC', 'Baku'),
('DDD', 'DDDD', 'Gence'),
('EEE', 'EEEE', 'Baku')
SELECT * FROM Sellers
SELECT  c.Id AS 'Customer Id', c.Name AS 'Customer Name', SUM(Amount) AS 'Total order amount' FROM Customers AS c
INNER JOIN Orders AS o ON o.CustomerId = c.Id
GROUP BY c.Id, c.Name
HAVING SUM(Amount) > 1000

SELECT c.Name AS 'Customer Name', s.Name AS 'Seller Name', c.City AS 'City Name' FROM Customers AS c
JOIN Sellers AS s ON c.City = s.City
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2024-01-04' AND GETDATE() AND  State = 'catib'


SELECT s.Name AS 'Seller Name', count(State) FROM Sellers AS s
INNER JOIN Orders AS o ON o.SellerId = s.Id
WHERE State = 'catib'
GROUP BY s.Name
HAVING COUNT(State) >10

SELECT c.Name AS 'Customer name', COUNT(CustomerId) AS 'Orders count' FROM Customers AS c
JOIN Orders AS o ON o.CustomerId = c.Id
GROUP BY c.Name
ORDER BY COUNT(CustomerId) DESC

SELECT o.OrderDate AS 'Date', s.Name AS 'Seller Name' FROM Orders AS o
JOIN Sellers AS s ON o.SellerId = s.Id
WHERE State = 'catdirilmada'
GROUP BY o.OrderDate, s.Name

SELECT o.OrderDate AS 'Date' FROM Orders AS o
WHERE State = 'catib' AND o.OrderDate BETWEEN GETDATE()-30 AND GETDATE()
GROUP BY o.OrderDate
