-- =========================================================
-- INDEX_EXERCISE.SQL
-- Lektion 5 – Index och Optimering
-- Komplett och noggrant kommenterat skript
-- =========================================================

-- =========================================================
-- STEG 1: SKAPA TABELLEN ORDERS
-- =========================================================
-- Vi använder denna tabell för att jämföra prestanda
-- före och efter index.
-- Kolumner:
--   OrderID       – unikt ID
--   CustomerName  – namn på kund
--   City          – stad (vanligt filter → bra kandidat för index)
--   OrderDate     – datum för köp
--   TotalAmount   – summa (vanligt filter → index senare)

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    City VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- (Valfritt) Töm tabellen om du behöver börja om:
-- TRUNCATE TABLE Orders;


-- =========================================================
-- STEG 2: INFOGA EXEMPELDATA
-- =========================================================
-- INSERT IGNORE gör att data inte dupliceras om du kör skriptet flera gånger.

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

-- Kontrollera att datan finns
SELECT * FROM Orders;


-- =========================================================
-- STEG 3: KÖR FRÅGOR UTAN INDEX
-- =========================================================
-- Testa att söka på City eller TotalAmount innan index skapas.

-- Hitta alla orders i Stockholm
SELECT *
FROM Orders
WHERE City = 'Stockholm';

-- Hitta alla orders över 1000 kr
SELECT *
FROM Orders
WHERE TotalAmount > 1000;


-- =========================================================
-- STEG 4: SKAPA INDEX
-- =========================================================
-- Index gör sökning snabbare, särskilt på stora tabeller.
-- Här skapar vi index på kolumner vi ofta söker på.

-- Index på City
CREATE INDEX idx_orders_city
ON Orders (City);

-- Index på TotalAmount
CREATE INDEX idx_orders_totalamount
ON Orders (TotalAmount);

-- Visa alla index på Orders
SHOW INDEX FROM Orders;


-- =========================================================
-- STEG 5: KÖR SAMMA FRÅGOR MED INDEX
-- =========================================================
-- Resultatet är detsamma – men databasen använder index internt.

SELECT *
FROM Orders
WHERE City = 'Stockholm';

SELECT *
FROM Orders
WHERE TotalAmount > 1000;


-- =========================================================
-- STEG 6: TA BORT INDEX (OM DU VILL TESTA)
-- =========================================================
-- DROP INDEX tar bort ett index från tabellen.

-- Ta bort index på City
-- DROP INDEX idx_orders_city ON Orders;

-- Ta bort index på TotalAmount
-- DROP INDEX idx_orders_totalamount ON Orders;


-- =========================================================
-- STEG 7: EXPLAIN – VISA QUERY PLAN
-- =========================================================
-- EXPLAIN visar hur databasen planerar att köra frågan.
-- Nyttigt för att förstå om index används.

EXPLAIN SELECT *
FROM Orders
WHERE City = 'Stockholm';


-- =========================================================
-- SAMMANFATTNING – VAD DU HAR TRÄNAT
-- =========================================================
-- ✔ Skapa tabell för prestandatestning
-- ✔ Infoga testdata
-- ✔ Sökning utan index
-- ✔ Skapa index på två kolumner
-- ✔ Kontrollera index med SHOW INDEX
-- ✔ Sökning med index
-- ✔ Ta bort index
-- ✔ EXPLAIN för att förstå optimering
--
-- Detta är hela grunden för Lektion 5: Optimering & Index.
-- Nu är du redo för nästa steg: Transaktioner och administration!
-- =========================================================
