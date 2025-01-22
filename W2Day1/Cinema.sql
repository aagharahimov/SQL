CREATE DATABASE Cinema
USE Cinema

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	ReleaseDate DATE NOT NULL,
	IMDB DECIMAL(3,1) 
)
CREATE TABLE Actors(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL
)
CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Movies_Actors(
	Id INT PRIMARY KEY IDENTITY(1,1),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)
CREATE TABLE Movies_Genres(
	Id INT PRIMARY KEY IDENTITY(1,1),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)
CREATE TRIGGER CheckReleaseDate 
ON Movies
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO Movies (Name, ReleaseDate, IMDB)
    SELECT 
        Name, 
        ReleaseDate,
        CASE 
            WHEN ReleaseDate > GETDATE() THEN NULL
            ELSE IMDB
        END
    FROM INSERTED
END
INSERT INTO Movies
VALUES
(N'MOVIE1', '2024-05-03', 0),
(N'MOVIE2', '2024-07-03', 9.0),
(N'MOVIE3', '2024-06-10', 7.8),
(N'MOVIE4', '2024-10-01', 0)
SELECT * FROM Movies
INSERT INTO  Actors
VALUES
(N'actor1', N'ACTOR1'),
(N'actor2', N'ACTOR2'),
(N'actor3', N'ACTOR3'),
(N'actor4', N'ACTOR4'),
(N'actor5', N'ACTOR5'),
(N'actor6', N'ACTOR6'),
(N'actor7', N'ACTOR7')
SELECT * FROM Movies
SELECT * FROM Actors
INSERT INTO  Genres
VALUES
('Genre1'),
('Genre2'),
('Genre3'),
('Genre4')
INSERT INTO Movies_Actors
VALUES
(1,2),
(1,3),
(1,5),
(2,2),
(2,4),
(2,6),
(3,1),
(3,2),
(3,7),
(4,1),
(4,4),
(4,5)
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres
SELECT * FROM Movies_Actors
INSERT INTO Movies_Genres
VALUES
(1,1),
(1,2),
(2,2),
(2,3),
(3,3),
(3,4),
(4,1),
(4,4)
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres
SELECT * FROM Movies_Actors
SELECT * FROM Movies_Genres
SELECT a.Name AS 'Actor name', COUNT(MovieId) AS 'Played movies count' FROM Actors AS a
JOIN Movies_Actors AS ma ON a.Id =ma.ActorId
JOIN Movies AS m ON ma.MovieId = m.Id
GROUP BY a.Name

SELECT g.Name AS 'Genre name', COUNT(MovieId) AS 'movies count' FROM Genres AS g
JOIN Movies_Genres AS mg ON g.Id =mg.GenreId
JOIN Movies AS m ON mg.MovieId = m.Id
GROUP BY g.Name

SELECT m.Name AS 'Movie name', m.ReleaseDate AS 'Release date' FROM Movies AS m
WHERE m.ReleaseDate >= GETDATE()
SELECT AVG(IMDB) FROM Movies
WHERE ReleaseDate >= GETDATE()-365.25*5

SELECT a.Name AS 'Actor name' FROM Actors AS a
JOIN Movies_Actors AS ma ON a.Id =ma.ActorId
JOIN Movies AS m ON ma.MovieId = m.Id
GROUP BY a.Name
HAVING COUNT(MovieId) > 1