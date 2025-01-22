CREATE DATABASE LibraryManagement 
USE LibraryManagement

CREATE TABLE Libraries (
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Address NVARCHAR(50) NOT NULL
)

INSERT INTO Libraries VALUES ('Libraff', 'Ganjlik Mall')
INSERT INTO Libraries VALUES ('Ali&Nino', 'Crescent Mall')

CREATE TABLE Books (
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Count INT NOT NULL
)

INSERT INTO Books VALUES ('1984' , 16)
INSERT INTO Books VALUES ('Initial D' , 20)


CREATE TABLE Authors (
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL
)
INSERT INTO Authors VALUES ('Hayao' , 'Miyazaki')
INSERT INTO Authors VALUES ('Ryosuke' , 'Takahashi')

CREATE TABLE Genres (
    Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(50) NOT NULL
)

INSERT INTO Genres VALUES ('THRILLER')
INSERT INTO Genres VALUES ('RACING')

CREATE TABLE BookAuthors (
    BookId INT NOT NULL,
    AuthorId INT NOT NULL,
    PRIMARY KEY (BookId, AuthorId),
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)

INSERT INTO BookAuthors VALUES (1,1)
INSERT INTO BookAuthors VALUES (2,2)

CREATE TABLE BookGenres (
    BookId INT NOT NULL,
    GenreId INT NOT NULL,
    PRIMARY KEY (BookId, GenreId),
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id)
)

INSERT INTO BookGenres  VALUES (1, 1)
INSERT INTO BookGenres  VALUES (2, 2)

CREATE TABLE LibraryBooks (
    LibraryId INT NOT NULL,
    BookId INT NOT NULL,
    PRIMARY KEY (LibraryId, BookId),
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
)

INSERT INTO LibraryBooks  VALUES (1, 1) 
INSERT INTO LibraryBooks  VALUES (1, 2)
INSERT INTO LibraryBooks  VALUES (2, 1)

SELECT * FROM Libraries;
SELECT * FROM Books;
SELECT * FROM Authors;
SELECT * FROM Genres;
SELECT * FROM BookAuthors;
SELECT * FROM BookGenres;
SELECT * FROM LibraryBooks;