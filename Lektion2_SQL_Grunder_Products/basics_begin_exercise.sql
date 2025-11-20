
-- SQL-skript för att skapa tabellen EmployeeTimeStamps
-- Tabellen används för att lagra tidstämplar för anställda vid in-
CREATE TABLE EmployeeTimeStamps (
TimeStampID INT PRIMARY KEY,
EmployeeID INT NOT NULL,
TimeStampType VARCHAR(10) NOT NULL, -- 'In' eller 'Out'
TimeStamp DATETIME NOT NULL,
CardID VARCHAR(20) NOT NULL,
MachineID INT NOT NULL,
MachineName VARCHAR(50) NOT NULL
);

SELECT * FROM EmployeeTimeStamps; och utstämpling.
-- Kontrollera att tabellen har skapats korrekt
SELECT * FROM EmployeeTimeStamps;

