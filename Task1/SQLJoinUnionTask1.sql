CREATE DATABASE DemoApp
USE DemoApp
CREATE TABLE Countries(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(50) NOT NULL UNIQUE,
Area DECIMAL(18,2),
)

CREATE TABLE Cities(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(50) NOT NULL UNIQUE,
Area DECIMAL(18,2),
CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)

CREATE TABLE People (
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
PhoneNumber  NVARCHAR(19) NOT NULL UNIQUE,
Email  NVARCHAR(50) NOT NULL UNIQUE,
BirthDate DATE NOT NULL CHECK(BirthDate <= GETDATE()),
Gender CHAR(1),
HasCitizenship bit,
CityId INT FOREIGN KEY REFERENCES Cities(Id)
)

INSERT INTO Countries VALUES
('Vatikan',0.49),
('Irlandiya',70.2),
('Iran',1648.19),
('Ispaniya',506),
('Azərbaycan',86.6),
('Russia',17000.4),
('Ingiltere',700.45)

INSERT INTO Cities VALUES
('Baki',2.5,1),
('Moskva',23.7,2),
('Winchester',9.87,3)

INSERT INTO People VALUES
('Sahib','Alili','994122307899','a.alili@gmail.com','1997.09.17','K',1,1),
('Rasim','Mahmudov','994122567899','r.mahmudov@gmail.com','1999.03.12','K',1,1),
('Nastya','Ivanova','073334455678','nn.ivanova@gmail.com','2000.02.02','Q',1,2),
('Jhon','Doe','445551236987','jhn.doe@gmail.com','1998.07.12','K',0,3)

SELECT p.Name PersonName,p.Surname PersonSurname,p.PhoneNumber,p.Email,p.BirthDate,p.Gender,p.HasCitizenship,
ci.Name City,co.Name Country
FROM People p
JOIN Cities ci
ON p.CityId=ci.Id
JOIN Countries co
ON ci.CountryId=co.Id


SELECT *FROM Countries
ORDER BY(Area)

SELECT Name, Area FROM Cities
ORDER BY (Name) DESC

SELECT COUNT(Id) FROM Countries
WHERE Area>20


SELECT MAX(Area)  FROM Countries
WHERE Name LIKE 'I%'

SELECT *FROM Countries
UNION
SELECT Id, Name,Area FROM Cities

SELECT ci.Name,Count(p.Id)
FROM People p
JOIN Cities ci
ON p.CityId=ci.Id
GROUP BY (ci.Name)

SELECT ci.Name,Count(p.Id)
FROM People p
JOIN Cities ci
ON p.CityId=ci.Id
GROUP BY (ci.Name)
HAVING COUNT(p.Id) >2

------------SELECT
SELECT *FROM People
SELECT *FROM Countries
SELECT *FROM Cities

