-- Create a Database
-- This creates a new database named FranciscoBretones. 
-- The database will be used to store all the subsequent tables and data.

CREATE DATABASE FranciscoBretones;

USE FranciscoBretones; -- Sets the context to the newly created database.


--  Create the Cliente Table
-- This table stores customer information such as name, address, phone, email, and registration date.

CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Fnacimiento DATE NOT NULL,
    Domicilio VARCHAR(50) NOT NULL,
    idPais CHAR(3) NOT NULL,
    Telefono VARCHAR(12) NULL,
    Email VARCHAR(30) NOT NULL,
    Observaciones VARCHAR(1000) NULL,
    FechaAlta DATETIME NOT NULL,
    FOREIGN KEY (idPais) REFERENCES Pais(IdPais) -- Relationship with Pais
);


-- Create the Record Table
-- This table stores records with an auto-incremented ID, a date, and optional observations.

CREATE TABLE Record (
    IdRecord INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FechaRecord DATE NOT NULL,
    Observaciones VARCHAR(1000) NULL
);


-- Create the RecordCliente Table
-- This table links records to customers and campaigns using a composite primary key.

CREATE TABLE RecordCliente (
    IdRecord INT NOT NULL,
    IdCliente INT NOT NULL,
    IdCampania INT NOT NULL,
    PRIMARY KEY (IdRecord, IdCliente, IdCampania),
    FOREIGN KEY (IdRecord) REFERENCES Record(IdRecord), -- Relationship with Record
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente), -- Relationship with Cliente
    FOREIGN KEY (IdCampania) REFERENCES Campania(IdCampania) -- Relationship with Campania
);


-- Create the Pais Table
-- This table lists countries with a 3-character code and name.

CREATE TABLE Pais (
    IdPais CHAR(3) NOT NULL PRIMARY KEY,
    NombrePais VARCHAR(100) NOT NULL
);


-- Create the HoraCaptacion Table
-- This table stores data about lead capture times including dates, status, and observations.

CREATE TABLE HoraCaptacion(
    idHCaptacion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    fechaCaptacion DATE NOT NULL,
    estadoCaptacion SMALLINT NOT NULL,
    Observaciones VARCHAR(100) NOT NULL,
    FOREIGN KEY (estadoCaptacion) REFERENCES HorarioEstado(idEstado) -- Relationship with HorarioEstado
);


-- Create the HoraCapClienteCampania Table
-- This table links lead capture times to clients and campaigns using a composite primary key.

CREATE TABLE HoraCapClienteCampania (
    idHCaptacion INT NOT NULL,
    idCliente INT NOT NULL,
    idCampania INT NOT NULL,
    PRIMARY KEY (idHCaptacion, idCliente, idCampania),
    FOREIGN KEY (idHCaptacion) REFERENCES HoraCaptacion(idHCaptacion), -- Relationship with HoraCaptacion
    FOREIGN KEY (idCliente) REFERENCES Cliente(IdCliente), -- Relationship with Cliente
    FOREIGN KEY (idCampania) REFERENCES Campania(IdCampania) -- Relationship with Campania
);


-- Create the HorarioEstado Table
-- This table stores different statuses with a description.

CREATE TABLE HorarioEstado (
    idEstado SMALLINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);


-- Create the Producto Table
-- This table stores product information including a unique ID and product name.

CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Producto VARCHAR(100) NOT NULL
);


-- Create the Compra Table
-- This table stores purchase information including concepts, dates, amounts, and observations.

CREATE TABLE Compra (
    IdCompras INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Concepto INT NOT NULL,
    Fecha DATETIME NOT NULL,
    Monto MONEY NOT NULL,
    Observaciones VARCHAR(1000) NULL,
    FOREIGN KEY (Concepto) REFERENCES ConceptoCompra(IdConcepto) -- Relationship with ConceptoCompra
);


-- Create the CompraCliente Table
-- This table links purchases to customers and lead capture times using a composite primary key.

CREATE TABLE CompraCliente (
    IdCompras INT NOT NULL,
    IdCliente INT NOT NULL,
    idHCaptacion INT NOT NULL,
    PRIMARY KEY (IdCompras, IdCliente, idHCaptacion),
    FOREIGN KEY (IdCompras) REFERENCES Compra(IdCompras), -- Relationship with Compra
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente), -- Relationship with Cliente
    FOREIGN KEY (idHCaptacion) REFERENCES HoraCaptacion(idHCaptacion) -- Relationship with HoraCaptacion
);


-- Create the Campania Table
-- This table stores campaign information with a unique ID and campaign name.

CREATE TABLE Campania (
    IdCampania INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NombreCampaña VARCHAR(50) NOT NULL
);


-- Create the CampaniaProducto Table
-- This table links campaigns to products using a composite primary key.

CREATE TABLE CampaniaProducto (
    IdCampania INT NOT NULL,
    IdProducto INT NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    PRIMARY KEY (IdCampania, IdProducto),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto), -- Relationship with Producto
    FOREIGN KEY (IdCampania) REFERENCES Campania(IdCampania) -- Relationship with Campania
);


-- Create the ConceptoCompra Table
-- This table stores purchase concepts with a unique ID and description.

CREATE TABLE ConceptoCompra (
    IdConcepto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Concepto VARCHAR(100) NOT NULL
);
