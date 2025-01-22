CREATE DATABASE DemoApp
USE DemoApp

CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL UNIQUE,
	Area DECIMAL(18,2) NOT NULL CHECK(Area > 0)
)

CREATE TABLE Cities(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Area DECIMAL(18,2) NOT NULL CHECK(Area > 0),
	CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)
CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	PhoneNumber NVARCHAR(50) NOT NULL DEFAULT '994000000000',
	Email NVARCHAR(50) NOT NULL UNIQUE,
	BirthDate DATE NOT NULL,
	Gender CHAR CHECK(Gender ='K' OR Gender ='Q'),
	HasCitizenship BIT NOT NULL,
	CityId INT FOREIGN KEY REFERENCES Cities(Id)
)

INSERT INTO Countries
VALUES
('Italia', 70000),
('Azerbaijan', 86600),
('Russia', 170000),
('Turkiye', 134532)
SELECT * FROM Countries
INSERT INTO Cities
VALUES
('Baku', 15893.6, 1),
('Ganja', 12833, 1),
('Ankara', 33521, 3),
('Istambul', 32711, 3),
('Moscow', 32212, 2),
('Saint-Peterbourg', 53311, 2)
SELECT * FROM Countries
SELECT * FROM Cities
INSERT INTO People
VALUES
('yturtbev', 'fwfwewef', default, 'fewfwfe@code.edu.az', '2000-01-01', 'K', 'True', 1),
('fwfwfw', 'fweefw', default, 'wfewefwefw@code.edu.az', '2000-11-23', 'Q', 'True', 1),
('fwefsd', 'adaddd', default, 'ttwfovfwef@code.edu.az', '2003-04-08', 'K', 'True', 2),
('dsaas', 'adadad', default, 'ttttttt@code.edu.az', '2011-02-05', 'K', 'False', 2),
('aaaa', 'aaaaabb', default, 'ewrwe23@code.edu.az', '2002-10-11', 'Q', 'True', 3),
('aaaa', '2aaaa32', default, 't324fg@code.edu.az', '2000-01-29', 'Q', 'True', 3)

SELECT * FROM Countries
SELECT * FROM Cities
SELECT * FROM People

SELECT p.Name AS 'Person Name', ct.Name AS 'City Name' FROM People AS p
INNER JOIN Cities AS ct ON ct.Id = p.CityId
SELECT p.Name AS 'Person Name', ct.Name AS 'City Name', c.Name AS ' Country Name' FROM People AS p
INNER JOIN Cities AS ct ON ct.Id = p.CityId
INNER JOIN Countries AS c ON c.Id = ct.CountryId
SELECT (Area) FROM Countries
ORDER BY Area DESC
SELECT (Name) FROM Cities
ORDER BY Name DESC
SELECT COUNT(Area) FROM Countries
WHERE Area > 20000
SELECT MAX(Area) FROM Countries
WHERE Countries.Name LIKE 'i%'
SELECT Name FROM Countries
UNION
SELECT Name FROM Cities
ALTER TABLE Cities
ADD Population INT
SELECT * FROM Cities
UPDATE Cities
SET Population = 74000
WHERE Id = 1
UPDATE Cities
SET Population=37300
WHERE Id =6
UPDATE Cities
SET Population=34000
WHERE Id =2
UPDATE Cities
SET Population=81500
WHERE Id =3
UPDATE Cities
SET Population=11300
WHERE Id =4
UPDATE Cities
SET Population=1300
WHERE Id =5
UPDATE Cities
SET Population=37300
WHERE Id =6
SELECT Name, Population FROM Cities
GROUP BY Population, Name
SELECT Name, Population FROM Cities
GROUP BY  Population, Name
HAVING Population > 50000

