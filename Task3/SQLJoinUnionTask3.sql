USE DemoApp

CREATE TABLE Movies (
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(255) NOT NULL,
ReleaseDate DATE CHECK(ReleaseDate<=GETDATE()),
IMDB DECIMAL(3,1) CHECK(IMDB BETWEEN 0 AND 10)
)
ALTER TABLE Movies
DROP CONSTRAINT CK__Movies__ReleaseD__4CA06362

CREATE TABLE Actors(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(55) NOT NULL,
SurName NVARCHAR(55) NOT NULL,
)

CREATE TABLE ActorsMovies(
Id INT PRIMARY KEY IDENTITY(1,1),
ActorId INT FOREIGN KEY REFERENCES Actors(Id),
MovieId INT FOREIGN KEY REFERENCES Movies(Id)
)

CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(35) NOT NULL UNIQUE
)

CREATE TABLE GenresMovies(
Id INT PRIMARY KEY IDENTITY(1,1),
GenreId INT FOREIGN KEY REFERENCES Genres(Id),
MovieId INT FOREIGN KEY REFERENCES Movies(Id)
)

INSERT INTO Movies VALUES
('Avatar 3','2025.12.19',8.3), 
('Dune Part 3','2026.12.18',8.3), 
('IF','2024.05.17',6.5), 
('Oppenheimer','2023.07.21',8.3), 
('The Intouchables','2011.11.02',8.5),
('Father & Soldier','2023.01.04',5.9),
('The Fall Guy','2024.05.03',7)

INSERT INTO Genres VALUES
('Adventure'), ('Sci-Fi'),('Action'),('Comedy'),('Historical'),('War'),
('Thriller'),('Drama'),('Family')

INSERT INTO Actors VALUES
('Zoe','Saldana') ,                          -- AVTAR 3
('Sam','Worthington'),                        --Avatar 3
('Austin','Butler'),                       --DUNE pArt3
('Zendaya','Maree'),                        --Dune Part3 
('Emily','Blunt'),                       --openhaimer/If/The Fall Guy
('Cillian','Murphy'),                     ---openhaimer
('Matt','Damon'),                       ---Openhaimer
('Brad','Pitt'),                           --IF
('Cailey','Fleming') ,                     --IF
('Omar','Sy'),                            -- Intouch / FatherSoldier
('Audrey','Fleurot'),                      --Intouch
('François','Cluzet'),                     --Intouch
('Alassane','Diong'),                     ---FatherSoldier
('Alassane','Sy') ,                         --FatherSoldier
('Lea','Carne'),                            ---FatherSoldier
('Ryan','Gosling'),                           ---The Fall Guy
('Lee','Majors'),                          ---The Fall Guy
('Teresa','Palmer')                      --The Fall Guy

INSERT INTO ActorsMovies VALUES
(18,11),(17,11),
(16,10),(15,10),
(1,1),(1,4),(1,5),
(2,1),(3,1),
(4,5),(5,5),
(6,2),(6,3),(7,2),(8,2),
(9,3),(10,3),(11,3),
(12,4),(13,4),(14,4)


 -- openhaimer Thriller/Historical ; Intouch Comedy/Drama ; FatherSoldier War/Action ; TheFallGuy Action/Comedy ; If Family Comedy
 INSERT INTO GenresMovies VALUES
(9,10),(8,10), (8,11),
(3,1),(5,1),
(2,2),(6,2),
(1,3),(4,3),
(1,4),(2,4),
(2,5),(7,5)

---a. En cox rol oynayan aktyorlarin siyahisi
SELECT a.Name ,a.SurName,COUNT(ac.MovieId) MOviesCount FROM Actors a
JOIN ActorsMovies ac
ON a.Id=ac.ActorId
GROUP BY a.Name,a.SurName
ORDER BY COUNT(ac.MovieId )DESC

---b. Her janrdan nece dene movie olmmagi
SELECT g.Name,COUNT(gm.MovieId) MoviesCount FROM Genres g
JOIN GenresMovies gm
ON g.Id=gm.GenreId
GROUP BY g.Name

---c. Release tarixi gozlenilen kinolar ve ne vaxt release olunacagi

SELECT m.Name Movie,g.Name Genre,m.ReleaseDate FROM Movies m
JOIN GenresMovies gm
ON gm.MovieId=m.Id
JOIN Genres g
ON gm.GenreId=g.Id
WHERE ReleaseDate>GEtDATE()

--d. Son 5 ilde release olan kinolarin ortalama IMDB-si
SELECT AVG(IMDB)AVG_IMDB FROM Movies m
WHERE  m.ReleaseDate>=DATEADD(YEAR,-5,GETDATE())

-------------e. 1 den cox kinoda oynayan aktyorlarin siyahisi
SELECT a.Name,a.SurName ,COUNT(ac.MovieId) FROM Actors a
JOIN ActorsMovies ac
ON a.Id=ac.ActorId
GROUP BY a.Name,a.SurName
HAVING COUNT(ac.ActorId)>1

