-- =========================================================
-- PRODUCTS_EXERCISE.SQL
-- Lektion 2 – SQL-grunder (SELECT, WHERE, ORDER BY, COUNT, UPDATE, DELETE)
-- Denna fil samlar alla övningar vi gjort med tabellen Products.
-- Varje block är kommenterat så att du kan använda filen som stöd när du pluggar.
-- =========================================================


-- =========================================================
-- STEG 1: SKAPA TABELLEN PRODUCTS
-- =========================================================
-- IF NOT EXISTS gör att kommandot inte kraschar om tabellen redan finns.
-- ProductID  = unik nyckel (PRIMARY KEY)
-- ProductName = produktens namn (text)
-- Price      = pris, med två decimaler
-- Category   = vilken typ av produkt (Food, Drink, Snack, etc.)

CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10,2),
    Category VARCHAR(100)
);

-- (Valfritt) Om du vill börja om från början kan du tömma tabellen:
-- TRUNCATE TABLE Products;


-- =========================================================
-- STEG 2: INFOGA EXEMPELDATA I PRODUCTS
-- =========================================================
-- INSERT IGNORE gör att samma rad inte infogas två gånger
-- om du kör skriptet flera gånger.

INSERT IGNORE INTO Products (ProductID, ProductName, Price, Category) VALUES
    (1, 'Apple',      5.00,  'Food'),
    (2, 'Bread',      12.00, 'Food'),
    (3, 'Cola',       15.00, 'Drink'),
    (4, 'Milk',       10.00, 'Drink'),
    (5, 'Chocolate',  20.00, 'Snack');

-- Kontrollera att produkterna finns:
SELECT * FROM Products;


-- =========================================================
-- STEG 3: SELECT – HÄMTA DATA FRÅN TABELLEN
-- =========================================================
-- SELECT * hämtar ALLA kolumner och ALLA rader.

-- 3.1: Visa alla produkter, alla kolumner
SELECT *
FROM Products;

-- 3.2: Visa bara vissa kolumner (ProductName och Price)
-- Används när du inte behöver hela raden.
SELECT
    ProductName,
    Price
FROM Products;


-- =========================================================
-- STEG 4: WHERE – FILTRERA FRAM VISS DATA
-- =========================================================
-- WHERE begränsar vilka rader som kommer med i resultatet.

-- 4.1: Visa produkter med pris över 10
SELECT *
FROM Products
WHERE Price > 10;

-- 4.2: Visa produkter som kostar mindre än eller lika med 10
SELECT *
FROM Products
WHERE Price <= 10;

-- 4.3: Visa alla produkter i kategorin "Food"
SELECT *
FROM Products
WHERE Category = 'Food';

-- 4.4: Flera villkor med AND (både villkor måste vara sanna)
-- Visa produkter som kostar mer än 10 OCH som är Food.
SELECT *
FROM Products
WHERE Price > 10
  AND Category = 'Food';

-- 4.5: Alternativa villkor med OR (något av villkoren räcker)
-- Visa produkter som är Food ELLER Drink.
SELECT *
FROM Products
WHERE Category = 'Food'
   OR Category = 'Drink';

-- 4.6: IN – smidigt sätt att skriva flera alternativ
-- Samma som OR, men kompaktare.
SELECT *
FROM Products
WHERE Category IN ('Food', 'Snack');

-- 4.7: BETWEEN – intervall (inklusive gränserna)
-- Visa produkter med pris mellan 5 och 15 (5 och 15 är med).
SELECT *
FROM Products
WHERE Price BETWEEN 5 AND 15;


-- =========================================================
-- STEG 5: ORDER BY – SORTERA RESULTATET
-- =========================================================
-- ORDER BY används för att sortera raderna i resultatet.
-- ASC = stigande (lägsta först), DESC = fallande (högsta först).

-- 5.1: Sortera produkterna efter pris, stigande
SELECT *
FROM Products
ORDER BY Price ASC;

-- 5.2: Sortera produkterna efter pris, fallande
SELECT *
FROM Products
ORDER BY Price DESC;

-- 5.3: Sortera alfabetiskt efter produktnamn
SELECT *
FROM Products
ORDER BY ProductName ASC;


-- =========================================================
-- STEG 6: LIMIT – BEGRÄNSA ANTAL RADER
-- =========================================================
-- LIMIT används för att bara visa t.ex. de första 3 raderna.

-- 6.1: Visa de första 3 produkterna
SELECT *
FROM Products
ORDER BY ProductID ASC
LIMIT 3;


-- =========================================================
-- STEG 7: COUNT – RÄKNA RADER
-- =========================================================
-- COUNT(*) räknar hur många rader det finns i resultatet.

-- 7.1: Räkna hur många produkter som finns i tabellen
SELECT
    COUNT(*) AS NumberOfProducts
FROM Products;

-- 7.2: Räkna hur många produkter som är Food
SELECT
    COUNT(*) AS FoodProducts
FROM Products
WHERE Category = 'Food';

-- 7.3: Räkna hur många produkter som kostar mer än 10
SELECT
    COUNT(*) AS ExpensiveProducts
FROM Products
WHERE Price > 10;


-- =========================================================
-- STEG 8: UPDATE – ÄNDRA DATA I TABELLEN
-- =========================================================
-- UPDATE ändrar befintliga rader.
-- VIKTIGT: Använd alltid WHERE, annars uppdateras ALLA rader.

-- 8.1: Ändra priset på Bread (ProductID = 2) till 18.00
UPDATE Products
SET Price = 18.00
WHERE ProductID = 2;

-- Kontrollera uppdateringen:
SELECT *
FROM Products
WHERE ProductID = 2;


-- =========================================================
-- STEG 9: DELETE – TA BORT DATA FRÅN TABELLEN
-- =========================================================
-- DELETE tar bort rader.
-- VIKTIGT: Använd alltid WHERE, annars raderas ALLA rader.

-- 9.1: Ta bort produkten med ProductID = 3 (Cola)
DELETE FROM Products
WHERE ProductID = 3;

-- Kontrollera att raden är borta
SELECT *
FROM Products;


-- =========================================================
-- STEG 10: SAMMANFATTNING
-- =========================================================
-- I denna fil har du tränat på:
--   ✔ CREATE TABLE  – skapa tabell
--   ✔ INSERT         – lägga till rader
--   ✔ SELECT *       – visa alla kolumner
--   ✔ SELECT kolumn  – visa vissa kolumner
--   ✔ WHERE          – filtrera rader
--   ✔ AND / OR       – kombinera villkor
--   ✔ IN / BETWEEN   – fler villkor på ett smidigt sätt
--   ✔ ORDER BY       – sortera resultatet
--   ✔ LIMIT          – begränsa antal rader
--   ✔ COUNT          – räkna rader
--   ✔ UPDATE         – uppdatera värden
--   ✔ DELETE         – ta bort rader
--
-- Detta skript motsvarar allt vi gjort i Products-övningen
-- i lektion 2, och kan köras om och om igen när du vill repetera.
-- =========================================================
