CREATE DATABASE MyApp

CREATE TABLE Users(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL,
	SurName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(100) UNIQUE,
	RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP, CHECK (RegistrationDate <= CURRENT_TIMESTAMP),
	ContactNumber NVARCHAR(15) DEFAULT '+994000000000',
	Age INT,
	CHECK (Age >= 18),
	Address NVARCHAR(100),
)

INSERT INTO Users ([Name], SurName, Email, RegistrationDate, ContactNumber, Age, Address)
VALUES ('beep beep', 'beep', 'agaaauu@gmail.com', '2004-10-23', Default,  25, 'Baku');



CREATE TABLE Categories(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(20) NOT NULL,
	Slug NVARCHAR(50) UNIQUE,
	CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP, CHECK (CreatedAt <= CURRENT_TIMESTAMP),
	IsActive BIT,
)

INSERT INTO Categories( [Name] , Slug , CreatedAt, IsActive)
VALUES ('BB' , 'MEOWW-HAW' , '2022-11-12', 0);


SELECT [Name], Surname, Email FROM Users
SELECT [Name], IsActive FROM Categories



