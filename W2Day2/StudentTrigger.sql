CREATE database StudentTrigger
USE StudentTrigger

CREATE TABLE Groups(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Limit INT NOT NULL,
	BeginDate DATE NOT NULL,
	EndDate DATE NOT NULL
)
CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50) NOT NULL,
	Surname NVARCHAR(50) NOT NULL,
	Email NVARCHAR(100) NOT NULL UNIQUE,
	PhoneNumber NVARCHAR(20) NOT NULL default '994000000000',
	BirthDate DATE NOT NULL,
	GPA DECIMAL(5,2) NOT NULL CHECK(GPA <= 100 AND GPA >= 0),
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)


CREATE OR ALTER TRIGGER CombinedCheck ON Students
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @Age DATE
	DECLARE @limit INT
    DECLARE @count INT
    DECLARE @groupId INT
    
    SELECT @groupId = GroupId FROM inserted
    SELECT @count = COUNT(Id) FROM Students
    WHERE GroupId = @groupId
    SELECT @limit = Limit FROM Groups
    WHERE Id = @groupId

    
    SELECT @Age = BirthDate FROM inserted
	IF @Age > GETDATE()-365.25*16 
	BEGIN
		RAISERROR('Student is below the age limit', 10, 1)
		RETURN
	END


CREATE OR ALTER TRIGGER CheckStudentsInGroup ON Students
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @limit INT
    DECLARE @count INT
    DECLARE @groupId INT
    
    SELECT @groupId = GroupId FROM inserted
    SELECT @count = COUNT(Id) FROM Students
    WHERE GroupId = @groupId
    SELECT @limit = Limit FROM Groups
    WHERE Id = @groupId
    IF @count >= @limit
    BEGIN
        RAISERROR('Your group is full', 10, 1)
        RETURN
    END
    INSERT INTO Students(Name, Surname, Email, PhoneNumber, BirthDate, GPA, GroupId)
    SELECT Name, Surname, Email, PhoneNumber, BirthDate, GPA, GroupId FROM inserted
END


CREATE OR ALTER TRIGGER CheckAgeOfStudents ON Students
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Age DATE
    
    SELECT @Age = BirthDate FROM inserted
	IF @Age > GETDATE()-365.25*16
	BEGIN
		RAISERROR('Student is young', 10, 1)
		RETURN
	END
    INSERT INTO Students(Name, Surname, Email, PhoneNumber, BirthDate, GPA, GroupId)
    SELECT Name, Surname, Email, PhoneNumber, BirthDate, GPA, GroupId FROM inserted

END


INSERT INTO Groups
VALUES
('Group1', 2, '2024-01-10', '2025-01-01'),
('Group2', 4, '2023-06-10', '2024-02-01'),
('Group3', 5, '2022-01-10', '2025-01-01'),
('Group4', 2, '2021-02-10', '2023-01-01')

SELECT * FROM Groups

INSERT INTO Students
VALUES
('Name1', 'Surname1', 'name1name1@code.edu.az', default, '2006-01-01', 85.6, 1),
('Name2', 'Surname2', 'name2name2@code.edu.az', default, '2006-01-01', 90.0, 1)

INSERT INTO Students
VALUES
('Name3', 'Surname3', 'name3name3@code.edu.az', default, '2000-01-01', 85, 1)
INSERT INTO Students
VALUES
('Name4', 'Surname5', 'name4name4@code.edu.az', default, '2006-01-01', 85.67, 4),
('Name5', 'Surname5', 'name5name5@code.edu.az', default, '2006-01-01', 95, 4)
INSERT INTO Students
VALUES
('Name6', 'Surname6', 'name6name6@code.edu.az', default, '2012-01-01', 85, 4)


CREATE OR ALTER FUNCTION GetAvgGPAByGroup (@groupid INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
	DECLARE @avg DECIMAL(5,2)
	SELECT @avg = AVG(GPA) FROM Students
	WHERE GroupId = @groupid
	RETURN @avg
END



SELECT dbo.GetAvgGPAByGroup(1)