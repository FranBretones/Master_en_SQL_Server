# 🌟 FranciscoBretones Database 🌟

By Francisco José Bretones López

--- 

## 📜 Scope

- This project focuses on creating a database for managing customer, product, purchase, and campaign data.
- It allows the organization of customers, campaigns, and products, and stores detailed transaction and record information.

---

## 🗂️ Schema and Entities

### 👤 Cliente Table

- `IdCliente`: Integer. Unique identifier for each client. (Primary key)
- `Nombre`: String. Client's first name.
- `Apellido`: String. Client's last name.
- `Fnacimiento`: Date. Date of birth of the client.
- `Domicilio`: String. Client's address.
- `idPais`: Char(3). Country code referencing the Pais table.
- `Telefono`: String. Client's phone number.
- `Email`: String. Client's email address.
- `Observaciones`: Text. Additional notes about the client.
- `FechaAlta`: Datetime. Date when the client was registered.

### 💡 Record Table

- `IdRecord`: Integer. Unique identifier for each record. (Primary key)
- `FechaRecord`: Date. Date of the record.
- `Observaciones`: Text. Additional notes related to the record.

### 👥 RecordCliente Table

- `IdRecord`: Integer. References Record.
- `IdCliente`: Integer. References Cliente.
- `IdCampania`: Integer. References Campania.
  
- **Foreign Keys**:
  - `IdRecord` references `Record(IdRecord)`.
  - `IdCliente` references `Cliente(IdCliente)`.
  - `IdCampania` references `Campania(IdCampania)`.

### 🌍 Pais Table

- `IdPais`: Char(3). Unique country code. (Primary key)
- `NombrePais`: String. Name of the country.

### 🕒 HoraCaptacion Table

- `idHCaptacion`: Integer. Unique identifier for each lead capture session. (Primary key)
- `fechaCaptacion`: Date. Date of the lead capture.
- `estadoCaptacion`: Smallint. Status of the capture session.
- `Observaciones`: String. Additional observations about the capture.

### 🛒 Compra Table

- `IdCompras`: Integer. Unique identifier for each purchase. (Primary key)
- `Concepto`: Integer. Purchase concept, references ConceptoCompra table.
- `Fecha`: Datetime. Date of the purchase.
- `Monto`: Money. Amount of the purchase.
- `Observaciones`: Text. Additional purchase notes.

### 🛍️ CompraCliente Table

- `IdCompras`: Integer. References Compra.
- `IdCliente`: Integer. References Cliente.
- `idHCaptacion`: Integer. References HoraCaptacion.
  
- **Foreign Keys**:
  - `IdCompras` references `Compra(IdCompras)`.
  - `IdCliente` references `Cliente(IdCliente)`.
  - `idHCaptacion` references `HoraCaptacion(idHCaptacion)`.

### 📦 Campania Table

- `IdCampania`: Integer. Unique identifier for each campaign. (Primary key)
- `NombreCampaña`: String. Name of the campaign.

### 📦 CampaniaProducto Table

- `IdCampania`: Integer. References Campania.
- `IdProducto`: Integer. References Producto.
- `Descripcion`: String. Description of the product in the campaign.

### 🏷️ ConceptoCompra Table

- `IdConcepto`: Integer. Unique identifier for each concept. (Primary key)
- `Concepto`: String. Description of the concept.

---

## 🗺️ Relationships

Below is a diagram describing the relationships between the tables:

1. **Cliente ↔ Pais**: `idPais` references `Pais(IdPais)`
2. **Compra ↔ ConceptoCompra**: `Concepto` references `ConceptoCompra(IdConcepto)`
3. **HoraCaptacion ↔ HorarioEstado**: `estadoCaptacion` references `HorarioEstado(idEstado)`
4. **Compra ↔ CompraCliente**: `IdCompras` references `Compra(IdCompras)`
5. **Cliente ↔ CompraCliente**: `IdCliente` references `Cliente(IdCliente)`
6. **HoraCapClienteCampania ↔ HoraCaptacion**: `idHCaptacion` references `HoraCaptacion(idHCaptacion)`
7. **HoraCapClienteCampania ↔ Cliente**: `idCliente` references `Cliente(IdCliente)`
8. **HoraCapClienteCampania ↔ Campania**: `idCampania` references `Campania(IdCampania)`
9. **CampaniaProducto ↔ Producto**: `IdProducto` references `Producto(IdProducto)`
10. **CampaniaProducto ↔ Campania**: `IdCampania` references `Campania(IdCampania)`
11. **Record ↔ RecordCliente**: `IdRecord` references `Record(IdRecord)`
12. **RecordCliente ↔ Cliente**: `IdCliente` references `Cliente(IdCliente)`
13. **RecordCliente ↔ Campania**: `IdCampania` references `Campania(IdCampania)`

---

## 🚀 Optimizations

### 📈 Indexes

To improve performance of searches:

```sql
CREATE INDEX user_groups_user_id_index ON Cliente("IdCliente");
CREATE INDEX user_groups_group_id_index ON Campania("IdCampania");
