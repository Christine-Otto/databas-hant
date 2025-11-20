
Lektion 5 – Index & Optimering

Denna lektion handlar om hur vi gör databasen snabbare och mer effektiv.
En fråga kan vara “logiskt rätt” men ändå långsam – här lär vi oss verktygen för att undvika det.

Syftet med lektion 5
            - Förstå vad ett index är och varför det behövs
            - Veta när man bör indexera och när man ska låta bli
            - Kunna skapa, visa och ta bort index i SQL
            - Förstå att databasen har en query optimizer (väljer “väg” för frågan)
            - Få en första känsla för prestandaoptimering: hur lösning och struktur påverkar fart

Struktur för lektion 5
Mappen Lektion5_Index_och_Functions innehåller:
            - lektion5_notes.md – denna anteckningsfil
            - index_exercise.sql – praktiska övningar med tabellen Orders, index och queries

Vad är ett index?
            Ett index kan jämföras med registret längst bak i en bok.

Utan index:
             måste bläddra igenom hela boken (hela tabellen) för att hitta ett ord.

Med index:
            Du går till registret, hittar sidan direkt → mycket snabbare.

I databaser:
            Index ligger “vid sidan av” tabellen
            Gör WHERE, JOIN och ibland ORDER BY mycket snabbare
            Men: varje index måste uppdateras när data ändras → kostar lite vid INSERT/UPDATE/DELETE

När ska man indexera?
Bra kandidater för index:
            Kolumner som ofta används i WHERE, t.ex. City, CustomerID
            Kolumner du ofta JOIN:ar på, t.ex. StudentID, CourseID
            Kolumner du ofta sorterar på (ORDER BY) när det är mycket data

Exempel (från index_exercise.sql):
            Orders.City – vi söker ofta på stad
            Orders.TotalAmount – vi filtrerar ofta på belopp

När ska man INTE indexera?
Undvik index på:
            Små tabeller (där hela tabellen ändå är snabb att läsa)
            Kolumner där nästan alla rader har samma värde (t.ex. en bool IsActive)
            Kolumner som uppdateras hela tiden – många index innebär mer jobb vid varje ändring

Tänk: lagom med index = snabb databas.
För många index = onödig overhead.

Grundläggande SQL för index
Skapa index
På en kolumn:
            CREATE INDEX idx_orders_city
            ON Orders (City);

På en annan kolumn (t.ex. belopp):
            CREATE INDEX idx_orders_totalamount
            ON Orders (TotalAmount);

Visa index på en tabell (MariaDB)
            SHOW INDEX FROM Orders;

Ta bort index
            DROP INDEX idx_orders_city ON Orders;
            DROP INDEX idx_orders_totalamount ON Orders;

I index_exercise.sql gör du allt detta steg för steg med kommentarer.

Query optimizer & EXPLAIN (översikt)
Databasen har en query optimizer som bestämmer hur frågan ska köras:
            - Ska den läsa hela tabellen?
            - Kan den använda ett index?
            - I vilken ordning ska tabeller joinas?

Med EXPLAIN kan du se planen:
            - EXPLAIN SELECT *
            - FROM Orders
            - WHERE City = 'Stockholm';

Du behöver i denna kurs mest förstå:
            - att en plan finns
            - att index underlättar för optimizern
            - att dåliga index / ingen index kan göra frågor långsamma

Kort om annan optimering (lite framåtblick)
I kursmaterialet nämns också mer avancerade områden:
            - Caching – spara resultat i minne (t.ex. Redis)
            - Partitionering – dela upp jättestora tabeller (t.ex. per år)
            - Sharding – sprida data över flera servrar
            - Replikering & load balancing – fler databasservrar för lastfördelning

I din kurs räcker det att:
            - känna igen orden
            - förstå att de hör till prestanda och skalning

Koppling till index_exercise.sql
I index_exercise.sql gör du i praktiken:
            - Skapar tabellen Orders
            - Lägger in exempeldata
            - Kör SELECT-frågor utan index
            - Skapar index på City och TotalAmount
            - Kör samma SELECT igen
            - Använder SHOW INDEX FROM Orders för att se index
            - Tränar CREATE INDEX och DROP INDEX
            - Läser igenom en liten “cheat sheet” i slutet av filen

Det är din hands-on-del av lektion 5.

Vad jag lärde mig i lektion 5
            - Vad ett index är och hur det fungerar
            - Hur index kan göra frågor mycket snabbare
            - När index är en bra idé – och när det inte behövs
            - Hur man skapar, listar och tar bort index i SQL
            - Att databasen har en optimizer och en frågeplan (EXPLAIN)
            - Att prestanda påverkas av både struktur (design) och index

Status: Lektion 5
            - lektion5_notes.md – klar
            - index_exercise.sql – innehåller övningar för index
            - Du har en första förståelse för prestandaoptimering
Nästa steg i kursen enligt översikten är Lektion 6: Transaktioner, administration och drift av databaser.