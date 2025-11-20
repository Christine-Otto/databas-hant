-- =========================================================
-- INDEX_EXERCISE.SQL – INDEX & OPTIMERING (LEKTION 5)
-- =========================================================
-- Syfte:
--   - Förstå vad ett index är
--   - Skapa och ta bort index
--   - Se på vilka kolumner det är vettigt att indexera
--   - Testa queries med och utan index
-- =========================================================


-- =========================================================
-- DEL 1 – SKAPA EN ENKEL TABELL FÖR INDEX-ÖVNINGAR
-- =========================================================

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    City VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- (Valfritt: töm tabellen om du vill börja om)
-- TRUNCATE TABLE Orders;


-- =========================================================
-- FYLL TABELLEN MED EXEMPELORDERS
-- (INSERT IGNORE gör att det inte kraschar om du kör flera gånger)
-- =========================================================

INSERT IGNORE INTO Orders (OrderID, CustomerName, City, OrderDate, TotalAmount) VALUES
  (1, 'Anna Andersson', 'Stockholm', '2024-01-10', 1200.50),
  (2, 'Björn Berg',     'Göteborg',  '2024-01-11',  899.00),
  (3, 'Cecilia Carl',   'Malmö',     '2024-01-12',  499.00),
  (4, 'David Dahl',     'Stockholm', '2024-01-13', 1999.00),
  (5, 'Erik Ek',        'Uppsala',   '2024-01-14',  299.00),
  (6, 'Frida Frost',    'Göteborg',  '2024-01-15',  799.00),
  (7, 'Göran Gran',     'Stockholm', '2024-01-16',  150.00),
  (8, 'Helena Holm',    'Malmö',     '2024-01-17',  650.00),
  (9, 'Ida Is',         'Uppsala',   '2024-01-18', 2200.00),
  (10,'Jonas Jul',      'Stockholm', '2024-01-19',  999.00);

-- Kolla att datan finns
-- SELECT * FROM Orders;



-- =========================================================
-- DEL 2 – KÖR EN VANLIG SÖKFRÅGA (UTAN EXTRA INDEX)
-- =========================================================

-- Hitta alla orders i Stockholm:
SELECT *
FROM Orders
WHERE City = 'Stockholm';

-- Hitta ordrar över 1000 kr:
SELECT *
FROM Orders
WHERE TotalAmount > 1000;



-- =========================================================
-- DEL 3 – SKAPA INDEX
-- =========================================================
-- Index hjälper databasen att snabbare hitta rader baserat på en kolumn.
-- Bra kandidater:
--   - kolumner som ofta används i WHERE
--   - kolumner som används i JOIN-villkor

-- Skapa index på City
CREATE INDEX idx_orders_city
ON Orders (City);

-- Skapa index på TotalAmount
CREATE INDEX idx_orders_totalamount
ON Orders (TotalAmount);

-- Visa befintliga index i tabellen (MariaDB):
SHOW INDEX FROM Orders;



-- =========================================================
-- DEL 4 – SAMMA FRÅGOR, NU MED INDEX
-- (I små tabeller märks det inte så mycket, men i verkligheten gör det stor skillnad.)
-- =========================================================

-- Samma fråga som innan – men nu använder databasen index:
SELECT *
FROM Orders
WHERE City = 'Stockholm';

SELECT *
FROM Orders
WHERE TotalAmount > 1000;



-- =========================================================
-- DEL 5 – TA BORT INDEX (OM DU VILL TESTA)
-- =========================================================

-- Ta bort index på City:
-- DROP INDEX idx_orders_city ON Orders;

-- Ta bort index på TotalAmount:
-- DROP INDEX idx_orders_totalamount ON Orders;



-- =========================================================
-- CHEAT SHEET – INDEX
-- =========================================================
-- VAD ÄR ETT INDEX?
--   - Ett index är som ett extra register bredvid tabellen.
--   - Gör sökningar snabbare (särskilt på stora tabeller).
--
-- NÄR SKA MAN INDEXERA?
--   ✔ kolumner du ofta använder i WHERE
--   ✔ kolumner du ofta JOIN:ar på
--   ✔ ibland kolumner du sorterar mycket på (ORDER BY)
--
-- NÄR SKA MAN INTE INDEXERA?
--   ✘ kolumner med nästan samma värde i alla rader (t.ex. boolean)
--   ✘ små tabeller där vinsten är obefintlig
--   ✘ kolumner som ändras hela tiden (UPDATE-kostnad ökar)
--
-- KOMMANDON:
--   Skapa index:
--     CREATE INDEX index_namn ON Tabell(Kolumn);
--
--   Ta bort index:
--     DROP INDEX index_namn ON Tabell;
--
--   Visa index (MariaDB):
--     SHOW INDEX FROM Tabell;
-- =========================================================
