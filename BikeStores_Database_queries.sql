use BikeStores; 

-- 1. Top 5 Selling Products by Quantity Across All Stores

SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- 2. Revenue Generated by Each Store

SELECT
    s.store_name,
    ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM
    order_items oi
JOIN
    orders o ON oi.order_id = o.order_id
JOIN
    stores s ON o.store_id = s.store_id
GROUP BY
    s.store_name
ORDER BY
    total_revenue DESC;

-- 3. Unsold Products Across All Stores

SELECT p.product_name, p.product_id
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 4. Categorized Stock Levels

SELECT p.product_name, s.store_name, st.quantity AS stock_left,
    CASE
        WHEN st.quantity < 10 THEN 'Low Stock'
        WHEN st.quantity BETWEEN 10 AND 20 THEN 'Moderate Stock'
        ELSE 'High Stock'
    END AS stock_category
FROM stocks st
JOIN products p ON st.product_id = p.product_id
JOIN stores s ON st.store_id = s.store_id
ORDER BY stock_left ASC;

-- 5. Average Discount Applied Per Category

SELECT cat.category_name, ROUND(AVG(oi.discount), 3) AS avg_discount
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name
ORDER BY avg_discount DESC;

-- 6. Orders Processed by Each Staff Member

SELECT st.first_name, st.last_name, COUNT(o.order_id) AS orders_processed
FROM staffs st
JOIN orders o ON st.staff_id = o.staff_id
GROUP BY st.staff_id, st.first_name, st.last_name
ORDER BY orders_processed DESC;


-- 7. Order Fulfillment Analysis

SELECT o.order_id, s.store_name, DATEDIFF(o.shipped_date, o.order_date) AS fulfillment_time,
    CASE
        WHEN DATEDIFF(o.shipped_date, o.order_date) <= 2 THEN 'Fast'
        WHEN DATEDIFF(o.shipped_date, o.order_date) BETWEEN 3 AND 5 THEN 'Average'
        ELSE 'Slow'
    END AS fulfillment_category
FROM orders o
JOIN stores s ON o.store_id = s.store_id
WHERE o.shipped_date IS NOT NULL
ORDER BY fulfillment_time ASC;


-- 8. Total Items Sold Per Product Category

SELECT cat.category_name, 
       SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name
ORDER BY total_quantity_sold DESC;

-- 9. Total Revenue per Brand

SELECT b.brand_name, 
       ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY b.brand_name
ORDER BY total_revenue DESC;


-- 10. Customer retention by Store

SELECT 
    s.store_name,
    COUNT(DISTINCT c.customer_id) AS unique_customers,
    COUNT(o.order_id) AS total_orders,
    (COUNT(o.order_id) / COUNT(DISTINCT c.customer_id)) AS average_orders_per_customer
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    stores s ON o.store_id = s.store_id
GROUP BY 
    s.store_name
ORDER BY 
    average_orders_per_customer DESC;
