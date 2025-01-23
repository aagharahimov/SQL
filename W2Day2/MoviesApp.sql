create database MoviesApp
USE MoviesApp

CREATE TABLE Languages(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
)
CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Description NVARCHAR(50),
	CoverPhoto NVARCHAR(50),
	LanguageId INT FOREIGN KEY REFERENCES Languages(Id)
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
CREATE TABLE Directors_Movies(
	Id INT PRIMARY KEY IDENTITY(1,1),
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id)
)
CREATE TABLE Genres_Movies(
	Id INT PRIMARY KEY IDENTITY(1,1),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	GenreId INT FOREIGN KEY REFERENCES Genres(Id)
)
CREATE TABLE Actors_Movies(
	Id INT PRIMARY KEY IDENTITY(1,1),
	MovieId INT FOREIGN KEY REFERENCES Movies(Id),
	ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)

INSERT INTO Languages
VALUES
(N'Azərbaycan dili'),
(N'Ingilis dili'),
(N'Rus dili'),
(N'Turk dili')

INSERT INTO Directors
VALUES
('DIRECTOR1', 'director1'),
('DIRECTOR2', 'director2'),
('DIRECTOR3', 'director3')

SELECT * FROM Languages
SELECT * FROM Directors


INSERT INTO Movies
VALUES
('Film1', 'Desc1', 'Photo1', 1),
('Film2', 'Desc2', 'Photo2', 1),
('Film3', 'Desc3', 'Photo3', 2),
('Film4', 'Desc4', 'Photo4', 2),
('Film5', 'Desc5', 'Photo5', 3),
('Film6', 'Desc6', 'Photo6', 3),
('Film7', 'Desc7', 'Photo7', 4),
('Film8', 'Desc8', 'Photo8', 4)

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies

INSERT INTO Actors
VALUES
('ACTOR1', 'actor1'),
('ACTOR2', 'actor2'),
('ACTOR3', 'actor3'),
('ACTOR4', 'actor4'),
('ACTOR5', 'actor5'),
('ACTOR6', 'actor6'),
('ACTOR7', 'actor7'),
('ACTOR8', 'actor8'),
('ACTOR9', 'actor9'),
('ACTOR10', 'actor10'),
('ACTOR11', 'actor11'),
('ACTOR12', 'actor12'),
('ACTOR13', 'actor13'),
('ACTOR14', 'actor14'),
('ACTOR15', 'actor15'),
('ACTOR16', 'actor16')

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies
SELECT * FROM Actors

INSERT INTO Genres
VALUES
('Genre1'),
('Genre2'),
('Genre3'),
('Genre4'),
('Genre5')

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres

INSERT INTO Directors_Movies
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(2,3),
(2,4),
(2,7),
(2,8),
(3,1),
(3,2),
(3,3),
(3,4),
(3,7)

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres
SELECT * FROM Directors_Movies


INSERT INTO Genres_Movies
VALUES
(1,1),
(1,2),
(2,1),
(2,3),
(2,5),
(3,2),
(4,4),
(4,1),
(5,1),
(6,3),
(7,1),
(7,2),
(8,4),
(8,2)

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres
SELECT * FROM Directors_Movies
SELECT * FROM Genres_Movies

INSERT INTO Actors_Movies
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(2,3),
(2,5),
(2,8),
(3,1),
(3,3),
(3,4),
(3,5),
(3,7),
(3,1),
(4,1),
(4,2),
(5,10),
(5,11),
(5,1),
(5,15),
(6,13),
(6,14),
(7,1),
(7,5),
(7,16),
(7,11),
(8,1),
(8,4),
(8,10)

SELECT * FROM Languages
SELECT * FROM Directors
SELECT * FROM Movies
SELECT * FROM Actors
SELECT * FROM Genres
SELECT * FROM Directors_Movies
SELECT * FROM Genres_Movies
SELECT * FROM Actors_Movies

CREATE OR ALTER PROCEDURE up_GetMovieOfDirector @directorId INT
AS
BEGIN
SELECT m.Name AS 'Movie name', d.Name AS 'Director name', l.Name AS 'Language' FROM Directors AS d
JOIN Directors_Movies AS dm ON d.Id = dm.DirectorId
JOIN Movies AS m ON m.Id = dm.MovieId
JOIN Languages AS l on l.Id = m.LanguageId
where d.Id = @directorId
END

EXEC up_GetMovieOfDirector 3

CREATE OR ALTER FUNCTION GetCountOfFilmsInThisLanguage (@languageid INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*)
    FROM Movies
    WHERE LanguageId = @languageid;
    RETURN @Count;
END

SELECT dbo.GetCountOfFilmsInThisLanguage(2)


CREATE OR ALTER PROCEDURE up_GetFilmByGenre @GenreId INT
AS
BEGIN
	SELECT m.Name AS 'Movie name', d.Name AS 'Director name', g.Name AS 'Genre' FROM Genres AS g
JOIN Genres_Movies AS gm ON g.Id = gm.GenreId
JOIN Movies AS m ON m.Id = gm.MovieId
JOIN Directors_Movies AS dm ON dm.MovieId = m.Id
JOIN Directors AS d ON d.Id = dm.DirectorId
WHERE g.Id = @GenreId
END

EXEC up_GetFilmByGenre 3

CREATE OR ALTER FUNCTION CheckNumberOfFilms (@actorid INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @COUNT = COUNT(a.Id) FROM Actors AS a
	JOIN Actors_Movies AS am ON am.ActorId = a.Id
	JOIN Movies AS m ON m.Id = am.MovieId
    WHERE ActorId = @actorid;
	IF(@Count >=3)
		RETURN 1
	RETURN 0
END

SELECT dbo.CheckNumberOfFilms(3)

CREATE OR ALTER TRIGGER SHOWFilmWithTheirDirectorsAndLanguage
ON Movies
AFTER INSERT
AS
BEGIN
SELECT m.Name AS 'Movie name', d.Name AS 'Director name', l.Name AS 'Language' FROM Movies AS m
JOIN Directors_Movies AS dm ON dm.MovieId = m.Id
JOIN Directors AS d ON d.Id = dm.DirectorId
JOIN Languages AS l ON l.Id = m.LanguageId
GROUP BY m.Name, d.Name, l.Name
END

INSERT INTO Movies
VALUES
('Film9', 'Desc9', 'Photo9', 1)