-- 1. 建立資料庫與 Table Schema
CREATE DATABASE IF NOT EXISTS clothing_store DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clothing_store;

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE clothing (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    color VARCHAR(20),
    size VARCHAR(10),
    price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    listed_date DATE NOT NULL,
    image_url VARCHAR(500) DEFAULT NULL, -- 新增題目要求的 image_url 欄位
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    member_level VARCHAR(20)
);

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES clothing(product_id)
);

-- =========================================================
-- 2. 必作題目查詢解答 (A1 ~ C2)
-- =========================================================

-- A1. 查詢所有「上衣」商品名稱與價格，依價格由高至低排序
SELECT c.product_name, c.price
FROM clothing c
JOIN categories cat ON c.category_id = cat.category_id
WHERE cat.category_name = '上衣'
ORDER BY c.price DESC;

-- A2. 查詢 Urban Leaf 品牌且價格超過 1,000 元的商品編號、名稱、價格
SELECT c.product_id, c.product_name, c.price
FROM clothing c
JOIN brands b ON c.brand_id = b.brand_id
WHERE b.brand_name = 'Urban Leaf' AND c.price > 1000;

-- A3. 查詢曾購買商品（已完成訂單）的顧客姓名，不重複並依姓名排序
SELECT DISTINCT cust.customer_name
FROM customers cust
JOIN orders o ON cust.customer_id = o.customer_id
WHERE o.status = '已完成'
ORDER BY cust.customer_name ASC;

-- A4. 2025 年曾在已完成訂單銷售、但 2026 年未曾在已完成訂單銷售的商品編號
SELECT oi.product_id
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = '已完成' AND YEAR(o.order_date) = 2025
EXCEPT
SELECT oi.product_id
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = '已完成' AND YEAR(o.order_date) = 2026;

-- A5. 使用 LIKE 查詢名稱包含「外套」的商品名稱、品牌及價格
SELECT c.product_name, b.brand_name, c.price
FROM clothing c
JOIN brands b ON c.brand_id = b.brand_id
WHERE c.product_name LIKE '%外套%';

-- B1. 查詢商品數量超過 2 款的分類，顯示分類名稱、商品款數及平均定價
SELECT cat.category_name, COUNT(c.product_id) AS product_count, AVG(c.price) AS avg_price
FROM categories cat
JOIN clothing c ON cat.category_id = c.category_id
GROUP BY cat.category_id, cat.category_name
HAVING COUNT(c.product_id) > 2;

-- B2. 使用子查詢找出定價最高的商品名稱與價格；不可使用 ORDER BY 或 LIMIT
SELECT product_name, price
FROM clothing
WHERE price = (SELECT MAX(price) FROM clothing);

-- B3. 列出所有商品及其已完成訂單的累計銷售件數，未售出者必須顯示 0
SELECT c.product_id, c.product_name, COALESCE(SUM(oi.quantity), 0) AS total_sold_qty
FROM clothing c
LEFT JOIN order_items oi ON c.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status = '已完成'
GROUP BY c.product_id, c.product_name;

-- C1. 建立 stock_reservation 資料表與條件限制
CREATE TABLE stock_reservation (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    reserve_date DATE NOT NULL,
    quantity INT NOT NULL CHECK (quantity BETWEEN 1 AND 4),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES clothing(product_id) ON DELETE CASCADE,
    CONSTRAINT unique_customer_product_date UNIQUE (customer_id, product_id, reserve_date)
);

-- 新增兩筆合法預留
INSERT INTO stock_reservation (customer_id, product_id, reserve_date, quantity) VALUES ('C001', 'P0001', '2026-10-01', 2);
INSERT INTO stock_reservation (customer_id, product_id, reserve_date, quantity) VALUES ('C002', 'P0002', '2026-10-01', 3);

-- C2. 建立 total_sales 函數並查詢總銷售額超過 10,000 元的品牌
DELIMITER //
CREATE FUNCTION total_sales(p_brand_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT COALESCE(SUM(oi.quantity * oi.unit_price), 0) INTO v_total
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN clothing c ON oi.product_id = c.product_id
    WHERE c.brand_id = p_brand_id AND o.status = '已完成';
    RETURN v_total;
END //
DELIMITER ;

SELECT b.brand_id, b.brand_name, total_sales(b.brand_id) AS total_sales_amount
FROM brands b
HAVING total_sales_amount > 10000;
