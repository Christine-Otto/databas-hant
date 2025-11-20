Lektion 7 – NoSQL & Andra Databassystem

Denna lektion handlar om databaser som **inte** är klassiska relationsdatabaser (som MariaDB).
Fokuset ligger på att förstå *varför* NoSQL finns, vilka typer som finns och när man väljer vad.

Syftet med lektion 7
            - Förstå vad **NoSQL** betyder
            - Känna till olika typer av NoSQL-databaser
            - Kunna jämföra relationsdatabaser (SQL) med NoSQL
            - Få exempel på verkliga system som använder NoSQL
            - Förstå att olika problem kräver olika databaslösningar

Vad betyder “NoSQL”?
            “NoSQL” betyder inte “ingen SQL någonsin”, utan mer:

Not Only SQL
            Det vill säga: andra sätt att lagra data än tabeller med rader och kolumner.

NoSQL-system är ofta:
            - skalbara (kan hantera enorma datamängder)
            - snabba för vissa typer av operationer
            - flexibla i hur data lagras (t.ex. JSON-dokument)

Typer av NoSQL-databaser
Det finns fyra vanliga kategorier:
    Nyckel–värde (Key-Value Stores)
            - Data sparas som: `nyckel → värde`
            - Exempel: Redis, Amazon DynamoDB
            - Snabba uppslag, ofta används för cache eller sessionsdata.

    Dokumentdatabaser
            - Data sparas som dokument (t.ex. JSON).
            - Varje rad kan ha olika fält.
            - Exempel: MongoDB, CouchDB
            - Bra när strukturen på data kan variera.

    Kolumn-orienterade databaser
            - Lagrar data per kolumn istället för per rad.
            - Effektivt med stora datamängder och rapportering.
            - Exempel: Apache Cassandra, HBase.

    Grafsdatabaser
            - Fokuserar på relationer och kopplingar mellan noder.
            - Exempel: Neo4j
            - Används ofta för sociala nätverk, rekommendationssystem, nätverksanalys.

SQL vs NoSQL – jämförelse
    Relationsdatabaser (SQL, t.ex. MariaDB)
            - Tabeller, rader, kolumner
            - Stark struktur (schema)
            - Relationsmodellen (keys, foreign keys, joins)
    Bra för:
            - transaktioner (bank, ekonomi, bokning)
            - tydliga regler och relationer

NoSQL
            - Flexiblare struktur
            - Ofta ingen eller få joins
            - Kan vara schema-löst (t.ex. dokumentdatabaser)

    Bra för:
            - stora datamängder
            - loggar, händelsedata
            - snabba uppslag
            - data som ofta förändrar form

Exempel: Dokument i en dokumentdatabas (t.ex. MongoDB)
Ungefär så här kan en “rad” (dokument) se ut:

            {
            "MovieID": 1,
            "Title": "Inception",
            "Year": 2010,
            "Genre": ["Sci-Fi", "Action"],
            "Rating": 8.8,
            "Director": {
            "FirstName": "Christopher",
            "LastName": "Nolan"
            }
            }

Här får vi:
            - listor (Genre)
            - inbäddade objekt (Director)
            - inga fasta kolumner som i en SQL-tabell

När väljer man SQL vs NoSQL?
    Välj SQL när:
            - du har tydliga relationer
            - du behöver transaktioner (ACID)
            - data är strukturerad och relativt stabil
            - du vill ha stark dataintegritet

    Välj NoSQL när:
            - du har enorma datamängder
            - du behöver hög hastighet och skalbarhet
            - strukturen förändras ofta
            - du inte behöver komplexa JOINs
            - du lagrar loggar, events, sensordata eller dokument

Förslag på miniövningar (teoretiska)
    Ta din Movies-tabell och fundera:
            Hur skulle samma data se ut i en dokumentdatabas (JSON)?

    Fundera på en app (t.ex. Instagram, Spotify, Netflix):
            - Vilken data skulle passa i SQL?
            - Vilken data skulle passa bättre i NoSQL?

    Titta på dina JOIN-övningar:
            Finns det scenarion där en grafdatabas skulle vara bättre?

Vad jag lärde mig i lektion 7
            - Att SQL inte är “enda vägen” – det finns många databasmodeller
            - Vad NoSQL är och vilka huvudtyper som finns
            - När man ska välja relationsdatabas vs NoSQL
            - Hur moderna system ofta kombinerar flera databastyper samtidigt
            (t.ex. SQL för transaktioner + NoSQL för loggar/cache)

Status: Lektion 7
Du har nu:
            - Anteckningar om NoSQL och andra databassystem
            - Förståelse för när och varför man använder NoSQL
            - En bra teoretisk grund inför mer avancerade systemdesign-frågor

Du är därmed igenom **alla lektions-block 1–7** strukturerat.
