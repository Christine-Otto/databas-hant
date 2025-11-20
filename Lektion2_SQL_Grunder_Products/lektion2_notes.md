Lektion 2 – SQL-grunder (Products)

Denna lektion handlar om att förstå och öva på SQL:s grundläggande frågor:
SELECT, WHERE, ORDER BY, LIMIT, COUNT, BETWEEN, IN och enklare UPDATE.
Här använde vi tabellen Products som träningsmaterial.

Syftet med lektion 2:
            - Kunna hämta data från en tabell
            - Filtrera resultat baserat på villkor
            - Sortera data
            - Begränsa antal rader
            - Uppdatera data
            - Radera data
            - Förstå skillnaden mellan olika SELECT-varianter
            - Lära sig SQL:s mest grundläggande kommandon

Struktur för lektion 2
            Mappen innehåller:
                - lektion2_notes.md
                - products_exercise.sql

SQL-filen innehåller alla övningar från lektion 2 och allt vi arbetade igenom i Products-tabellen.

Grundläggande SQL-kommandon från lektion 2
        SELECT – hämta data
            - SELECT * FROM Products;
            - SELECT ProductName, Price FROM Products;

        WHERE – filtrera
            - SELECT * FROM Products WHERE Price > 10;

        ORDER BY – sortera
            - SELECT * FROM Products ORDER BY Price ASC;
            - SELECT * FROM Products ORDER BY Price DESC;

        LIMIT – begränsa antal resultat
            - SELECT * FROM Products LIMIT 5;
        
        COUNT – räkna rader
            - SELECT COUNT(*) FROM Products;
  
        BETWEEN – intervall
            - SELECT * FROM Products WHERE Price BETWEEN 5 AND 15;

        IN – flera val i samma kolumn
            - SELECT * FROM Products WHERE Category IN ('Food', 'Drink');

        AND / OR – flera villkor
            - SELECT * FROM Products WHERE Price > 10 AND Category = 'Food';
            - SELECT * FROM Products WHERE Category = 'Food' OR Category = 'Drink';

DML – Uppdatera och ta bort data
        UPDATE
            UPDATE Products
            SET Price = 20
            WHERE ProductID = 1;

        DELETE
            DELETE FROM Products
            WHERE ProductID = 3;

Skapa tabellen (från Products-exemplet)
            CREATE TABLE Products (
            ProductID INT PRIMARY KEY,
            ProductName VARCHAR(255),
            Price DECIMAL(10,2),
            Category VARCHAR(100)
            );

Vad jag lärde mig i lektion 2
            - Hur SELECT fungerar
            - Hur man filtrerar resultat (WHERE)
            - Hur man sorterar data (ORDER BY)
            - Hur man räknar rader (COUNT)
            - Hur man arbetar med flera logiska villkor
            - Hur man uppdaterar och tar bort rader
            - Hur man skapar och fyller en enkel tabell
            - Hur SQLTools kör kommandon i VS Code
            - Var i projektet SQL-filer ska ligga

Status: Lektion 2 KLAR
            - Grunderna i SQL fungerar
            - Products-övningarna är gjorda
            - SQLTools fungerar som det ska
            - Lektion 3 (Movies och Views)