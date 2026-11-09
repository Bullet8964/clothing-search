-- =========================================================
-- 服飾商品資料庫 (Clothing Database) - TiDB Cloud / MySQL
-- GitHub: https://github.com/Bullet8964/clothing-search
-- =========================================================
CREATE DATABASE IF NOT EXISTS clothing_store DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clothing_store;

-- 1. 建立資料表 (含 image_url 欄位與外鍵約束)
CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS clothing (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    color VARCHAR(20),
    size VARCHAR(10),
    price DECIMAL(10,2) NOT NULL,
    stock_qty INT NOT NULL DEFAULT 0,
    listed_date DATE NOT NULL,
    image_url VARCHAR(500) DEFAULT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    member_level VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    item_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES clothing(product_id)
);

-- =========================================================
-- 2. 匯入基礎資料 (categories, brands, clothing, customers, orders, order_items)
-- =========================================================
-- 匯入 categories
INSERT INTO categories (category_id, category_name) VALUES
(1, '上衣'),
(2, '褲子'),
(3, '裙子'),
(4, '外套'),
(5, '洋裝'),
(6, '運動服');

-- 匯入 brands
INSERT INTO brands (brand_id, brand_name, country) VALUES
(1, 'Urban Leaf', '台灣'),
(2, 'North Thread', '日本'),
(3, 'Mode Studio', '韓國'),
(4, 'Daily Wear', '台灣'),
(5, 'Peak Active', '美國');

-- 匯入 clothing (含對應之 GitHub Pages image_url 欄位)
INSERT INTO clothing (product_id, product_name, category_id, brand_id, color, size, price, stock_qty, listed_date, image_url) VALUES
('P0001', '純棉T恤 01款', 1, 1, '白色', 'M', 610, 7, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-014.jpg'),
('P0002', '直筒牛仔褲 02款', 2, 2, '米色', 'L', 830, 14, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-041.jpg'),
('P0003', '百褶裙 03款', 3, 3, '藍色', 'XL', 1050, 21, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-035.jpg'),
('P0004', '防風外套 04款', 4, 4, '灰色', 'S', 1270, 28, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-049.jpg'),
('P0005', '碎花洋裝 05款', 5, 5, '綠色', 'M', 1490, 35, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-001.jpg'),
('P0006', '運動上衣 06款', 6, 1, '黑色', 'L', 1710, 4, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-055.jpg'),
('P0007', '襯衫 07款', 1, 2, '白色', 'XL', 1930, 11, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-013.jpg'),
('P0008', '休閒長褲 08款', 2, 3, '米色', 'S', 2150, 18, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-044.jpg'),
('P0009', '牛仔短裙 09款', 3, 4, '藍色', 'M', 2370, 25, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-034.jpg'),
('P0010', '丹寧外套 10款', 4, 5, '灰色', 'L', 500, 32, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-051.jpg'),
('P0011', '無袖洋裝 11款', 5, 1, '綠色', 'XL', 720, 1, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-003.jpg'),
('P0012', '瑜伽褲 12款', 6, 2, '黑色', 'S', 940, 8, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-023.jpg'),
('P0013', '針織上衣 13款', 1, 3, '白色', 'M', 1160, 15, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-021.jpg'),
('P0014', '西裝褲 14款', 2, 4, '米色', 'L', 1380, 22, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-045.jpg'),
('P0015', '長裙 15款', 3, 5, '藍色', 'XL', 1600, 29, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-039.jpg'),
('P0016', '連帽外套 16款', 4, 1, '灰色', 'S', 1820, 36, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-056.jpg'),
('P0017', '長袖洋裝 17款', 5, 2, '綠色', 'M', 2040, 5, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-005.jpg'),
('P0018', '訓練短褲 18款', 6, 3, '黑色', 'L', 2260, 12, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-019.jpg'),
('P0019', '短袖上衣 19款', 1, 4, '白色', 'XL', 390, 19, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-011.jpg'),
('P0020', '寬褲 20款', 2, 5, '米色', 'S', 610, 26, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-042.jpg'),
('P0021', 'A字裙 21款', 3, 1, '藍色', 'M', 830, 33, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-037.jpg'),
('P0022', '西裝外套 22款', 4, 2, '灰色', 'L', 1050, 2, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-057.jpg'),
('P0023', '襯衫洋裝 23款', 5, 3, '綠色', 'XL', 1270, 9, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-009.jpg'),
('P0024', '運動外套 24款', 6, 4, '黑色', 'S', 1490, 16, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-059.jpg'),
('P0025', '條紋上衣 25款', 1, 5, '白色', 'M', 1710, 23, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-017.jpg'),
('P0026', '棉質短褲 26款', 2, 1, '米色', 'L', 1930, 30, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-032.jpg'),
('P0027', '針織裙 27款', 3, 2, '藍色', 'XL', 2150, 37, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-027.jpg'),
('P0028', '羊毛外套 28款', 4, 3, '灰色', 'S', 2370, 6, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-058.jpg'),
('P0029', '針織洋裝 29款', 5, 4, '綠色', 'M', 500, 13, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-007.jpg'),
('P0030', '慢跑長褲 30款', 6, 5, '黑色', 'L', 720, 20, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-020.jpg'),
('P0031', '純棉T恤 31款', 1, 1, '白色', 'XL', 940, 27, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-015.jpg'),
('P0032', '直筒牛仔褲 32款', 2, 2, '米色', 'S', 1160, 34, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-047.jpg'),
('P0033', '百褶裙 33款', 3, 3, '藍色', 'M', 1380, 3, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-036.jpg'),
('P0034', '防風外套 34款', 4, 4, '灰色', 'L', 1600, 10, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-052.jpg'),
('P0035', '碎花洋裝 35款', 5, 5, '綠色', 'XL', 1820, 17, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-002.jpg'),
('P0036', '運動上衣 36款', 6, 1, '黑色', 'S', 2040, 24, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-028.jpg'),
('P0037', '襯衫 37款', 1, 2, '白色', 'M', 2260, 31, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-016.jpg'),
('P0038', '休閒長褲 38款', 2, 3, '米色', 'L', 390, 0, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-048.jpg'),
('P0039', '牛仔短裙 39款', 3, 4, '藍色', 'XL', 610, 7, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-031.jpg'),
('P0040', '丹寧外套 40款', 4, 5, '灰色', 'S', 830, 14, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-053.jpg'),
('P0041', '無袖洋裝 41款', 5, 1, '綠色', 'M', 1050, 21, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-004.jpg'),
('P0042', '瑜伽褲 42款', 6, 2, '黑色', 'L', 1270, 28, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-025.jpg'),
('P0043', '針織上衣 43款', 1, 3, '白色', 'XL', 1490, 35, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-024.jpg'),
('P0044', '西裝褲 44款', 2, 4, '米色', 'S', 1710, 4, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-046.jpg'),
('P0045', '長裙 45款', 3, 5, '藍色', 'M', 1930, 11, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-040.jpg'),
('P0046', '連帽外套 46款', 4, 1, '灰色', 'L', 2150, 18, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-054.jpg'),
('P0047', '長袖洋裝 47款', 5, 2, '綠色', 'XL', 2370, 25, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-006.jpg'),
('P0048', '訓練短褲 48款', 6, 3, '黑色', 'S', 500, 32, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-022.jpg'),
('P0049', '短袖上衣 49款', 1, 4, '白色', 'M', 720, 1, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-012.jpg'),
('P0050', '寬褲 50款', 2, 5, '米色', 'L', 940, 8, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-043.jpg'),
('P0051', 'A字裙 51款', 3, 1, '藍色', 'XL', 1160, 15, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-038.jpg'),
('P0052', '西裝外套 52款', 4, 2, '灰色', 'S', 1380, 22, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-060.jpg'),
('P0053', '襯衫洋裝 53款', 5, 3, '綠色', 'M', 1600, 29, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-010.jpg'),
('P0054', '運動外套 54款', 6, 4, '黑色', 'L', 1820, 36, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-026.jpg'),
('P0055', '條紋上衣 55款', 1, 5, '白色', 'XL', 2040, 5, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-018.jpg'),
('P0056', '棉質短褲 56款', 2, 1, '米色', 'S', 2260, 12, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-033.jpg'),
('P0057', '針織裙 57款', 3, 2, '藍色', 'M', 390, 19, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-030.jpg'),
('P0058', '羊毛外套 58款', 4, 3, '灰色', 'L', 610, 26, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-050.jpg'),
('P0059', '針織洋裝 59款', 5, 4, '綠色', 'XL', 830, 33, '2026-01-01', 'https://bullet8964.github.io/clothing-search/images/products/product-008.jpg'),
('P0060', '慢跑長褲 60款', 6, 5, '黑色', 'S', 1050, 2, '2025-06-15', 'https://bullet8964.github.io/clothing-search/images/products/product-029.jpg');

-- 匯入 customers
INSERT INTO customers (customer_id, customer_name, city, member_level) VALUES
('C001', '顧客001', '台北', '銀卡'),
('C002', '顧客002', '新竹', '金卡'),
('C003', '顧客003', '台中', '一般'),
('C004', '顧客004', '高雄', '銀卡'),
('C005', '顧客005', '桃園', '金卡'),
('C006', '顧客006', '台北', '一般'),
('C007', '顧客007', '新竹', '銀卡'),
('C008', '顧客008', '台中', '金卡'),
('C009', '顧客009', '高雄', '一般'),
('C010', '顧客010', '桃園', '銀卡'),
('C011', '顧客011', '台北', '金卡'),
('C012', '顧客012', '新竹', '一般'),
('C013', '顧客013', '台中', '銀卡'),
('C014', '顧客014', '高雄', '金卡'),
('C015', '顧客015', '桃園', '一般'),
('C016', '顧客016', '台北', '銀卡'),
('C017', '顧客017', '新竹', '金卡'),
('C018', '顧客018', '台中', '一般'),
('C019', '顧客019', '高雄', '銀卡'),
('C020', '顧客020', '桃園', '金卡'),
('C021', '顧客021', '台北', '一般'),
('C022', '顧客022', '新竹', '銀卡'),
('C023', '顧客023', '台中', '金卡'),
('C024', '顧客024', '高雄', '一般'),
('C025', '顧客025', '桃園', '銀卡');

-- 匯入 orders
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
('O0001', 'C004', '2025-02-02', '已完成'),
('O0002', 'C007', '2025-03-03', '已完成'),
('O0003', 'C010', '2025-04-04', '已完成'),
('O0004', 'C013', '2025-05-05', '已完成'),
('O0005', 'C016', '2025-06-06', '已完成'),
('O0006', 'C019', '2025-07-07', '已完成'),
('O0007', 'C022', '2025-08-08', '已取消'),
('O0008', 'C025', '2025-09-09', '已完成'),
('O0009', 'C003', '2025-10-10', '已完成'),
('O0010', 'C006', '2025-11-11', '已完成'),
('O0011', 'C009', '2025-12-12', '已完成'),
('O0012', 'C012', '2025-01-13', '已完成'),
('O0013', 'C015', '2025-02-14', '已完成'),
('O0014', 'C018', '2025-03-15', '已取消'),
('O0015', 'C021', '2025-04-16', '已完成'),
('O0016', 'C024', '2025-05-17', '已完成'),
('O0017', 'C002', '2025-06-18', '已完成'),
('O0018', 'C005', '2025-07-19', '已完成'),
('O0019', 'C008', '2026-08-20', '已完成'),
('O0020', 'C011', '2026-09-21', '已完成'),
('O0021', 'C014', '2026-10-22', '已取消'),
('O0022', 'C017', '2026-11-23', '已完成'),
('O0023', 'C020', '2026-12-24', '已完成'),
('O0024', 'C023', '2026-01-25', '已完成'),
('O0025', 'C001', '2026-02-26', '已完成'),
('O0026', 'C004', '2026-03-27', '已完成'),
('O0027', 'C007', '2026-04-01', '已完成'),
('O0028', 'C010', '2026-05-02', '已取消'),
('O0029', 'C013', '2026-06-03', '已完成'),
('O0030', 'C016', '2026-07-04', '已完成'),
('O0031', 'C019', '2026-08-05', '已完成'),
('O0032', 'C022', '2026-09-06', '已完成'),
('O0033', 'C025', '2026-10-07', '已完成'),
('O0034', 'C003', '2026-11-08', '已完成'),
('O0035', 'C006', '2026-12-09', '已取消'),
('O0036', 'C009', '2026-01-10', '已完成'),
('O0037', 'C012', '2026-02-11', '已完成'),
('O0038', 'C015', '2026-03-12', '已完成'),
('O0039', 'C018', '2026-04-13', '已完成'),
('O0040', 'C021', '2026-05-14', '已完成'),
('O0041', 'C024', '2026-06-15', '已完成'),
('O0042', 'C002', '2026-07-16', '已取消'),
('O0043', 'C005', '2026-08-17', '已完成'),
('O0044', 'C008', '2026-09-18', '已完成'),
('O0045', 'C011', '2026-10-19', '已完成');

-- 匯入 order_items
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
('D0001', 'O0001', 'P0008', 2, 2150),
('D0002', 'O0001', 'P0019', 3, 390),
('D0003', 'O0002', 'P0015', 3, 1600),
('D0004', 'O0002', 'P0001', 4, 610),
('D0005', 'O0002', 'P0012', 1, 940),
('D0006', 'O0003', 'P0022', 4, 1050),
('D0007', 'O0004', 'P0004', 1, 1270),
('D0008', 'O0004', 'P0015', 2, 1600),
('D0009', 'O0005', 'P0011', 2, 720),
('D0010', 'O0005', 'P0022', 3, 1050),
('D0011', 'O0005', 'P0008', 4, 2150),
('D0012', 'O0006', 'P0018', 3, 2260),
('D0013', 'O0007', 'P0025', 4, 1710),
('D0014', 'O0007', 'P0011', 1, 720),
('D0015', 'O0008', 'P0007', 1, 1930),
('D0016', 'O0008', 'P0018', 2, 2260),
('D0017', 'O0008', 'P0004', 3, 1270),
('D0018', 'O0009', 'P0014', 2, 1380),
('D0019', 'O0010', 'P0021', 3, 830),
('D0020', 'O0010', 'P0007', 4, 1930),
('D0021', 'O0011', 'P0003', 4, 1050),
('D0022', 'O0011', 'P0014', 1, 1380),
('D0023', 'O0011', 'P0025', 2, 1710),
('D0024', 'O0012', 'P0010', 1, 500),
('D0025', 'O0013', 'P0017', 2, 2040),
('D0026', 'O0013', 'P0003', 3, 1050),
('D0027', 'O0014', 'P0024', 3, 1490),
('D0028', 'O0014', 'P0010', 4, 500),
('D0029', 'O0014', 'P0021', 1, 830),
('D0030', 'O0015', 'P0006', 4, 1710),
('D0031', 'O0016', 'P0013', 1, 1160),
('D0032', 'O0016', 'P0024', 2, 1490),
('D0033', 'O0017', 'P0020', 2, 610),
('D0034', 'O0017', 'P0006', 3, 1710),
('D0035', 'O0017', 'P0017', 4, 2040),
('D0036', 'O0018', 'P0002', 3, 830),
('D0037', 'O0019', 'P0023', 4, 1270),
('D0038', 'O0019', 'P0036', 1, 2040),
('D0039', 'O0020', 'P0028', 1, 2370),
('D0040', 'O0020', 'P0041', 2, 1050),
('D0041', 'O0020', 'P0013', 3, 1160),
('D0042', 'O0021', 'P0033', 2, 1380),
('D0043', 'O0022', 'P0038', 3, 390),
('D0044', 'O0022', 'P0010', 4, 500),
('D0045', 'O0023', 'P0043', 4, 1490),
('D0046', 'O0023', 'P0015', 1, 1600),
('D0047', 'O0023', 'P0028', 2, 2370),
('D0048', 'O0024', 'P0048', 1, 500),
('D0049', 'O0025', 'P0012', 2, 940),
('D0050', 'O0025', 'P0025', 3, 1710),
('D0051', 'O0026', 'P0017', 3, 2040),
('D0052', 'O0026', 'P0030', 4, 720),
('D0053', 'O0026', 'P0043', 1, 1490),
('D0054', 'O0027', 'P0022', 4, 1050),
('D0055', 'O0028', 'P0027', 1, 2150),
('D0056', 'O0028', 'P0040', 2, 830),
('D0057', 'O0029', 'P0032', 2, 1160),
('D0058', 'O0029', 'P0045', 3, 1930),
('D0059', 'O0029', 'P0017', 4, 2040),
('D0060', 'O0030', 'P0037', 3, 2260),
('D0061', 'O0031', 'P0042', 4, 1270),
('D0062', 'O0031', 'P0014', 1, 1380),
('D0063', 'O0032', 'P0047', 1, 2370),
('D0064', 'O0032', 'P0019', 2, 390),
('D0065', 'O0032', 'P0032', 3, 1160),
('D0066', 'O0033', 'P0011', 2, 720),
('D0067', 'O0034', 'P0016', 3, 1820),
('D0068', 'O0034', 'P0029', 4, 500),
('D0069', 'O0035', 'P0021', 4, 830),
('D0070', 'O0035', 'P0034', 1, 1600),
('D0071', 'O0035', 'P0047', 2, 2370),
('D0072', 'O0036', 'P0026', 1, 1930),
('D0073', 'O0037', 'P0031', 2, 940),
('D0074', 'O0037', 'P0044', 3, 1710),
('D0075', 'O0038', 'P0036', 3, 2040),
('D0076', 'O0038', 'P0049', 4, 720),
('D0077', 'O0038', 'P0021', 1, 830),
('D0078', 'O0039', 'P0041', 4, 1050),
('D0079', 'O0040', 'P0046', 1, 2150),
('D0080', 'O0040', 'P0018', 2, 2260),
('D0081', 'O0041', 'P0010', 2, 500),
('D0082', 'O0041', 'P0023', 3, 1270),
('D0083', 'O0041', 'P0036', 4, 2040),
('D0084', 'O0042', 'P0015', 3, 1600),
('D0085', 'O0043', 'P0020', 4, 610),
('D0086', 'O0043', 'P0033', 1, 1380),
('D0087', 'O0044', 'P0025', 1, 1710),
('D0088', 'O0044', 'P0038', 2, 390),
('D0089', 'O0044', 'P0010', 3, 500),
('D0090', 'O0045', 'P0030', 2, 720);

-- =========================================================
-- 3. 必作題目查詢解答 (A1 ~ C2)
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

-- A4. 使用集合運算找出 2025 年曾在已完成訂單銷售、但 2026 年未曾在已完成訂單銷售的商品編號
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
CREATE TABLE IF NOT EXISTS stock_reservation (
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

-- C1 失敗測試案例 1：重複預留 (違反 UNIQUE 約束)
-- INSERT INTO stock_reservation (customer_id, product_id, reserve_date, quantity) VALUES ('C001', 'P0001', '2026-10-01', 1);

-- C1 失敗測試案例 2：數量為 6 (違反 CHECK 介於 1~4 約束)
-- INSERT INTO stock_reservation (customer_id, product_id, reserve_date, quantity) VALUES ('C001', 'P0002', '2026-10-02', 6);

-- C1 失敗測試案例 3：商品不存在 P9999 (違反 FOREIGN KEY 約束)
-- INSERT INTO stock_reservation (customer_id, product_id, reserve_date, quantity) VALUES ('C001', 'P9999', '2026-10-03', 2);

-- C2. 建立 total_sales 函數並查詢總銷售額超過 10,000 元的品牌
DROP FUNCTION IF EXISTS total_sales;
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
