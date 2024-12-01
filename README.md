# 🌟 FranciscoBretones Database 🌟

By Francisco José Bretones López

This database is designed to manage customer, product, purchase, and campaign data. It allows an efficient organization of customer records, product information, transactions, and related campaigns, supporting a robust system for managing these entities.
--- 

## 📜 Scope

- This project focuses on creating a relational database to manage customer, product, purchase, and campaign data in an integrated system.
- The **Cliente** table holds client details and connects with purchases and campaigns.
- The **Compra** table stores purchase details, which are linked to customers and campaigns via the **CompraCliente** table.
- The **Campania** table stores campaign data, which is associated with products and customers, ensuring efficient campaign management.
- Additional features include lead capture via the **HoraCaptacion** table and comprehensive record-keeping using the **Record** and **RecordCliente** tables.
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

- **Foreign Keys**:
  - `idPais` references `Pais(IdPais)`.

---

### 💡 Record Table

- `IdRecord`: Integer. Unique identifier for each record. (Primary key)
- `FechaRecord`: Date. Date of the record.
- `Observaciones`: Text. Additional notes related to the record.

- **Foreign Keys**:
  - None.

---

### 👥 RecordCliente Table

- `IdRecord`: Integer. References Record.
- `IdCliente`: Integer. References Cliente.
- `IdCampania`: Integer. References Campania.

- **Foreign Keys**:
  - `IdRecord` references `Record(IdRecord)`.
  - `IdCliente` references `Cliente(IdCliente)`.
  - `IdCampania` references `Campania(IdCampania)`.

---

### 🌍 Pais Table

- `IdPais`: Char(3). Unique country code. (Primary key)
- `NombrePais`: String. Name of the country.

- **Foreign Keys**:
  - None.

---

### 🕒 HoraCaptacion Table

- `idHCaptacion`: Integer. Unique identifier for each lead capture session. (Primary key)
- `fechaCaptacion`: Date. Date of the lead capture.
- `estadoCaptacion`: Smallint. Status of the capture session.
- `Observaciones`: String. Additional observations about the capture.

- **Foreign Keys**:
  - `estadoCaptacion` references `HorarioEstado(idEstado)`.

---

### 🛒 Compra Table

- `IdCompras`: Integer. Unique identifier for each purchase. (Primary key)
- `Concepto`: Integer. Purchase concept, references ConceptoCompra table.
- `Fecha`: Datetime. Date of the purchase.
- `Monto`: Money. Amount of the purchase.
- `Observaciones`: Text. Additional purchase notes.

- **Foreign Keys**:
  - `Concepto` references `ConceptoCompra(IdConcepto)`.

---

### 🛍️ CompraCliente Table

- `IdCompras`: Integer. References Compra.
- `IdCliente`: Integer. References Cliente.
- `idHCaptacion`: Integer. References HoraCaptacion.

- **Foreign Keys**:
  - `IdCompras` references `Compra(IdCompras)`.
  - `IdCliente` references `Cliente(IdCliente)`.
  - `idHCaptacion` references `HoraCaptacion(idHCaptacion)`.

---

### 📦 Campania Table

- `IdCampania`: Integer. Unique identifier for each campaign. (Primary key)
- `NombreCampaña`: String. Name of the campaign.

- **Foreign Keys**:
  - None.

---

### 📦 CampaniaProducto Table

- `IdCampania`: Integer. References Campania.
- `IdProducto`: Integer. References Producto.
- `Descripcion`: String. Description of the product in the campaign.

- **Foreign Keys**:
  - `IdCampania` references `Campania(IdCampania)`.
  - `IdProducto` references `Producto(IdProducto)`.

---

### 🏷️ ConceptoCompra Table

- `IdConcepto`: Integer. Unique identifier for each concept. (Primary key)
- `Concepto`: String. Description of the concept.

- **Foreign Keys**:
  - None.

---

## 🗺️ Relationships

🗺️ **Relationships**
-----------------

This database is structured to maintain data integrity, minimize redundancy, and ensure seamless interactions between different entities. It follows a **normalized relational model**, meaning that the database is split into distinct tables that are connected through **foreign key relationships**. Below is a detailed breakdown of the key relationships between tables:

### 1. **Cliente ↔ Compra (Cliente and Compra Relationship)**

- **Nature of Relationship**: One-to-many.
    
- **Description**: Each client (**Cliente**) can make multiple purchases (**Compra**), and these transactions are tracked in the **CompraCliente** table. This relationship allows the database to store detailed purchase records for each customer.
    
    - **How It Works**: The **CompraCliente** table acts as a **junction table** linking the **Cliente** and **Compra** tables. Each entry in **CompraCliente** represents a single transaction between a customer and a purchase.
        
    - **Benefit**: This relationship helps in tracking customer purchase history, analyzing buying patterns, and making data-driven decisions on customer behavior and marketing strategies.
        
- **Foreign Keys**:
    
    - `Cliente.IdCliente` references `CompraCliente.IdCliente`.
    - `Compra.IdCompras` references `CompraCliente.IdCompras`.

---

### 2. **Cliente ↔ Campania (Cliente and Campania Relationship)**

- **Nature of Relationship**: Many-to-many.
    
- **Description**: A client (**Cliente**) can be associated with multiple campaigns (**Campania**), and vice versa. This relationship is managed by the **RecordCliente** table, which connects clients and campaigns. This is essential for tracking which clients are participating in which marketing campaigns.
    
    - **How It Works**: The **RecordCliente** table records the relationships between clients and campaigns. Each row represents a client that is part of a specific campaign.
        
    - **Benefit**: This relationship allows for flexible campaign tracking, making it easier to analyze how customers respond to various campaigns and adjust marketing efforts accordingly.
        
- **Foreign Keys**:
    
    - `Cliente.IdCliente` references `RecordCliente.IdCliente`.
    - `Campania.IdCampania` references `RecordCliente.IdCampania`.

---

### 3. **Compra ↔ Campania (Compra and Campania Relationship)**

- **Nature of Relationship**: Many-to-many.
    
- **Description**: Purchases (**Compra**) can be linked to specific campaigns (**Campania**) through the **CompraCliente** table. This relationship helps in tracking how different campaigns influence purchasing behavior.
    
    - **How It Works**: In the **CompraCliente** table, each purchase is associated with a client and can be connected to one or more campaigns, depending on which campaigns prompted the purchase.
        
    - **Benefit**: This allows for detailed reporting on which campaigns led to actual sales, helping in measuring campaign effectiveness and ROI (Return on Investment).
        
- **Foreign Keys**:
    
    - `Compra.IdCompras` references `CompraCliente.IdCompras`.
    - `Campania.IdCampania` references `CompraCliente.IdCampania`.

---

### 4. **HoraCaptacion ↔ Cliente (HoraCaptacion and Cliente Relationship)**

- **Nature of Relationship**: One-to-many.
    
- **Description**: The **HoraCaptacion** table stores the date and time when a client was captured or registered in the system. Each client (**Cliente**) can have multiple records of engagement or lead captures, which allows for tracking customer onboarding over time.
    
    - **How It Works**: Every time a lead is captured, the **HoraCaptacion** table logs this event. The **Cliente** table references these entries, meaning that for each customer, you can track when they were first captured and any subsequent capture sessions.
        
    - **Benefit**: This helps businesses track the timing of customer interactions, which is useful for understanding customer acquisition timelines and measuring the effectiveness of different lead generation strategies.
        
- **Foreign Keys**:
    
    - `Cliente.IdCliente` references `HoraCaptacion.IdCliente`.

---

### 5. **Cliente ↔ Pais (Cliente and Pais Relationship)**

- **Nature of Relationship**: Many-to-one.
    
- **Description**: Every client (**Cliente**) is associated with a country (**Pais**), which is identified using the `idPais` column. The **Pais** table holds the country information, and each client is linked to their respective country through the `idPais` foreign key.
    
    - **How It Works**: The **Cliente** table contains the `idPais` column, which refers to the `IdPais` column in the **Pais** table. This allows the system to store and reference the country of each client efficiently.
        
    - **Benefit**: This relationship helps in geographically segmenting customers and allows businesses to analyze customer demographics based on location.
        
- **Foreign Keys**:
    
    - `Cliente.idPais` references `Pais.IdPais`.

---

### 6. **Compra ↔ ConceptoCompra (Compra and ConceptoCompra Relationship)**

- **Nature of Relationship**: Many-to-one.
    
- **Description**: The **Compra** table stores purchases, and each purchase is associated with a specific purchase concept (**ConceptoCompra**). This relationship helps categorize purchases into different types of concepts (e.g., product types, discount codes, or service categories).
    
    - **How It Works**: The **Compra** table contains a foreign key (`Concepto`) referencing the **ConceptoCompra** table. This ensures that each purchase is classified under a specific concept, aiding in organized reporting and analysis.
        
    - **Benefit**: By linking purchases to specific concepts, businesses can generate insightful reports, analyze purchasing trends, and optimize product offerings or sales strategies.
        
- **Foreign Keys**:
    
    - `Compra.Concepto` references `ConceptoCompra.IdConcepto`.

---

### 7. **Campania ↔ Producto (Campania and Producto Relationship)**

- **Nature of Relationship**: Many-to-many.
    
- **Description**: A campaign (**Campania**) can involve multiple products (**Producto**), and each product can be part of multiple campaigns. This relationship is managed through the **CampaniaProducto** table.
    
    - **How It Works**: The **CampaniaProducto** table links products to campaigns, allowing businesses to track which products are part of which campaigns. Each row in the table represents a product being featured in a specific campaign.
        
    - **Benefit**: This allows businesses to manage their marketing campaigns more efficiently and track which products are most commonly featured in campaigns, optimizing inventory and promotional strategies.
        
- **Foreign Keys**:
    
    - `Campania.IdCampania` references `CampaniaProducto.IdCampania`.
    - `Producto.IdProducto` references `CampaniaProducto.IdProducto`.

---

### General Benefits of These Relationships:

- **Data Integrity**: Foreign key relationships ensure that data remains consistent across different tables. For example, if a client is deleted, related records in **CompraCliente**, **RecordCliente**, and **HoraCaptacion** are either updated or removed to maintain referential integrity.
    
- **Simplified Data Access**: These relationships simplify querying complex data. For example, querying a client’s purchase history or campaign participation can be done with a single query by joining the relevant tables.
    
- **Reporting and Analytics**: With these relationships, reporting becomes much easier. For instance, you can analyze how many clients participated in a specific campaign, which products were purchased the most, or which regions have the highest number of active clients.

By creating these interconnections between tables, the database ensures that all necessary data is available for analysis and decision-making while maintaining a streamlined and efficient structure.

![ERDIAGRAM](https://i.imgur.com/lJCPsaJ.png)
---

## 🚀 Optimizations

### 📈 Indexes

To improve performance of searches:

```sql
CREATE INDEX user_groups_user_id_index ON Cliente("IdCliente");
CREATE INDEX user_groups_group_id_index ON Campania("IdCampania");
