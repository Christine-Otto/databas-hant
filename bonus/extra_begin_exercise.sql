-- =========================================================
-- EXTRA SQL-ÖVNINGAR (NYBÖRJARE) - ÖVNINGAR
-- Fil: extra_begin_exercise.sql
--
-- Fokus:
--   - Repetera tidsfunktioner, filter och sortering i MariaDB
--   - Jobba med in- och utstämplingar från ett passersystem
--   - Öva: WHERE, DISTINCT, DATE(), TIME(), DAYNAME()
--
-- OBS:
--   Den här filen innehåller UPPGIFTERNA, inte lösningarna.
--   Du skriver dina egna SELECT-satser under varje uppgift.
-- =========================================================


-- =========================================================
-- STEG 0: Datum- och tidsfunktioner i MariaDB (teori + test)
-- Syfte:
--   - Känna till CAST/DATE, HOUR, DATEDIFF, DAYNAME
--   - Du kan köra dessa för att se hur de beter sig
-- =========================================================

-- Konvertera ett DATETIME till bara datum
SELECT CAST('2023-11-15 10:30:00' AS DATE) AS OnlyDate;
-- Förväntat: 2023-11-15

-- Hämta timdelen ur ett DATETIME-värde
SELECT HOUR('2023-11-15 10:30:00') AS HourPart;
-- Förväntat: 10

-- Antal hela dagar mellan två datum (slut - start)
SELECT DATEDIFF('2023-11-15', '2023-11-01') AS DaysBetween;
-- Förväntat: 14

-- Veckodag som text, t.ex. 'Wednesday'
SELECT DAYNAME('2023-11-15') AS WeekdayName;
-- Förväntat: Wednesday



-- =========================================================
-- STEG 1: Rensa bort gammal tabell om den finns
-- Syfte:
--   - Göra filen körbar flera gånger (utan "already exists"-fel)
-- =========================================================

DROP TABLE IF EXISTS EmployeeTimeStamps;



-- =========================================================
-- STEG 2: Skapa tabellen EmployeeTimeStamps
-- Syfte:
--   - Skapa en tabell för instämplingar / utstämplingar
--   - Träna på CREATE TABLE med flera kolumner
-- =========================================================

CREATE TABLE EmployeeTimeStamps (

    TimeStampID INT PRIMARY KEY,           -- unikt id för varje stämpling
    EmployeeID INT NOT NULL,               -- id för anställd (101, 102, ...)
    TimeStampType VARCHAR(10) NOT NULL,    -- 'In' eller 'Out'
    TimeStamp DATETIME NOT NULL,           -- datum + klockslag
    CardID VARCHAR(20) NOT NULL,           -- kort-id, t.ex. 'C101'
    MachineID INT NOT NULL,                -- vilken maskin som läste kortet
    MachineName VARCHAR(50) NOT NULL       -- namn på maskinen
);



-- =========================================================
-- STEG 3: Infoga testdata
-- Syfte:
--   - Skapa ett litet "verkligt" dataset
--   - Används i alla uppgifter 1–10
-- =========================================================

INSERT INTO EmployeeTimeStamps (
    TimeStampID, EmployeeID, TimeStampType, TimeStamp,
    CardID, MachineID, MachineName
) VALUES
    (1, 101, 'In',  '2023-11-01 07:30:00', 'C101', 1, 'Office Entrance'),
    (2, 101, 'Out', '2023-11-01 17:00:00', 'C101', 1, 'Office Entrance'),
    (3, 102, 'In',  '2023-11-01 08:15:00', 'C102', 1, 'Office Entrance'),
    (4, 102, 'Out', '2023-11-01 16:45:00', 'C102', 1, 'Office Entrance'),
    (5, 103, 'In',  '2023-11-02 08:05:00', 'C103', 1, 'Office Entrance'),
    (6, 103, 'Out', '2023-11-02 17:10:00', 'C103', 1, 'Office Entrance'),
    (7, 104, 'In',  '2023-11-02 08:20:00', 'C104', 1, 'Office Entrance'),
    (8, 104, 'Out', '2023-11-02 16:50:00', 'C104', 1, 'Office Entrance'),
    (9, 105, 'In',  '2023-11-03 08:30:00', 'C105', 1, 'Office Entrance'),
    (10, 105, 'Out','2023-11-03 17:15:00', 'C105', 1, 'Office Entrance'),
    (11, 106, 'In', '2023-11-03 08:35:00', 'C106', 1, 'Office Entrance'),
    (12, 106, 'Out','2023-11-03 17:20:00', 'C106', 1, 'Office Entrance'),
    (13, 107, 'In', '2023-11-04 08:40:00', 'C107', 1, 'Office Entrance'),
    (14, 101, 'In', '2023-11-04 08:45:00', 'C101', 1, 'Office Entrance'),
    (15, 102, 'In', '2023-11-04 08:50:00', 'C102', 1, 'Office Entrance'),
    (16, 103, 'In', '2023-11-04 08:55:00', 'C103', 1, 'Office Entrance'),
    (17, 104, 'In', '2023-11-04 09:00:00', 'C104', 1, 'Office Entrance'),
    (18, 105, 'In', '2023-11-04 09:05:00', 'C105', 1, 'Office Entrance'),
    (19, 101, 'Out','2023-11-04 17:30:00', 'C101', 2, 'Loading Dock'),
    (20, 102, 'Out','2023-11-04 17:45:00', 'C102', 2, 'Loading Dock');



-- =========================================================
-- UPPGIFT 1: Visa alla instämplingar
-- Syfte:
--   - Hitta alla rader där TimeStampType = 'In'
--   - Träna på WHERE med likhetsjämförelse

SELECT * FROM EmployeeTimeStamps
WHERE TimeStampType = 'In';
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE ...;



-- =========================================================
-- UPPGIFT 2: Visa instämplingar för en viss anställd
-- Syfte:
--   - Kombinera två villkor med AND
--   - Filtrera både på EmployeeID och på 'In'
-- Tips:
--   - EmployeeID = 101 (eller annan siffra du vill testa)
--   - TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE EmployeeID = 101
--   AND ...;



-- =========================================================
-- UPPGIFT 3: Lista unika anställda som stämplat in
-- Syfte:
--   - Använda DISTINCT för att undvika dubbletter
--   - Visa varje EmployeeID bara en gång
-- Tips:
--   - SELECT DISTINCT EmployeeID
--   - WHERE TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT DISTINCT ...
-- FROM EmployeeTimeStamps
-- WHERE ...;



-- =========================================================
-- UPPGIFT 4: Visa alla utstämplingar
-- Syfte:
--   - Samma princip som uppgift 1, men för 'Out'
-- Tips:
--   - WHERE TimeStampType = 'Out'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE ...;



-- =========================================================
-- UPPGIFT 5: Instämplingar efter ett specifikt datum
-- Syfte:
--   - Filtrera på TimeStamp efter ett visst datum/tid
--   - Kombinera med villkoret 'In'
-- Tips:
--   - TimeStamp > '2023-11-01 00:00:00'
--   - AND TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE TimeStamp > '2023-11-01 00:00:00'
--   AND ...;



-- =========================================================
-- UPPGIFT 6: Instämplingar före kl 09.00
-- Syfte:
--   - Plocka ut tiden ur TimeStamp med TIME() eller HOUR()
--   - Visa alla som stämplat in före 09:00
-- Tips:
--   - TIME(TimeStamp) < '09:00:00'
--   - AND TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE TIME(TimeStamp) < '09:00:00'
--   AND ...;



-- =========================================================
-- UPPGIFT 7: Alla in- och utstämplingar från ett specifikt datum
-- Syfte:
--   - Ignorera klockslag, bara jämföra datum
--   - Hämta både In och Out för 2023-11-01
-- Tips:
--   - DATE(TimeStamp) = '2023-11-01'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE DATE(TimeStamp) = '2023-11-01';



-- =========================================================
-- UPPGIFT 8: Instämplingar från en viss plats
-- Syfte:
--   - Filtrera på MachineName + TimeStampType
--   - T.ex. alla instämplingar vid "Office Entrance"
-- Tips:
--   - MachineName = 'Office Entrance'
--   - AND TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE MachineName = 'Office Entrance'
--   AND ...;



-- =========================================================
-- UPPGIFT 9: Instämplingar under en specifik veckodag
-- Syfte:
--   - Använda DAYNAME(TimeStamp)
--   - Filtrera på t.ex. 'Wednesday'
-- Tips:
--   - DAYNAME(TimeStamp) = 'Wednesday'
--   - AND TimeStampType = 'In'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE DAYNAME(TimeStamp) = 'Wednesday'
--   AND ...;



-- =========================================================
-- UPPGIFT 10: Utstämplingar ett visst datum
-- Syfte:
--   - Kombinera DATE(TimeStamp) med villkoret 'Out'
--   - Visa alla utstämplingar ett visst datum (t.ex. 2023-11-01)
-- Tips:
--   - DATE(TimeStamp) = '2023-11-01'
--   - AND TimeStampType = 'Out'
-- =========================================================

-- Skriv din lösning här:
-- SELECT ...
-- FROM EmployeeTimeStamps
-- WHERE DATE(TimeStamp) = '2023-11-01'
--   AND ...;



-- =========================================================
-- SLUTKOLL: Se all data
-- Syfte:
--   - Kunna kika på hela tabellen när som helst
-- =========================================================

SELECT *
FROM EmployeeTimeStamps;
