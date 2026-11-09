# 商品圖片管理架構與維護指南 (Product Image Management Architecture)

本目錄存放服飾資料庫系統所使用的所有商品實體攝影照片。本專案透過結構化的圖片管理架構，確保前端展示（GitHub Pages）、後端 API 與資料庫（TiDB Cloud / MySQL）之間的圖片網址與服飾類別 100% 精準對齊。

---

## 一、 目錄命名與檔案規範

1. **檔案命名規則**：
   - 採用標準三位數流水號：`product-001.jpg` 至 `product-060.jpg`。
   - 與資料表 `clothing.product_id`（P0001～P0060）建立專屬對應關係。
2. **規格與格式**：
   - **格式**：JPG / JPEG 或 WebP。
   - **長寬比例**：統一推薦 **3:4** 或 **1:1**，建議解析度長邊介於 600px～1200px。
   - **檔案大小**：單張圖檔建議壓縮至 300KB 以下，以提供流暢的前端載入體驗。
3. **路徑無空白字元原則**：
   - 放置於倉庫根目錄 `images/products/` 下，嚴禁使用含空格的資料夾名稱，避免 URL Encoding 編碼轉義（如 `%20`）在 GitHub Pages 或 CDN 快取時失效。

---

## 二、 服飾類別與照片對應架構 (Photo-to-Category Architecture)

資料庫共計 6 大類別，共 60 件服飾。照片實體內容分類如下：

| 檔案編號區間 | 照片實體分類 | 包含款式特徵 | 對應資料庫主要類別 |
| :--- | :--- | :--- | :--- |
| **product-001 ~ 010** | **洋裝 (Dresses)** | 碎花洋裝、吊帶洋裝、長短袖洋裝、襯衫洋裝 | 洋裝 (category_id = 5) |
| **product-011 ~ 020** | **襯衫／上衣 (Shirts/Tops)** | 蝴蝶結襯衫、娃娃領上衣、條紋長袖襯衫、綁帶襯衫 | 上衣 (category_id = 1) |
| **product-021 ~ 030** | **針織衫／毛衣 (Knitwear)** | V領針織開衫、條紋針織、刺繡毛衣、小熊毛衣 | 上衣 (category_id = 1)、運動服 (category_id = 6) |
| **product-031 ~ 033** | **短褲 (Shorts)** | 牛仔短褲、休閒短褲、粉色短褲 | 褲子 (category_id = 2)、運動服 (category_id = 6) |
| **product-034 ~ 040** | **裙裝 (Skirts)** | 牛仔短裙、百褶裙、A字短裙、蛋糕長裙 | 裙子 (category_id = 3) |
| **product-041 ~ 048** | **長褲 (Trousers/Pants)** | 直筒牛仔褲、直筒寬褲、垂墜西裝褲、工裝長褲、吊帶褲 | 褲子 (category_id = 2) |
| **product-049 ~ 053** | **外套 (Jackets/Coats)** | 雙排扣風衣、粉色長版外套、經典丹寧外套、工裝外套 | 外套 (category_id = 4) |
| **product-054 ~ 056** | **連帽衛衣 (Hoodies)** | 淺藍色、白色、黑色連帽休閒衛衣 (帽T) | 外套 (category_id = 4)、運動服 (category_id = 6) |
| **product-057 ~ 060** | **西裝外套 (Blazers)** | 米色、灰色、淡紫色、黑色經典西裝外套 | 外套 (category_id = 4) |

---

## 三、 GitHub Pages 圖片 URL 結構

在 GitHub Pages 上線後，可透過標準絕對網址或相對路徑直接引用：

- **GitHub Pages 絕對路徑**：
  `https://bullet8964.github.io/clothing-search/images/products/product-001.jpg`
- **前端相對路徑**：
  `./images/products/product-001.jpg`
- **GitHub Raw CDN（備援）**：
  `https://raw.githubusercontent.com/Bullet8964/clothing-search/main/images/products/product-001.jpg`

---

## 四、 資料庫欄位同步與更新標準作業程序 (SOP)

1. **上傳新圖片**：
   將符合命名規則之圖檔新增至本目錄 `images/products/`。
2. **推播至 GitHub**：
   ```bash
   git add images/products/
   git commit -m "Add new product images"
   git push origin main
   ```
3. **更新資料庫 `image_url`**：
   確認檔案在 GitHub 上可正常開啟後，於 TiDB Cloud / MySQL 執行 SQL 更新：
   ```sql
   UPDATE clothing
   SET image_url = 'https://bullet8964.github.io/clothing-search/images/products/product-001.jpg'
   WHERE product_id = 'P0001';
   ```
4. **前端容錯機制 (Resilient Loading)**：
   前端在載入圖片時，實作多層容錯：
   - 第 1 層：優先讀取資料庫回傳之 `image_url`。
   - 第 2 層：若為相對路徑或失敗，嘗試 `./images/products/product-XXX.jpg`。
   - 第 3 層：嘗試 GitHub Raw CDN。
   - 第 4 層：若皆無法載入，啟動優雅 SVG 佔位圖示，避免畫面產生破損圖示。
