-- =========================================================
-- EXTRA SQL-ÖVNINGAR (NYBÖRJARE) - LÖSNINGAR
-- Källa: "Lösningar: Extra SQL-övningar (Nybörjare)"
--
-- Fokus:
--   - Repetera datum- och tidsfunktioner i MariaDB
--   - Öva filter (WHERE) i ett verkligt scenario
--   - Jobba mot tabellen EmployeeTimeStamps
--
-- Rekommenderad körning:
--   1) Kör ev. DROP TABLE (rensa gammalt)
--   2) Kör CREATE TABLE
--   3) Kör INSERT med testdata
--   4) Kör uppgift 1–10 en efter en
-- =========================================================


-- =========================================================
-- STEG 0: Datum- och tidsfunktioner i MariaDB
-- Syfte:
--   - Förstå CAST, HOUR, DATEDIFF, DAYNAME
--   - Dessa SELECT-satser är "fria" exempel du kan testa
-- =========================================================

-- CAST + DATE: ta bara ut datumdelen från ett DATETIME-värde
SELECT CAST('2023-11-15 10:30:00' AS DATE) AS OnlyDate;
-- Förväntat: 2023-11-15

-- HOUR: plockar ut timmen (0–23) från ett DATETIME-värde
SELECT HOUR('2023-11-15 10:30:00') AS HourPart;
-- Förväntat: 10

-- DATEDIFF: hur många hela dagar mellan två datum (slut - start)
SELECT DATEDIFF('2023-11-15', '2023-11-01') AS DaysBetween;
-- Förväntat: 14

-- DAYNAME: ger veckodagen som text, t.ex. 'Wednesday'
SELECT DAYNAME('2023-11-15') AS WeekdayName;
-- Förväntat: Wednesday



-- =========================================================
-- STEG 1: Rensa gammal tabell om den finns
-- Syfte:
--   - Undvika felet "Table 'EmployeeTimeStamps' already exists"
--   - Göra filen körbar flera gånger i rad
-- =========================================================

DROP TABLE IF EXISTS EmployeeTimeStamps;



-- =========================================================
-- STEG 2: Skapa tabellen EmployeeTimeStamps
-- Syfte:
--   - Skapa en tabell som representerar in/ut-stämplingar
--   - Träna på CREATE TABLE med flera kolumner
-- =========================================================

CREATE TABLE EmployeeTimeStamps (
    -- Unikt id för varje stämpling (rad)
    TimeStampID INT PRIMARY KEY,

    -- Vilken anställd (t.ex. 101, 102 ...)
    EmployeeID INT NOT NULL,

    -- Typ av stämpling: 'In' eller 'Out'
    TimeStampType VARCHAR(10) NOT NULL,

    -- Datum + klockslag för själva stämplingen
    TimeStamp DATETIME NOT NULL,

    -- Kort-id (badge), t.ex. "C101"
    CardID VARCHAR(20) NOT NULL,

    -- Vilken maskin (nummer) som registrerat stämplingen
    MachineID INT NOT NULL,

    -- Namnet på maskinen (vänligare än bara id)
    MachineName VARCHAR(50) NOT NULL
);



-- =========================================================
-- STEG 3: Lägg in testdata i EmployeeTimeStamps
-- Syfte:
--   - Skapa realistisk data att öva filtrering på
--   - Olika dagar, tider, personer, in/ut, maskiner
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
--   - Filtrera på TimeStampType = 'In'
--   - Förstå enkel WHERE på textkolumn
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE TimeStampType = 'In';



-- =========================================================
-- UPPGIFT 2: Visa instämplingar för en viss anställd
-- Syfte:
--   - Kombinera villkor med AND
--   - Filtrera både på EmployeeID och TimeStampType
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE EmployeeID = 101          -- specifik anställd
  AND TimeStampType = 'In';     -- bara instämplingar



-- =========================================================
-- UPPGIFT 3: Lista unika anställda som stämplat in
-- Syfte:
--   - Använda DISTINCT för att ta bort dubbletter
--   - Visa varje EmployeeID bara en gång
-- =========================================================

SELECT DISTINCT EmployeeID
FROM EmployeeTimeStamps
WHERE TimeStampType = 'In';

-- =========================================================
-- UPPGIFT 4: Visa alla utstämplingar
-- Syfte:
--   - Samma idé som uppgift 1, fast för 'Out'
--   - Filtrera på TimeStampType = 'Out'
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE TimeStampType = 'Out';



-- =========================================================
-- UPPGIFT 5: Instämplingar efter ett specifikt datum
-- Syfte:
--   - Jämföra DATETIME med ett visst klockslag
--   - Här: alla instämplingar efter 2023-11-01 00:00:00
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE TimeStamp > '2023-11-01 00:00:00'
  AND TimeStampType = 'In';



-- =========================================================
-- UPPGIFT 6: Instämplingar före kl 09.00
-- Syfte:
--   - Använda TIME(TimeStamp) för att plocka ut tiden
--   - Filtrera fram alla som stämplat in före 09:00
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE TIME(TimeStamp) < '09:00:00'
  AND TimeStampType = 'In';



-- =========================================================
-- UPPGIFT 7: Alla in- och utstämplingar från ett specifikt datum
-- Syfte:
--   - Jobba med DATE(TimeStamp) för att bara jämföra datum
--   - Visa ALLA stämplingar (både In och Out) för 2023-11-01
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE DATE(TimeStamp) = '2023-11-01';



-- =========================================================
-- UPPGIFT 8: Instämplingar från en viss plats
-- Syfte:
--   - Filtrera på MachineName och TimeStampType samtidigt
--   - Här: alla instämplingar vid "Office Entrance"
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE MachineName = 'Office Entrance'
  AND TimeStampType = 'In';



-- =========================================================
-- UPPGIFT 9: Instämplingar under en specifik veckodag
-- Syfte:
--   - Använda DAYNAME(TimeStamp)
--   - Filtrera på t.ex. alla "Wednesday"-instämplingar
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE DAYNAME(TimeStamp) = 'Wednesday'
  AND TimeStampType = 'In';



-- =========================================================
-- UPPGIFT 10: Utstämplingar ett visst datum
-- Syfte:
--   - Kombinera DATE(TimeStamp) med TimeStampType = 'Out'
--   - Visa alla utstämplingar den 2023-11-01
-- =========================================================

SELECT *
FROM EmployeeTimeStamps
WHERE DATE(TimeStamp) = '2023-11-01'
  AND TimeStampType = 'Out';



-- =========================================================
-- SLUTKOLL: Inspektera hela tabellen
-- Syfte:
--   - Se all data efter att du kört uppgifterna
-- =========================================================

SELECT *
FROM EmployeeTimeStamps;
-- Förväntat: Alla rader i tabellen EmployeeTimeStamps ska visas nu.
-- =========================================================


-- ==========================================================
-- SLUT PÅ FILEN