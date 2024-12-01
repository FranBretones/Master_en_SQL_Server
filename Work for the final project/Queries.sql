-- Inserting a Record into HoraCaptacion Table
-- Inserting a new record into the HoraCaptacion table with a date, status, and observation.

INSERT INTO HoraCaptacion (FechaCaptacion, EstadoCaptacion, Observaciones)
VALUES ('2024-01-01 10:00', 1, 'DESCONOCIDO');


-- Inserting a Record into HoraCapClienteCampania Table
-- Declaring and setting the id of the recently inserted HoraCaptacion.

DECLARE @idHCaptacion INT;
SET @idHCaptacion = SCOPE_IDENTITY();

-- Inserting a new record into the HoraCapClienteCampania table, linking HoraCaptacion, Cliente, and Campania.

INSERT INTO HoraCapClienteCampania (idHCaptacion, idCliente, idCampania)
VALUES (@idHCaptacion, 6, 1);


-- SQL Queries and Stored Procedure Examples

-- 1. Query to show all records from the Cliente table.
SELECT * FROM Cliente;

-- 2. Query to show only the names of the clients.
SELECT Nombre FROM Cliente;

-- 3. Query to show the first 3 records from the Cliente table, ordered by birthdate in ascending order.

SELECT TOP 3 * 
FROM Cliente
ORDER BY Fnacimiento ASC;

-- 4. Query to show distinct country IDs (idPais) from the Cliente table.

SELECT DISTINCT idPais 
FROM Cliente;

-- 5. Query to update the email of the first client in the Cliente table.

UPDATE Cliente
SET Email = '200@gmail.es'
WHERE IdCliente = (SELECT TOP 1 IdCliente FROM Cliente ORDER BY IdCliente);

-- 6. Query to calculate the average amount (Monto) from the Compra table.

SELECT AVG(Monto) AS PromedioMonto
FROM Compra;

-- 7. Query to show records from HoraCaptacion filtered by dates between '2024-01-01' and '2024-01-30'.

SELECT * 
FROM HoraCaptacion
WHERE FechaCaptacion BETWEEN '2024-01-01' AND '2024-01-30';

-- 8. IF statement to check and return records of Spanish clients (idPais = 'ESP') from the Cliente table.

DECLARE @ExistEsp INT;

-- Checking if there are clients from Spain
SELECT @ExistEsp = COUNT(*) 
FROM Cliente
WHERE idPais = 'ESP';

-- If there are Spanish clients, return the records; otherwise, print a message.

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

-- 9. CASE statement to determine the continent of each country based on idPais.

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

-- 10. Stored Procedure to insert new clients into the Cliente table, including DNI (ID number).
-- First, adding a DNI field to the Cliente table.

ALTER TABLE Cliente
ADD DNI VARCHAR(20) NULL;

-- Creating the stored procedure to insert new clients.

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
    INSERT INTO Cliente (DNI, Nombre, Apellido, Fnacimiento, Domicilio, idPais, Telefono, Email, Observaciones, FechaAlta)
    VALUES (@DNI, @Nombre, @Apellido, @Fnacimiento, @Domicilio, @idPais, @Telefono, @Email, @Observaciones, GETDATE());
END

-- Executing the stored procedure with the provided client data.

EXEC Nuevo_cliente '2351365', 'Raúl', 'Stuart', '1985-05-21', 'Las regasta 25', 'ESP', '655821547', 'Raul@krokimail.com', '';
"""
