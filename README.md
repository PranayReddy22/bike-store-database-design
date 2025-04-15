# 🚴‍♂️ Bike Store Management System – Relational Database Design

This project presents the design and implementation of a relational database system for **PGK BikeStore Corp**, a multi-location bicycle retail chain. The system streamlines inventory management, sales tracking, customer management, and staff oversight. It includes detailed ER and relational models, SQL scripts for schema creation and population, and analytical queries for business insights.

---

## 🎯 Objectives

- Design a normalized, scalable relational schema using 3NF
- Implement a transactional database for sales, inventory, and customer data
- Enable real-time query access for store managers, inventory teams, and sales associates
- Generate actionable insights through advanced SQL queries

---

## 🧱 Entities and Relationships

The database models the following entities:
- **Customers**: Personal and contact details, linked to orders
- **Orders & OrderItems**: Sales data including status, dates, product details, and discounts
- **Products**: With brand, category, and pricing info
- **Stores**: With location and contact data
- **Staffs**: Hierarchical relationship captured using a recursive `supervised_by` field
- **Brands and Categories**: Linked to products
- **Stocks**: Many-to-many relation between products and stores

Key relationship highlights:
- 1:M: Customers → Orders, Stores → Staff, Orders → OrderItems
- M:1: Products → Brands & Categories
- M:N: Products ↔ Stores (via Stocks)
- Recursive: Staffs supervise other Staffs

---

## 🧠 Design Highlights

- **Normalization**: Fully normalized to 3NF for consistency and reduced redundancy
- **ER Diagram**: Conceptual and logical models developed with support for future scalability
- **Relational Schema**: Includes primary keys, foreign keys, and composite keys (e.g., `order_id`, `item_id` for OrderItems)
- **Constraints**:
  - `ON DELETE CASCADE` and `ON UPDATE CASCADE` to ensure referential integrity
- **Data Types**: Carefully selected for precision (e.g., `DECIMAL` for price, `DATE` for order timelines, `TINYINT` for status flags)

---

## 📊 Key SQL Queries

1. **Unsold Products**  
   - Uses `LEFT JOIN` to find products never included in any order  
   - Helps marketing/sales teams identify low-demand items

2. **Total Items Sold by Category**  
   - Aggregates `SUM(quantity)` grouped by product category  
   - Used by inventory analysts to optimize product mix

3. **Total Revenue per Brand**  
   - Combines `order_items`, `products`, and `brands`  
   - Calculates brand-wise revenue using `(quantity * price * (1 - discount))`

4. **Order Fulfillment Analysis**  
   - Uses `DATEDIFF` and `CASE` to categorize shipping delays  
   - Supports operational improvements across stores

---

## 🔁 Alternative Design Considerations

- **MongoDB**:  
  - Orders, customers, and product data could be stored as embedded documents  
  - Increases flexibility for dynamic schemas, useful for real-time apps

- **Neo4j**:  
  - Models relationships as nodes and edges  
  - Ideal for exploring staff hierarchies, product recommendations, or supply chain networks

---

## 📌 Technologies Used

- SQL (MySQL / SQL Server syntax)
- Modeling: Conceptual and Logical Database Design (via ERDPlus)
- Tools: ERDPlus, Microsoft PowerPoint
- Data Source: SQL Server Sample Database

---

## 📄 Reports

- [📊 Final Project Report (PDF)](DB%20Design%20Final%20Project%20Report.pdf)
- [📈 Presentation Slides](Bike%20Store%20Management%20System.pptx)

---

## 📃 License

This project is licensed under the [MIT License](LICENSE).
