CREATE DATABASE DEPARTMENT
USE DEPARTMENT

CREATE TABLE Departaments(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Positions(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Limit INT NOT NULL,
	DepartamentId INT FOREIGN KEY REFERENCES Departaments(Id)
)
CREATE TABLE Workers(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	PhoneNumber NVARCHAR(20) default '994000000000',
	Salary DECIMAL(10,2),
	BirthDate DATE,
	DepartamentId INT FOREIGN KEY REFERENCES Departaments(Id),
	PositionId INT FOREIGN KEY REFERENCES Positions(Id)
)

CREATE TRIGGER CheckAge ON Workers
INSTEAD OF INSERT
AS
BEGIN
	    DECLARE @Age DATE
    
    SELECT @Age = BirthDate FROM inserted
	IF @Age > GETDATE()-365.25*18
	BEGIN
		RAISERROR('Workers is not old enough', 10, 1)
		RETURN
	END
    INSERT INTO Workers(Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId)
    SELECT Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId FROM inserted
END

CREATE TRIGGER CheckLimit ON Workers
INSTEAD OF INSERT
AS
BEGIN
	    DECLARE @limit INT
    DECLARE @count INT
    DECLARE @positionId INT
    
    SELECT @positionId = PositionId FROM inserted
    SELECT @count = COUNT(Id) FROM Workers
    WHERE PositionId = @positionId
    SELECT @limit = Limit FROM Positions
    WHERE Id = @positionId
    IF @count >= @limit
    BEGIN
        RAISERROR('This position is full', 10, 1)
        RETURN
    END
    INSERT INTO Workers(Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId)
    SELECT Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId FROM inserted
END

CREATE TRIGGER CombinedCheck ON Workers
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @Age DATE
	DECLARE @limit INT
    DECLARE @count INT
    DECLARE @positionId INT
    
    SELECT @Age = BirthDate FROM inserted
	IF @Age > GETDATE()-365.25*18
	BEGIN
		RAISERROR('Workers is young', 10, 1)
		RETURN
	END
    SELECT @positionId = PositionId FROM inserted
    SELECT @count = COUNT(Id) FROM Workers
    WHERE PositionId = @positionId
    SELECT @limit = Limit FROM Positions
    WHERE Id = @positionId
    IF @count >= @limit
    BEGIN
        RAISERROR('This position is full', 10, 1)
        RETURN
    END
    INSERT INTO Workers(Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId)
    SELECT Name, Surname, PhoneNumber, Salary, BirthDate, DepartamentId, PositionId FROM inserted
END

INSERT INTO Departaments
VALUES
('Departament1'),
('Departament2')
INSERT INTO Positions
VALUES
('Name1', 1, 1),
('Name1', 1, 2)
INSERT INTO Positions
VALUES
('Name2', 2, 1),
('Name2', 2, 2)

SELECT * FROM Positions


INSERT INTO Workers
VALUES
('Name1', 'Surname1', default, 3000, '2006-01-01', 1, 1)
INSERT INTO Workers
VALUES
('Name2', 'Surname2', default, 3000, '2006-01-01', 2, 2)
INSERT INTO Workers
VALUES
('Name3', 'Surname3', default, 2500, '2006-01-01', 1, 3)
INSERT INTO Workers
VALUES
('Name4', 'Surname4', default, 2500, '2006-01-01', 1, 3)
INSERT INTO Workers
VALUES
('Name5', 'Surname5', default, 2500, '2006-01-01', 2, 4)
INSERT INTO Workers
VALUES
('Name6', 'Surname6', default, 2500, '2006-01-01', 2, 4)
SELECT * FROM Workers


CREATE OR ALTER FUNCTION GetAvgSalarybyDepatament (@departamentid INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @AvgSalary DECIMAL(10,2)
	SELECT @AvgSalary = AVG(Salary) FROM Workers
	WHERE @departamentid = DepartamentId
	RETURN @AvgSalary
END

SELECT dbo.GetAvgSalarybyDepatament (1)