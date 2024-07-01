USE DemoApp
CREATE TABLE Sellers (
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(55) NOT NULL,
Surname NVARCHAR(55) NOT NULL,
City  NVARCHAR(55) NOT NULL,
)

CREATE TABLE Customers (
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(55) NOT NULL,
Surname NVARCHAR(55) NOT NULL,
City  NVARCHAR(55) NOT NULL,
)

CREATE TABLE OrderStates(
Id INT PRIMARY KEY IDENTITY(1,1),
[Name] NVARCHAR(15) NOT NULL UNIQUE,
)

ALTER TABLE OrderStates ALTER COLUMN [Name]  NVARCHAR(25)

CREATE TABLE Orders (
Id INT PRIMARY KEY IDENTITY(1,1),
OrderDate DATETIME DEFAULT GETDATE() CHECK(OrderDate<=GETDATE()),
Amount DECIMAL(18,2) CHECK(Amount>0),
OrderStateId INT FOREIGN KEY REFERENCES OrderStates(Id),
CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
SellerId INT FOREIGN KEY REFERENCES Sellers(Id)
)


INSERT INTO Sellers VALUES
('Sahil','Nezerli','Baki'),
('Burhan','Babazade','Lenkeran'),
('Rasim','Mahmudov','Balaken'),
('Roya','Namazova','Baki'),
('Murad','Azerli','Baki'),
('Ramil','Ugurzade','Gence'),
('Nebi','Eliyev','Balaken'),
('Asif','Memmedli','Ordubad'),
('Zinnet','Ehmedova','Gence')


INSERT INTO Customers VALUES
('Rasim','Rasimli','Balaken'),
('Bekir','Babazade','Gence'),
('Ali','Muradzade','Balaken'),
('Samire','Alili','Baki'),
('Azer','Muradli','Baki'),
('Ramina','Abbasli','Baki'),
('Selim','Selimov','Culfa'),
('Asime','Memmedova','Ordubad'),
('Sona','Aydinova','Sumqayit')

INSERT INTO OrderStates VALUES
('Hazirlanir'),
('Catdirilmada'),
('GelAl noqtesinde'),
('Tamamlanib')

INSERT INTO Orders VALUES
('2024.06.29 14:12',667,7,5,3),
('2020.01.21 11:12',99.25,7,7,1),
('2024.04.29 14:12',667,7,5,3),
('2023.04.29 10:12',2669.25,7,8,3),
('2024.01.21 11:12',6699.25,4,7,1),
('2022.06.29 14:12',6629.25,7,5,3),
('2022.12.29 14:12',669.25,7,7,1),

('2022.06.29 14:12',669.25,7,5,3),
('2021.06.29 14:12',125.74,7,8,8),
('2024.01.19 15:25',12055.13,7,1,8),
('2023.09.19 16:46', 1540.99,7,2,7),
('2024.06.25 19:25',12055,5,3,6),
('2024.06.28 18:28',12055,6,4,5),
('2024.06.23 23:24',2055,5,5,4),
('2024.06.01 11:01',12055,6,6,3),
('2024.06.25 15:55',12055,4,7,2),
('2024.06.29 14:12',12055,4,8,1),


---a. Umumi sifaris meblegleri 1000manatdan yuxari olan musterilerin meblegle birlikde siyahisi

SELECT s.Name CustomerName ,s.Surname CustomerSurname,s.City, 
SUM(o.Amount) TotalAmount
FROM Sellers s
JOIN Orders o
ON s.Id=o.CustomerId
GROUP BY s.Name,s.Surname,s.City
HAVING SUM(o.Amount)>1000
 
---b. Eyni seherde qalan musteri ve saticilarin siyahisi
SELECT s.Name SellerName ,s.Surname SellerSurname,
c.Name CustomerName ,c.Surname CustomerSurname,
c.City
FROM Sellers s 
JOIN Customers c
ON s.City=c.City


--c. Sifaris tarixi 2024-01-04 den bugune kimi olan ve tamamlanmis sifarislerin siyahisi
SELECT  o.OrderDate ,o.Amount,os.Name State,
c.Name CustomerName,c.Surname CustomerSurName,
s.Name SellerName, s.Surname SellerSurName
FROM Orders o
JOIN OrderStates os
ON  o.OrderStateId=os.Id
JOIN Customers c
ON  o.CustomerId=c.Id
JOIN Sellers s
ON  o.SellerId=s.Id
WHERE o.OrderDate>='2024.01.04 00:00'  AND o.OrderStateId=7

----d. 2 den cox sifaris tamamlayan saticilarin siyahisi
SELECT s.Name SellerName,s.Surname SellerSurname,s.City ,os.Name OrderState ,COUNT(o.Id) TotalOrders
FROM Sellers s
JOIN Orders o
ON s.Id=o.SellerId
JOIN OrderStates os
ON os.Id=o.OrderStateId
GROUP BY s.Name,s.Surname,s.City,os.Name
HAVING COUNT(o.Id)>2

--------e. En cox sifarisi olan musterilerin siyahisi
SELECT c.Name,c.Surname ,c.City,COUNT(o.Id) OrderCount
FROM Customers c
JOIN  Orders o
ON c.Id=o.CustomerId
GROUP BY c.Name, c.Surname, c.City
ORDER BY COUNT(o.Id) DESC


--f. Sifaris tarixi en evvel olan ve tamamlanmamis sifarislerin satici melumatlari ile birge tarixe gore siyahisi 
SELECT  o.OrderDate,o.Amount,os.Name OrderState,s.Name SellerName,s.Surname SellerSurname,s.City
FROM Orders o
JOIN OrderStates os
ON o.OrderStateId=os.Id
JOIN Sellers s
ON o.SellerId=s.Id
WHERE NOT os.Name='Tamamlanib'
ORDER BY (o.OrderDate) 


--g. Son 1 ayda tamamlanmislarin siyahisi
SELECT  o.OrderDate,o.Amount,os.Name OrderState,s.Name SellerName,s.Surname SellerSurname,s.City
FROM Orders o
JOIN OrderStates os
ON o.OrderStateId=os.Id
JOIN Sellers s
ON o.SellerId=s.Id
WHERE  os.Name='Tamamlanib'
AND o.OrderDate>=DATEADD(MONTH,-1,GETDATE())

---------------------------
SELECT *FROM Sellers
SELECT *FROM Customers
SELECT *FROM OrderStates
SELECT *FROM Orders