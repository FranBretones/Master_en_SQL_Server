# 🌟 SQL Operations - Database Insertions, Queries, and Stored Procedures 🌟

By Francisco José Bretones López

---

## 📜 Project Overview

This project demonstrates the use of SQL queries and stored procedures for managing a database of client, purchase, campaign, and lead capture information. It covers basic data manipulations such as inserting records, updating data, and querying information. It also includes the use of conditional logic and stored procedures to automate certain tasks in the database.

---

## 🗂️ Operations Overview

The following sections provide examples of SQL operations that were executed as part of the project, including data insertions, queries, and stored procedure creation.

---

### 1. Inserting a Record into `HoraCaptacion` Table

This operation inserts a new record into the `HoraCaptacion` table, which stores information about lead capture sessions. The following query inserts a new record with a date, status, and observation:

```sql
INSERT INTO HoraCaptacion (FechaCaptacion, EstadoCaptacion, Observaciones)
VALUES ('2024-01-01 10:00', 1, 'DESCONOCIDO')
```

### 2. Inserting a Record into `HoraCapClienteCampania` Table

After inserting a new record into the `HoraCaptacion` table, we retrieve the `idHCaptacion` (the identifier of the recently inserted record) and insert a new record into the `HoraCapClienteCampania` table, linking the `HoraCaptacion`, `Cliente`, and `Campania` tables:

```sql
DECLARE @idHCaptacion INT;
SET @idHCaptacion = SCOPE_IDENTITY();
```

-- Inserting a new record into the HoraCapClienteCampania table, linking HoraCaptacion, Cliente, and Campania.
```sql
INSERT INTO HoraCapClienteCampania (idHCaptacion, idCliente, idCampania)
VALUES (@idHCaptacion, 6, 1);
```

# 🧮 SQL Queries and Exercicies 

### 1. Show All Records from the Cliente Table

This query retrieves all records from the Cliente table:

```sql
SELECT * FROM Cliente;
```

### 2. Show Only Client Names

This query retrieves only the names of clients from the Cliente table:

```sql
SELECT Nombre FROM Cliente;
```

### 3. Show the First 3 Clients Ordered by Birthdate

This query retrieves the first 3 clients from the Cliente table, ordered by their birthdate in ascending order:
``` sql
SELECT TOP 3 * 
FROM Cliente
ORDER BY Fnacimiento ASC;
```

### 4. Show Distinct Country IDs (idPais) from the Cliente Table

This query returns a list of distinct country codes (idPais) from the Cliente table:

```sql
SELECT DISTINCT idPais 
FROM Cliente;
```

### 5. Update the Email of the First Client

This query updates the email of the first client in the Cliente table:
```sql
UPDATE Cliente
SET Email = '200@gmail.es'
WHERE IdCliente = (SELECT TOP 1 IdCliente FROM Cliente ORDER BY IdCliente);
```
### 6. Calculate the Average Purchase Amount

This query calculates the average purchase amount from the Compra table:
```sql
SELECT AVG(Monto) AS PromedioMonto
FROM Compra;
```
### 7. Filter Records by Date Range in HoraCaptacion

This query retrieves records from the HoraCaptacion table where the FechaCaptacion is between 2024-01-01 and 2024-01-30:

```sql
SELECT * 
FROM HoraCaptacion
WHERE FechaCaptacion BETWEEN '2024-01-01' AND '2024-01-30';
```
### 8. Conditional Logic with IF to Check Spanish Clients

This query checks if there are any Spanish clients (identified by idPais = 'ESP') in the Cliente table. If Spanish clients exist, their records are returned; otherwise, a message is printed:

```sql
DECLARE @ExistEsp INT;

SELECT @ExistEsp = COUNT(*) 
FROM Cliente
WHERE idPais = 'ESP';

IF @ExistEsp > 0
BEGIN
    SELECT * 
    FROM Cliente
    WHERE idPais = 'ESP';
END
ELSE
BEGIN
    PRINT 'No hay clientes con nacionalidad española.';
END
```
### 9. Determine Continent Based on Country (idPais)
This query determines the continent for each country based on its idPais:
``` sql
SELECT 
    NombrePais,
    CASE 
        WHEN idPais IN ('ESP', 'FRA', 'DEU') THEN 'Europa'
        WHEN idPais IN ('USA', 'CAN', 'MEX') THEN 'América del Norte'
        WHEN idPais IN ('BRA', 'ARG', 'COL') THEN 'América del Sur'
        WHEN idPais IN ('CHN', 'JPN', 'IND') THEN 'Asia'
        WHEN idPais IN ('AUS', 'NZL') THEN 'Oceanía'
        WHEN idPais IN ('EGY', 'ZAF', 'NGA') THEN 'África'
        ELSE 'Desconocido'
    END AS Continente
FROM Pais;
```

## 🧑‍💻 SQL Stored Procedure Code
#### Adding a new DNI field to the Cliente table
```sql
ALTER TABLE Cliente
ADD DNI VARCHAR(20) NULL;
```

#### Creating the stored procedure to insert new clients

```sql
CREATE PROCEDURE Nuevo_cliente
    @DNI VARCHAR(20),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Fnacimiento DATE,
    @Domicilio VARCHAR(50),
    @idPais CHAR(3),
    @Telefono VARCHAR(12),
    @Email VARCHAR(30),
    @Observaciones VARCHAR(1000)
AS
BEGIN
    -- Insert the new client into the Cliente table
    INSERT INTO Cliente (DNI, Nombre, Apellido, Fnacimiento, Domicilio, idPais, Telefono, Email, Observaciones, FechaAlta)
    VALUES (@DNI, @Nombre, @Apellido, @Fnacimiento, @Domicilio, @idPais, @Telefono, @Email, @Observaciones, GETDATE())
END
```

### ⚙️ How the Stored Procedure Works

Step 1: The procedure starts by altering the Cliente table to include a new field called DNI (National Identification Number).

Step 2: The procedure then creates a stored procedure named Nuevo_cliente. This procedure takes various parameters for the client's information, such as DNI, name, birthdate, address, country, phone number, email, and additional observations.

Step 3: The INSERT INTO statement is used to add a new client record into the Cliente table with the provided values. The current timestamp is automatically added using GETDATE() for the FechaAlta field.

### 🚀 Executing the Stored Procedure

Once the stored procedure has been created, it can be executed with the following command:

```sql
EXEC Nuevo_cliente '2351365', 'Raúl', 'Stuart', '1985-05-21', 'Las Regasta 25', 'ESP', '655821547', 'Raul@krokimail.com', '';
```
This will insert a new client into the Cliente table with the provided data.

### 🧠 Advantages of Using a Stored Procedure

Efficiency: Using a stored procedure allows repetitive tasks like inserting new clients to be done efficiently without having to write the same SQL code multiple times.

Security: Stored procedures provide an additional layer of security by controlling the access to sensitive data.

Maintainability: With stored procedures, code is centralized, making maintenance and updates easier.

Consistency: The procedure ensures that all client records are inserted consistently with the same logic and structure.

