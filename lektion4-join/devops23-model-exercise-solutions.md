
````md
# DEVOPS23 – Normalisering (1NF, 2NF, 3NF)  
_Lösningar och förklaringar till devops23-model-exercise.md_

## 1NF – Första normalformen

> **Kom ihåg 1NF:**  
> - Varje kolumn ska innehålla **atomära värden** (inte listor).  
> - Inga "paketkolumner" (t.ex. adress + e-post i samma fält).  
> - Samma datatyp i hela kolumnen.  

---

### 1NF – Övningsuppgift 1: Patienter

**Givet:**

| PatientID | Namn            | Ålder | Telefonnummer                |
|----------|------------------|-------|------------------------------|
| 1        | Alice Andersson  | 30    | 123-456, 789-012             |
| 2        | Bob Bergh        | 42    | 555-234                      |
| 3        | Clara Carlsson   | 28    | 321-654, 987-321, 654-987    |

**Fråga:**  
Bryter denna tabell mot 1NF? Motivera ditt svar.

#### Svar

Ja, tabellen bryter mot 1NF.

#### Motivering

- Kolumnen **Telefonnummer** innehåller **flera värden i samma cell**, separerade med kommatecken.
- I 1NF ska varje cell innehålla **ett enda atomärt värde**.
- Det ska inte finnas listor eller upprepade värden i samma kolumn.

#### omstrukturering
> Mål: Separera patient och telefonnummer i två tabeller.

**Tabell 1: Patienter**

```text
Patienter(
    PatientID (PK),
    Namn,
    Ålder
)
````

Exempeldata:

| PatientID | Namn            | Ålder |
| --------- | --------------- | ----- |
| 1         | Alice Andersson | 30    |
| 2         | Bob Bergh       | 42    |
| 3         | Clara Carlsson  | 28    |

**Tabell 2: PatientTelefon**

```text
PatientTelefon(
    PatientID (FK → Patienter.PatientID),
    Telefonnummer
)
```

Exempeldata:

| PatientID | Telefonnummer |
| --------- | ------------- |
| 1         | 123-456       |
| 1         | 789-012       |
| 2         | 555-234       |
| 3         | 321-654       |
| 3         | 987-321       |
| 3         | 654-987       |

> Kommentar:
> En patient kan nu ha **0, 1 eller flera** telefonnummer, utan att bryta mot 1NF.

---

### 1NF – Övningsuppgift 2: Kurser

**Givet:**

| KursID | KursNamn       | StudentID | StudentNamn                |
| ------ | -------------- | --------- | -------------------------- |
| K101   | Matematik      | 1, 2      | Alice Andersson, Bob Bergh |
| K102   | Naturvetenskap | 2, 3      | Bob Bergh, Clara Carlsson  |

**Uppgift:**
Omstrukturera denna tabell så att den uppfyller 1NF.

#### Problem

* **StudentID** innehåller flera ID i samma cell.
* **StudentNamn** innehåller flera namn i samma cell.
* Det är en **många-till-många-relation** (många studenter kan gå många kurser).

#### Föreslagen normaliserad modell

> Mål: Dela upp i **Studenter**, **Kurser** och en kopplingstabell (**KursDeltagare**).

**Tabell 1: Studenter**

```text
Studenter(
    StudentID (PK),
    StudentNamn
)
```

Exempeldata:

| StudentID | StudentNamn     |
| --------- | --------------- |
| 1         | Alice Andersson |
| 2         | Bob Bergh       |
| 3         | Clara Carlsson  |

**Tabell 2: Kurser**

```text
Kurser(
    KursID (PK),
    KursNamn
)
```

Exempeldata:

| KursID | KursNamn       |
| ------ | -------------- |
| K101   | Matematik      |
| K102   | Naturvetenskap |

**Tabell 3: KursDeltagare (kopplingstabell)**

```text
KursDeltagare(
    KursID (FK → Kurser.KursID),
    StudentID (FK → Studenter.StudentID),
    PRIMARY KEY (KursID, StudentID)
)
```

Exempeldata:

| KursID | StudentID |
| ------ | --------- |
| K101   | 1         |
| K101   | 2         |
| K102   | 2         |
| K102   | 3         |

> Kommentar:
> Nu har vi **inga listor i kolumner**, alla värden är atomära → uppfyller 1NF.

---

### 1NF – Övningsuppgift 3: Anställda

**Givet:**

| AnställningsID | Namn       | Roll       | Färdigheter            |
| -------------- | ---------- | ---------- | ---------------------- |
| 101            | Anna Alm   | Utvecklare | Java, SQL              |
| 102            | Berit Bo   | Analytiker | Excel, SQL, Python     |
| 103            | Carl Ceder | Designer   | Photoshop, Illustrator |

**Fråga:**
Analysera tabellen och föreslå ändringar för att uppfylla 1NF.

#### Svar

Tabellen bryter mot 1NF.

#### Motivering

* Kolumnen **Färdigheter** innehåller **flera värden** per rad.
* Varje cell ska innehålla **ett värde**, inte en lista över färdigheter.

#### Föreslagen lösning

**Tabell 1: Anställda**

```text
Anställda(
    AnställningsID (PK),
    Namn,
    Roll
)
```

**Tabell 2: AnställdFärdighet**

```text
AnställdFärdighet(
    AnställningsID (FK → Anställda.AnställningsID),
    Färdighet,
    PRIMARY KEY (AnställningsID, Färdighet)
)
```

Exempeldata för **AnställdFärdighet**:

| AnställningsID | Färdighet   |
| -------------- | ----------- |
| 101            | Java        |
| 101            | SQL         |
| 102            | Excel       |
| 102            | SQL         |
| 102            | Python      |
| 103            | Photoshop   |
| 103            | Illustrator |

---

### 1NF – Övningsuppgift 4: Biblioteksböcker

**Givet:**

| BokID | Titel             | Genrer                  |
| ----- | ----------------- | ----------------------- |
| B101  | Solens Rike       | Fantasy, Äventyr        |
| B102  | Tidens Väktare    | Sci-Fi, Thriller, Drama |
| B103  | Nattens Drottning | Skräck, Fantasy         |

**Fråga:**
Identifiera och förklara hur denna tabell bryter mot 1NF.

#### Svar

Tabellen bryter mot 1NF.

#### Motivering

* Kolumnen **Genrer** innehåller flera genrer i samma cell.
* En bok kan tillhöra flera genrer → det är en många-till-många-relation.
* I 1NF får vi inte lagra flera värden i en cell.

#### Föreslagen lösning

**Tabell 1: Böcker**

```text
Böcker(
    BokID (PK),
    Titel
)
```

**Tabell 2: BokGenre**

```text
BokGenre(
    BokID (FK → Böcker.BokID),
    Genre,
    PRIMARY KEY (BokID, Genre)
)
```

---

### 1NF – Övningsuppgift 5: Kundbeställningar

**Givet:**

| BeställningsID | KundNamn        | Leveransdetaljer                                                         |
| -------------- | --------------- | ------------------------------------------------------------------------ |
| 501            | Alice Andersson | Storgatan 5, 12345 Staden, [alice@example.com](mailto:alice@example.com) |
| 502            | Bob Bergh       | [bob@example.com](mailto:bob@example.com), Lillgatan 2, 54321 Byen       |

**Fråga:**
Analysera problemen med `Leveransdetaljer`-kolumnen i termer av 1NF.

#### Svar

Det finns flera problem i förhållande till 1NF.

#### Motivering

* Kolumnen **Leveransdetaljer** innehåller **flera olika typer av information**:

  * Gata
  * Postnummer
  * Ort
  * E-post
* Ordningen är inte ens samma i bägge raderna (adress först / e-post först).
* I 1NF ska varje kolumn ha **en tydlig betydelse** och en **konsekvent datatyp**.

#### Föreslagen lösning

Dela upp kolumnen i flera:

```text
Kundbeställningar(
    BeställningsID (PK),
    KundNamn,
    Gata,
    Postnummer,
    Ort,
    Epost
)
```

Exempel:

| BeställningsID | KundNamn        | Gata        | Postnummer | Ort    | Epost                                         |
| -------------- | --------------- | ----------- | ---------- | ------ | --------------------------------------------- |
| 501            | Alice Andersson | Storgatan 5 | 12345      | Staden | [alice@example.com](mailto:alice@example.com) |
| 502            | Bob Bergh       | Lillgatan 2 | 54321      | Byen   | [bob@example.com](mailto:bob@example.com)     |

---

### 1NF – Övningsuppgift 6: AnställdInfo

**Givet:**

| AnställningsID | NamnochKontakt                                              |
| -------------- | ----------------------------------------------------------- |
| 001            | Anna Alm, [anna.alm@exempel.se](mailto:anna.alm@exempel.se) |
| 002            | Berit Bo, [berit.bo@exempel.se](mailto:berit.bo@exempel.se) |

**Fråga:**
Beskriv hur denna tabell bryter mot 1NF och föreslå en lösning.

#### Svar

Tabellen bryter mot 1NF.

#### Motivering

* Kolumnen **NamnochKontakt** innehåller egentligen **två attribut**:

  * Namn
  * E-postadress
* Varje kolumn ska representera **ett attribut**, inte flera ihopklistrade.

#### Föreslagen lösning

Dela upp i separata kolumner:

```text
AnställdInfo(
    AnställningsID (PK),
    Namn,
    Epost
)
```

---

### 1NF – Övningsuppgift 7: Produktlager

**Givet:**

| ProduktID | Pris     |
| --------- | -------- |
| P101      | 199,99   |
| P102      | 'Gratis' |
| P103      | 59,50    |

**Fråga:**
Diskutera problemet med `Pris`-kolumnen och hur det bryter mot 1NF.

#### Svar

Kolumnen bryter mot 1NF på grund av **inkonsekvent datatyp**.

#### Motivering

* Vissa värden är numeriska (199,99, 59,50), ett värde är text (`'Gratis'`).
* En kolumn ska ha **samma typ av värden** i alla rader.
* Blandning av tal och text skapar problem i beräkningar och jämförelser.

#### Föreslagen lösning

Variant 1 (tydligast):

```text
Produkter(
    ProduktID (PK),
    Pris,        -- numeriskt
    PrisTyp      -- t.ex. 'Normal', 'Gratis'
)
```

Exempel:

| ProduktID | Pris   | PrisTyp |
| --------- | ------ | ------- |
| P101      | 199.99 | Normal  |
| P102      | 0      | Gratis  |
| P103      | 59.50  | Normal  |

---

### 1NF – Övningsuppgift 8: Medlemsregister

**Givet:**

| MedlemsID | Namn            | Födelsedatum |
| --------- | --------------- | ------------ |
| 1001      | Alice Andersson | 1990-03-15   |
| 1002      | Bob Bergh       | 1985-07-22   |
| 1001      | Alice Andersson | 1990-03-15   |

**Fråga:**
Identifiera problemet i denna tabell och föreslå en lösning för att uppfylla 1NF.

#### Svar

Problemet är **duplicerad rad** med samma primärnyckel.

#### Motivering

* **MedlemsID** ska vara unikt om det är primärnyckel.
* Här förekommer MedlemsID = 1001 två gånger med identisk information.
* Det skapar inkonsekvent data och bryter mot principen om unika rader.

#### Föreslagen lösning

* Ta bort den duplicerade raden.
* Säkerställ att **MedlemsID** definieras som **PRIMARY KEY** i databasen så att dubletter inte kan införas.

---

## 2NF – Andra normalformen

> **Kom ihåg 2NF:**
>
> * Gäller bara tabeller där primärnyckeln är **sammansatt** (flera kolumner).
> * Inga **partiella beroenden**: ett icke-nyckelattribut får inte bero på bara en del av nyckeln.

---

### 2NF – Övningsuppgift 1: LärareKurser

**Givet:**

| LärarID | LärarNamn       | KursID | KursNamn      |
| ------- | --------------- | ------ | ------------- |
| L101    | Alice Andersson | K201   | Matematik     |
| L102    | Bob Bergh       | K202   | Fysik         |
| L101    | Alice Andersson | K203   | Programmering |

**Fråga:**
Bryter denna tabell mot 2NF? Motivera ditt svar.

#### Svar

Ja, tabellen bryter mot 2NF.

#### Motivering

* Naturlig primärnyckel: **(LärarID, KursID)** – en lärare kan undervisa flera kurser.
* Vi har beroenden:

  * LärarID → LärarNamn
  * KursID → KursNamn
* Icke-nyckelattributen **LärarNamn** och **KursNamn** beror bara på **delar** av den sammansatta nyckeln, inte på hela.

Detta är **partiella beroenden** → bryter mot 2NF.

#### Föreslagen omstrukturering

**Lärare**

```text
Lärare(
    LärarID (PK),
    LärarNamn
)
```

**Kurser**

```text
Kurser(
    KursID (PK),
    KursNamn
)
```

**LärareKurser** (kopplingstabell)

```text
LärareKurser(
    LärarID (FK → Lärare.LärarID),
    KursID (FK → Kurser.KursID),
    PRIMARY KEY (LärarID, KursID)
)
```

---

### 2NF – Övningsuppgift 2: AnställdProjekt

**Givet:**

| AnställningsID | Namn     | ProjektID | ProjektNamn    |
| -------------- | -------- | --------- | -------------- |
| A101           | Anna Alm | P501      | Webbutveckling |
| A102           | Berit Bo | P502      | Databasdesign  |

**Uppgift:**
Omstrukturera denna tabell så att den uppfyller 2NF.

#### Analys

* Tänkbar nyckel: **(AnställningsID, ProjektID)**.
* Beroenden:

  * AnställningsID → Namn
  * ProjektID → ProjektNamn
* Alltså partiella beroenden → bryter mot 2NF.

#### Föreslagen omstrukturering

**Anställda**

```text
Anställda(
    AnställningsID (PK),
    Namn
)
```

**Projekt**

```text
Projekt(
    ProjektID (PK),
    ProjektNamn
)
```

**AnställdProjekt**

```text
AnställdProjekt(
    AnställningsID (FK → Anställda.AnställningsID),
    ProjektID (FK → Projekt.ProjektID),
    PRIMARY KEY (AnställningsID, ProjektID)
)
```

---

### 2NF – Övningsuppgift 3: StudentKlasser

**Givet:**

| StudentID | StudentNamn    | KlassID | LärarID |
| --------- | -------------- | ------- | ------- |
| S101      | Clara Carlsson | K301    | L301    |
| S102      | David Dahl     | K302    | L302    |
| S103      | Emma Ek        | K301    | L301    |

**Fråga:**
Analysera tabellen och föreslå ändringar för att uppfylla 2NF.

#### Analys

* Tänkbar nyckel: **(StudentID, KlassID)**.
* Beroenden:

  * StudentID → StudentNamn
  * KlassID → LärarID (om varje klass har en lärare)
* **StudentNamn** beror bara på StudentID.
* **LärarID** beror bara på KlassID.

Detta är partiella beroenden → bryter mot 2NF.

#### Föreslagen omstrukturering

**Studenter**

```text
Studenter(
    StudentID (PK),
    StudentNamn
)
```

**Klasser**

```text
Klasser(
    KlassID (PK),
    LärarID
)
```

**StudentKlasser** (kopplingstabell)

```text
StudentKlasser(
    StudentID (FK → Studenter.StudentID),
    KlassID (FK → Klasser.KlassID),
    PRIMARY KEY (StudentID, KlassID)
)
```

---

### 2NF – Övningsuppgift 4: ProduktLager

**Givet:**

| ProduktID | ProduktNamn | LagerplatsID | LagerplatsAdress |
| --------- | ----------- | ------------ | ---------------- |
| P101      | Skruvmejsel | L401         | Lagergatan 5     |
| P102      | Hammare     | L402         | Lagergatan 6     |
| P103      | Såg         | L401         | Lagergatan 5     |

**Fråga:**
Identifiera eventuella partiella beroenden och förklara hur de bryter mot 2NF.

#### Analys

* Tänkbar nyckel: **(ProduktID, LagerplatsID)** (en produkt kan finnas på flera lagerplatser).
* Beroenden:

  * ProduktID → ProduktNamn
  * LagerplatsID → LagerplatsAdress
* Dessa är **partiella beroenden** från delar av nyckeln.

#### Föreslagen omstrukturering

**Produkter**

```text
Produkter(
    ProduktID (PK),
    ProduktNamn
)
```

**Lagerplatser**

```text
Lagerplatser(
    LagerplatsID (PK),
    LagerplatsAdress
)
```

**ProduktLager** (koppling)

```text
ProduktLager(
    ProduktID (FK → Produkter.ProduktID),
    LagerplatsID (FK → Lagerplatser.LagerplatsID),
    PRIMARY KEY (ProduktID, LagerplatsID)
)
```

---

### 2NF – Övningsuppgift 5: AnställdaTimmar

**Givet:**

| AnställningsID | Namn     | ProjektID | ArbetadeTimmar |
| -------------- | -------- | --------- | -------------- |
| A101           | Anna Alm | P501      | 35             |
| A102           | Berit Bo | P502      | 40             |

**Uppgift:**
Diskutera hur denna tabell kan bryta mot 2NF och föreslå en omstrukturering.

#### Analys

* Tänkbar nyckel: **(AnställningsID, ProjektID)**.
* Beroenden:

  * AnställningsID → Namn (namnet beror bara på anställd, inte projekt).
  * ArbetadeTimmar beror på både AnställningsID och ProjektID.
* Därmed är **Namn** partiellt beroende → bryter mot 2NF.

#### Föreslagen omstrukturering

**Anställda**

```text
Anställda(
    AnställningsID (PK),
    Namn
)
```

**Projekt**

```text
Projekt(
    ProjektID (PK)
)
```

**AnställdaTimmar**

```text
AnställdaTimmar(
    AnställningsID (FK → Anställda.AnställningsID),
    ProjektID (FK → Projekt.ProjektID),
    ArbetadeTimmar,
    PRIMARY KEY (AnställningsID, ProjektID)
)
```

---

### 2NF – Övningsuppgift 6: KursLärare

**Givet:**

| KursID | KursNamn  | LärarID | LärarNamn       |
| ------ | --------- | ------- | --------------- |
| K101   | Matematik | L301    | Alice Andersson |
| K102   | Engelska  | L302    | Bob Bergh       |

**Fråga:**
Analysera om det finns några funktionsberoenden mellan icke-nyckelattribut som bryter mot 2NF.

#### Analys

* Primärnyckel: **KursID** (en kurs har en lärare).
* Beroenden:

  * KursID → KursNamn
  * KursID → LärarID
  * LärarID → LärarNamn
* Nyckeln är **inte sammansatt**, alltså är tabellen formellt i 2NF (om 1NF uppfylls).

#### Kommentar

* Tabellens problem ligger istället i **3NF** (transitivt beroende via LärarID).

---

### 2NF – Övningsuppgift 7: KlassrumUtrustning

**Givet:**

| KlassrumID | KlassrumNamn | UtrustningsID | UtrustningsTyp |
| ---------- | ------------ | ------------- | -------------- |
| KR101      | A101         | U301          | Projektor      |
| KR102      | A102         | U302          | Whiteboard     |

**Uppgift:**
Identifiera och eliminera partiella beroenden i denna tabell för att uppnå 2NF.

#### Analys

* Tänkbar nyckel: **(KlassrumID, UtrustningsID)**.
* Beroenden:

  * KlassrumID → KlassrumNamn
  * UtrustningsID → UtrustningsTyp
* Båda är partiella beroenden.

#### Föreslagen omstrukturering

**Klassrum**

```text
Klassrum(
    KlassrumID (PK),
    KlassrumNamn
)
```

**Utrustning**

```text
Utrustning(
    UtrustningsID (PK),
    UtrustningsTyp
)
```

**KlassrumUtrustning**

```text
KlassrumUtrustning(
    KlassrumID (FK → Klassrum.KlassrumID),
    UtrustningsID (FK → Utrustning.UtrustningsID),
    PRIMARY KEY (KlassrumID, UtrustningsID)
)
```

---

## 3NF – Tredje normalformen

> **Kom ihåg 3NF:**
>
> * Tabell ska först vara i 2NF.
> * Inga **transitiva beroenden**: nyckel → A → B får inte förekomma för icke-nyckelattribut.

---

### 3NF – Övningsuppgift 1: AnställdAvdelning

**Givet:**

| AnställningsID | Namn     | AvdelningsID | AvdelningsNamn |
| -------------- | -------- | ------------ | -------------- |
| A101           | Anna Alm | D501         | Försäljning    |
| A102           | Berit Bo | D502         | Marknadsföring |

**Fråga:**
Bryter denna tabell mot 3NF? Motivera ditt svar.

#### Svar

Ja, tabellen bryter mot 3NF.

#### Motivering

* Nyckel: **AnställningsID**.
* Beroenden:

  * AnställningsID → Namn
  * AnställningsID → AvdelningsID
  * AvdelningsID → AvdelningsNamn
* AvdelningsNamn beror inte direkt på AnställningsID, utan via AvdelningsID.

Detta är ett **transitivt beroende**:
AnställningsID → AvdelningsID → AvdelningsNamn.

#### Föreslagen omstrukturering

**Anställda**

```text
Anställda(
    AnställningsID (PK),
    Namn,
    AvdelningsID (FK → Avdelningar.AvdelningsID)
)
```

**Avdelningar**

```text
Avdelningar(
    AvdelningsID (PK),
    AvdelningsNamn
)
```

---

### 3NF – Övningsuppgift 2: StudentKursLärare

**Givet:**

| StudentID | KursID | LärarID | LärarNamn       |
| --------- | ------ | ------- | --------------- |
| S101      | K301   | L401    | Alice Andersson |
| S102      | K302   | L402    | Berit Bo        |

**Uppgift:**
Omstrukturera denna tabell så att den uppfyller 3NF.

#### Analys

* Nyckel: **(StudentID, KursID)**.
* Beroenden:

  * (StudentID, KursID) → LärarID
  * LärarID → LärarNamn
* LärarNamn är transitivt beroende på (StudentID, KursID).

#### Föreslagen omstrukturering

**Studenter**

```text
Studenter(
    StudentID (PK)
    -- ev. StudentNamn etc.
)
```

**Lärare**

```text
Lärare(
    LärarID (PK),
    LärarNamn
)
```

**Kurser**

```text
Kurser(
    KursID (PK),
    LärarID (FK → Lärare.LärarID)
)
```

**StudentKurs**

```text
StudentKurs(
    StudentID (FK → Studenter.StudentID),
    KursID (FK → Kurser.KursID),
    PRIMARY KEY (StudentID, KursID)
)
```

---

### 3NF – Övningsuppgift 3: ProduktKategori

**Givet:**

| ProduktID | ProduktNamn | KategoriID | KategoriNamn |
| --------- | ----------- | ---------- | ------------ |
| P101      | Skruvmejsel | K301       | Verktyg      |
| P102      | Hammare     | K301       | Verktyg      |

**Fråga:**
Analysera tabellen och föreslå ändringar för att uppfylla 3NF.

#### Analys

* Nyckel: **ProduktID**.
* Beroenden:

  * ProduktID → ProduktNamn
  * ProduktID → KategoriID
  * KategoriID → KategoriNamn
* KategoriNamn beror transitivt på ProduktID via KategoriID.

#### Föreslagen omstrukturering

**Produkter**

```text
Produkter(
    ProduktID (PK),
    ProduktNamn,
    KategoriID (FK → Kategorier.KategoriID)
)
```

**Kategorier**

```text
Kategorier(
    KategoriID (PK),
    KategoriNamn
)
```

---

### 3NF – Övningsuppgift 4: KursLärare

**Givet:**

| KursID | KursNamn  | LärarID | LärarNamn       |
| ------ | --------- | ------- | --------------- |
| K101   | Matematik | L301    | Alice Andersson |
| K102   | Engelska  | L302    | Berit Bo        |

**Fråga:**
Identifiera eventuella transitiva beroenden som bryter mot 3NF.

#### Analys

* Nyckel: **KursID**.
* Beroenden:

  * KursID → KursNamn
  * KursID → LärarID
  * LärarID → LärarNamn
* Transitivitetskedja:

  * KursID → LärarID → LärarNamn

#### Föreslagen omstrukturering

**Kurser**

```text
Kurser(
    KursID (PK),
    KursNamn,
    LärarID (FK → Lärare.LärarID)
)
```

**Lärare**

```text
Lärare(
    LärarID (PK),
    LärarNamn
)
```

---

### 3NF – Övningsuppgift 5: AnställdProjekt

**Givet:**

| AnställningsID | Namn     | ProjektID | ProjektNamn    |
| -------------- | -------- | --------- | -------------- |
| A101           | Anna Alm | P501      | Webbutveckling |
| A102           | Berit Bo | P502      | Databasdesign  |

**Uppgift:**
Diskutera hur denna tabell kan bryta mot 3NF och föreslå en omstrukturering.

#### Analys

* Nyckel: **(AnställningsID, ProjektID)**.
* Beroenden:

  * AnställningsID → Namn
  * ProjektID → ProjektNamn
* Tabellen bryter redan mot **2NF** (partiella beroenden).
* Därmed uppfylls inte heller 3NF.

#### Föreslagen omstrukturering

Samma som i 2NF:

**Anställda**

```text
Anställda(
    AnställningsID (PK),
    Namn
)
```

**Projekt**

```text
Projekt(
    ProjektID (PK),
    ProjektNamn
)
```

**AnställdProjekt**

```text
AnställdProjekt(
    AnställningsID (FK → Anställda.AnställningsID),
    ProjektID (FK → Projekt.ProjektID),
    PRIMARY KEY (AnställningsID, ProjektID)
)
```

---

### 3NF – Övningsuppgift 6: KlassrumUtrustning

**Givet:**

| KlassrumID | KlassrumNamn | UtrustningsID | UtrustningsTyp |
| ---------- | ------------ | ------------- | -------------- |
| KR101      | A101         | U301          | Projektor      |
| KR102      | A102         | U302          | Whiteboard     |

**Fråga:**
Identifiera och eliminera transitiva beroenden för att uppnå 3NF.

#### Analys

* Nyckel: **(KlassrumID, UtrustningsID)**.
* Beroenden:

  * KlassrumID → KlassrumNamn
  * UtrustningsID → UtrustningsTyp
* Detta är dels partiella beroenden (2NF-problem), men också transitiva i förhållande till hela nyckeln.

#### Föreslagen omstrukturering

Samma struktur som tidigare:

**Klassrum**

```text
Klassrum(
    KlassrumID (PK),
    KlassrumNamn
)
```

**Utrustning**

```text
Utrustning(
    UtrustningsID (PK),
    UtrustningsTyp
)
```

**KlassrumUtrustning**

```text
KlassrumUtrustning(
    KlassrumID (FK → Klassrum.KlassrumID),
    UtrustningsID (FK → Utrustning.UtrustningsID),
    PRIMARY KEY (KlassrumID, UtrustningsID)
)
```

---

### 3NF – Övningsuppgift 7: LärarÄmnen

**Givet:**

| LärarID | LärarNamn       | ÄmnesID | ÄmnesNamn |
| ------- | --------------- | ------- | --------- |
| L401    | Alice Andersson | A101    | Matematik |
| L402    | Berit Bo        | A102    | Engelska  |

**Fråga:**
Kontrollera om `ÄmnesNamn` är direkt beroende av `LärarID` och om tabellen uppfyller 3NF.

#### Analys

* Tänkbar nyckel: **(LärarID, ÄmnesID)**.
* Beroenden:

  * LärarID → LärarNamn
  * ÄmnesID → ÄmnesNamn
* `ÄmnesNamn` beror inte direkt på hela nyckeln, utan bara på ÄmnesID.
* `LärarNamn` beror bara på LärarID.

Det innebär partiella beroenden → tabellen uppfyller inte 2NF eller 3NF.

#### Föreslagen omstrukturering

**Lärare**

```text
Lärare(
    LärarID (PK),
    LärarNamn
)
```

**Ämnen**

```text
Ämnen(
    ÄmnesID (PK),
    ÄmnesNamn
)
```

**LärarÄmnen**

```text
LärarÄmnen(
    LärarID (FK → Lärare.LärarID),
    ÄmnesID (FK → Ämnen.ÄmnesID),
    PRIMARY KEY (LärarID, ÄmnesID)
)
```

---

### 3NF – Övningsuppgift 8: StudentFöreningar

**Givet:**

| StudentID | Namn            | FöreningID | FöreningNamn  |
| --------- | --------------- | ---------- | ------------- |
| S101      | Alice Andersson | F301       | Schackklubben |
| S102      | Bob Bergh       | F302       | Teatergruppen |

**Fråga:**
Analysera om `FöreningNamn` är direkt beroende av `StudentID` och om tabellen uppfyller 3NF.

#### Analys

* Nyckel: **(StudentID, FöreningID)**.
* Beroenden:

  * StudentID → Namn
  * FöreningID → FöreningNamn
* `FöreningNamn` beror inte på StudentID utan på FöreningID.
* `Namn` beror inte på FöreningID utan på StudentID.

Det finns partiella beroenden → inte 2NF → inte 3NF.

#### Föreslagen omstrukturering

**Studenter**

```text
Studenter(
    StudentID (PK),
    Namn
)
```

**Föreningar**

```text
Föreningar(
    FöreningID (PK),
    FöreningNamn
)
```

**StudentFöreningar**

```text
StudentFöreningar(
    StudentID (FK → Studenter.StudentID),
    FöreningID (FK → Föreningar.FöreningID),
    PRIMARY KEY (StudentID, FöreningID)
)
```
