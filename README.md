# 衣物資料庫連結應用系統 (Clothing Search Dashboard)

> **專案網址**：[https://bullet8964.github.io/clothing-search/](https://bullet8964.github.io/clothing-search/)  
> **GitHub 倉庫**：[https://github.com/Bullet8964/clothing-search](https://github.com/Bullet8964/clothing-search)  
> **架構技術**：TiDB Cloud (MySQL) × Google Colab × Flask API (Render) × GitHub Pages (Vanilla JS / CSS)

---

## 一、 專案核心特色與評分達成指標

1. **MySQL / TiDB Cloud 資料庫建置與資料匯入** (`clothing_homework.sql`)：
   - 包含完整 6 張資料表 Schema（`categories`, `brands`, `clothing`, `customers`, `orders`, `order_items` 及進階 `stock_reservation`）。
   - 包含全數 60 筆商品、品牌、會員、訂單及訂單明細之完整 INSERT 語法。
   - 資料表 `clothing` 已正式新增 `image_url` 欄位並完成網址對應。
   - 內建必作題目解答（A1～A5 基礎查詢、B1～B3 中階分組與子查詢、C1 約束設計與失敗測試、C2 預存函數與業務統計）。
2. **Google Colab 測試與資料庫運作** (`Colab.ipynb`)：
   - 提供標準 Jupyter Notebook，可直接於 Google Colab 執行。
   - 實作安全連線（SSL + PyMySQL）、資料表檢驗、`image_url` 完整性測試、SQL 作業查詢輸出與視覺化圖表。
3. **後端 API 串接與佈署** (`app.py`, `render.yaml`, `requirements.txt`)：
   - 使用輕量化 Flask 撰寫 `/api/clothing` 端點，支援關鍵字、顏色、類別、最高價格過濾與 CORS 跨域請求。
   - 支援 Render 雲端平台一鍵部署，亦可於本地直接執行。
4. **商品圖片與版面美化 (少女風 Boutique 介面)**：
   - 60 款服飾 100% 獨立相片，絕不重複，並精準與商品名稱、類別及顏色相符。
   - 提供分類快捷方塊（洋裝、上衣、褲裝、裙裝、外套、運動服）、即時搜尋、顏色與價格篩選。
   - 支援商品收藏（♡）與購物車（🛍）動態計算。
5. **商品照片與資料庫正式對應**：
   - 所有資料庫商品之 `image_url` 欄位皆統一指向 GitHub Pages 靜態圖床 `https://bullet8964.github.io/clothing-search/images/products/product-XXX.jpg`。
6. **商品圖片管理架構** (`images/products/README.md`)：
   - 移除原有包含空白字元的路徑，規範以 `images/products/product-XXX.jpg` 存放。
   - 制定標準圖片管理規範、分類對應矩陣、長寬比（3:4）與資料庫同步 SOP。

---

## 二、 檔案結構說明

```text
clothing-search/
├── images/
│   └── products/                   # 60 張服飾商品攝影照片 (product-001.jpg ~ 060.jpg)
│       └── README.md               # 商品圖片管理架構與維護指南 (符合規範 6)
├── index.html                      # 前端展示儀表板 (Dashboard)
├── style.css                       # 精品少女風樣式表
├── script.js                       # 前端互動邏輯 (多層容錯載入、API串接、購物車、收藏)
├── app.py                          # Flask 後端 API (TiDB Cloud / MySQL 連線)
├── requirements.txt                # 後端依賴套件清單
├── render.yaml                     # Render 雲端自動部署設定檔
├── Colab.ipynb                     # Google Colab 測試與串接筆記本 (符合規範 2)
└── clothing_homework.sql           # 完整 MySQL/TiDB 建表、資料匯入與題目解答 (符合規範 1, 5)
```

---

## 三、 快速使用與部署指南

### 1. 資料庫匯入 (TiDB Cloud / MySQL)
登入 TiDB Cloud Console 或本機 MySQL 用戶端，執行：
```bash
mysql -h <TIDB_HOST> -P 4000 -u <TIDB_USER> -p < clothing_homework.sql
```

### 2. 啟動後端 API (本地測試)
```bash
pip install -r requirements.txt
export TIDB_HOST="your-tidb-host"
export TIDB_USER="your-tidb-user"
export TIDB_PASSWORD="your-tidb-password"
python app.py
```

### 3. 開啟前端儀表板 (GitHub Pages)
進入 GitHub 倉庫設定 `Settings -> Pages`，將 Branch 設定為 `main` / `root` 並儲存。稍候片刻即可透過 `https://bullet8964.github.io/clothing-search/` 瀏覽網站！
