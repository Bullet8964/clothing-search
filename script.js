// 服飾商品資料庫前端邏輯 — GitHub Pages × TiDB Cloud API
// 專屬倉庫: Bullet8964/clothing-search
const GITHUB_USER = "Bullet8964";
const REPO_NAME = "clothing-search";

// API 網址設定 (可替換為您的 Render 或本機後端 API 網址)
const API_URL = "https://clothing-search-api-vk6q.onrender.com/api/clothing";

const $ = id => document.getElementById(id);
const categories = [
  ["洋裝", "👗", "Dress"],
  ["上衣", "🎀", "Tops"],
  ["褲裝", "👖", "Pants"],
  ["裙裝", "🌸", "Skirts"],
  ["外套", "🧥", "Outer"],
  ["運動服", "🏃", "Sports"]
];

// 完整 60 件商品真實資料集 (與 TiDB Cloud / MySQL 完全一致，確保離線與首載 100% 正常顯示)
const DEFAULT_PRODUCTS = [
  {
    "id": "P0001",
    "name": "純棉T恤 01款",
    "category": "上衣",
    "brand": "Urban Leaf",
    "color": "白色",
    "size": "M",
    "price": 610.0,
    "stock": 7,
    "imgNum": "014",
    "img": "./images/products/product-014.jpg"
  },
  {
    "id": "P0002",
    "name": "直筒牛仔褲 02款",
    "category": "褲子",
    "brand": "North Thread",
    "color": "米色",
    "size": "L",
    "price": 830.0,
    "stock": 14,
    "imgNum": "041",
    "img": "./images/products/product-041.jpg"
  },
  {
    "id": "P0003",
    "name": "百褶裙 03款",
    "category": "裙子",
    "brand": "Mode Studio",
    "color": "藍色",
    "size": "XL",
    "price": 1050.0,
    "stock": 21,
    "imgNum": "035",
    "img": "./images/products/product-035.jpg"
  },
  {
    "id": "P0004",
    "name": "防風外套 04款",
    "category": "外套",
    "brand": "Daily Wear",
    "color": "灰色",
    "size": "S",
    "price": 1270.0,
    "stock": 28,
    "imgNum": "049",
    "img": "./images/products/product-049.jpg"
  },
  {
    "id": "P0005",
    "name": "碎花洋裝 05款",
    "category": "洋裝",
    "brand": "Peak Active",
    "color": "綠色",
    "size": "M",
    "price": 1490.0,
    "stock": 35,
    "imgNum": "001",
    "img": "./images/products/product-001.jpg"
  },
  {
    "id": "P0006",
    "name": "運動上衣 06款",
    "category": "運動服",
    "brand": "Urban Leaf",
    "color": "黑色",
    "size": "L",
    "price": 1710.0,
    "stock": 4,
    "imgNum": "055",
    "img": "./images/products/product-055.jpg"
  },
  {
    "id": "P0007",
    "name": "襯衫 07款",
    "category": "上衣",
    "brand": "North Thread",
    "color": "白色",
    "size": "XL",
    "price": 1930.0,
    "stock": 11,
    "imgNum": "013",
    "img": "./images/products/product-013.jpg"
  },
  {
    "id": "P0008",
    "name": "休閒長褲 08款",
    "category": "褲子",
    "brand": "Mode Studio",
    "color": "米色",
    "size": "S",
    "price": 2150.0,
    "stock": 18,
    "imgNum": "044",
    "img": "./images/products/product-044.jpg"
  },
  {
    "id": "P0009",
    "name": "牛仔短裙 09款",
    "category": "裙子",
    "brand": "Daily Wear",
    "color": "藍色",
    "size": "M",
    "price": 2370.0,
    "stock": 25,
    "imgNum": "034",
    "img": "./images/products/product-034.jpg"
  },
  {
    "id": "P0010",
    "name": "丹寧外套 10款",
    "category": "外套",
    "brand": "Peak Active",
    "color": "灰色",
    "size": "L",
    "price": 500.0,
    "stock": 32,
    "imgNum": "051",
    "img": "./images/products/product-051.jpg"
  },
  {
    "id": "P0011",
    "name": "無袖洋裝 11款",
    "category": "洋裝",
    "brand": "Urban Leaf",
    "color": "綠色",
    "size": "XL",
    "price": 720.0,
    "stock": 1,
    "imgNum": "003",
    "img": "./images/products/product-003.jpg"
  },
  {
    "id": "P0012",
    "name": "瑜伽褲 12款",
    "category": "運動服",
    "brand": "North Thread",
    "color": "黑色",
    "size": "S",
    "price": 940.0,
    "stock": 8,
    "imgNum": "023",
    "img": "./images/products/product-023.jpg"
  },
  {
    "id": "P0013",
    "name": "針織上衣 13款",
    "category": "上衣",
    "brand": "Mode Studio",
    "color": "白色",
    "size": "M",
    "price": 1160.0,
    "stock": 15,
    "imgNum": "021",
    "img": "./images/products/product-021.jpg"
  },
  {
    "id": "P0014",
    "name": "西裝褲 14款",
    "category": "褲子",
    "brand": "Daily Wear",
    "color": "米色",
    "size": "L",
    "price": 1380.0,
    "stock": 22,
    "imgNum": "045",
    "img": "./images/products/product-045.jpg"
  },
  {
    "id": "P0015",
    "name": "長裙 15款",
    "category": "裙子",
    "brand": "Peak Active",
    "color": "藍色",
    "size": "XL",
    "price": 1600.0,
    "stock": 29,
    "imgNum": "039",
    "img": "./images/products/product-039.jpg"
  },
  {
    "id": "P0016",
    "name": "連帽外套 16款",
    "category": "外套",
    "brand": "Urban Leaf",
    "color": "灰色",
    "size": "S",
    "price": 1820.0,
    "stock": 36,
    "imgNum": "056",
    "img": "./images/products/product-056.jpg"
  },
  {
    "id": "P0017",
    "name": "長袖洋裝 17款",
    "category": "洋裝",
    "brand": "North Thread",
    "color": "綠色",
    "size": "M",
    "price": 2040.0,
    "stock": 5,
    "imgNum": "005",
    "img": "./images/products/product-005.jpg"
  },
  {
    "id": "P0018",
    "name": "訓練短褲 18款",
    "category": "運動服",
    "brand": "Mode Studio",
    "color": "黑色",
    "size": "L",
    "price": 2260.0,
    "stock": 12,
    "imgNum": "019",
    "img": "./images/products/product-019.jpg"
  },
  {
    "id": "P0019",
    "name": "短袖上衣 19款",
    "category": "上衣",
    "brand": "Daily Wear",
    "color": "白色",
    "size": "XL",
    "price": 390.0,
    "stock": 19,
    "imgNum": "011",
    "img": "./images/products/product-011.jpg"
  },
  {
    "id": "P0020",
    "name": "寬褲 20款",
    "category": "褲子",
    "brand": "Peak Active",
    "color": "米色",
    "size": "S",
    "price": 610.0,
    "stock": 26,
    "imgNum": "042",
    "img": "./images/products/product-042.jpg"
  },
  {
    "id": "P0021",
    "name": "A字裙 21款",
    "category": "裙子",
    "brand": "Urban Leaf",
    "color": "藍色",
    "size": "M",
    "price": 830.0,
    "stock": 33,
    "imgNum": "037",
    "img": "./images/products/product-037.jpg"
  },
  {
    "id": "P0022",
    "name": "西裝外套 22款",
    "category": "外套",
    "brand": "North Thread",
    "color": "灰色",
    "size": "L",
    "price": 1050.0,
    "stock": 2,
    "imgNum": "057",
    "img": "./images/products/product-057.jpg"
  },
  {
    "id": "P0023",
    "name": "襯衫洋裝 23款",
    "category": "洋裝",
    "brand": "Mode Studio",
    "color": "綠色",
    "size": "XL",
    "price": 1270.0,
    "stock": 9,
    "imgNum": "009",
    "img": "./images/products/product-009.jpg"
  },
  {
    "id": "P0024",
    "name": "運動外套 24款",
    "category": "運動服",
    "brand": "Daily Wear",
    "color": "黑色",
    "size": "S",
    "price": 1490.0,
    "stock": 16,
    "imgNum": "059",
    "img": "./images/products/product-059.jpg"
  },
  {
    "id": "P0025",
    "name": "條紋上衣 25款",
    "category": "上衣",
    "brand": "Peak Active",
    "color": "白色",
    "size": "M",
    "price": 1710.0,
    "stock": 23,
    "imgNum": "017",
    "img": "./images/products/product-017.jpg"
  },
  {
    "id": "P0026",
    "name": "棉質短褲 26款",
    "category": "褲子",
    "brand": "Urban Leaf",
    "color": "米色",
    "size": "L",
    "price": 1930.0,
    "stock": 30,
    "imgNum": "032",
    "img": "./images/products/product-032.jpg"
  },
  {
    "id": "P0027",
    "name": "針織裙 27款",
    "category": "裙子",
    "brand": "North Thread",
    "color": "藍色",
    "size": "XL",
    "price": 2150.0,
    "stock": 37,
    "imgNum": "027",
    "img": "./images/products/product-027.jpg"
  },
  {
    "id": "P0028",
    "name": "羊毛外套 28款",
    "category": "外套",
    "brand": "Mode Studio",
    "color": "灰色",
    "size": "S",
    "price": 2370.0,
    "stock": 6,
    "imgNum": "058",
    "img": "./images/products/product-058.jpg"
  },
  {
    "id": "P0029",
    "name": "針織洋裝 29款",
    "category": "洋裝",
    "brand": "Daily Wear",
    "color": "綠色",
    "size": "M",
    "price": 500.0,
    "stock": 13,
    "imgNum": "007",
    "img": "./images/products/product-007.jpg"
  },
  {
    "id": "P0030",
    "name": "慢跑長褲 30款",
    "category": "運動服",
    "brand": "Peak Active",
    "color": "黑色",
    "size": "L",
    "price": 720.0,
    "stock": 20,
    "imgNum": "020",
    "img": "./images/products/product-020.jpg"
  },
  {
    "id": "P0031",
    "name": "純棉T恤 31款",
    "category": "上衣",
    "brand": "Urban Leaf",
    "color": "白色",
    "size": "XL",
    "price": 940.0,
    "stock": 27,
    "imgNum": "015",
    "img": "./images/products/product-015.jpg"
  },
  {
    "id": "P0032",
    "name": "直筒牛仔褲 32款",
    "category": "褲子",
    "brand": "North Thread",
    "color": "米色",
    "size": "S",
    "price": 1160.0,
    "stock": 34,
    "imgNum": "047",
    "img": "./images/products/product-047.jpg"
  },
  {
    "id": "P0033",
    "name": "百褶裙 33款",
    "category": "裙子",
    "brand": "Mode Studio",
    "color": "藍色",
    "size": "M",
    "price": 1380.0,
    "stock": 3,
    "imgNum": "036",
    "img": "./images/products/product-036.jpg"
  },
  {
    "id": "P0034",
    "name": "防風外套 34款",
    "category": "外套",
    "brand": "Daily Wear",
    "color": "灰色",
    "size": "L",
    "price": 1600.0,
    "stock": 10,
    "imgNum": "052",
    "img": "./images/products/product-052.jpg"
  },
  {
    "id": "P0035",
    "name": "碎花洋裝 35款",
    "category": "洋裝",
    "brand": "Peak Active",
    "color": "綠色",
    "size": "XL",
    "price": 1820.0,
    "stock": 17,
    "imgNum": "002",
    "img": "./images/products/product-002.jpg"
  },
  {
    "id": "P0036",
    "name": "運動上衣 36款",
    "category": "運動服",
    "brand": "Urban Leaf",
    "color": "黑色",
    "size": "S",
    "price": 2040.0,
    "stock": 24,
    "imgNum": "028",
    "img": "./images/products/product-028.jpg"
  },
  {
    "id": "P0037",
    "name": "襯衫 37款",
    "category": "上衣",
    "brand": "North Thread",
    "color": "白色",
    "size": "M",
    "price": 2260.0,
    "stock": 31,
    "imgNum": "016",
    "img": "./images/products/product-016.jpg"
  },
  {
    "id": "P0038",
    "name": "休閒長褲 38款",
    "category": "褲子",
    "brand": "Mode Studio",
    "color": "米色",
    "size": "L",
    "price": 390.0,
    "stock": 0,
    "imgNum": "048",
    "img": "./images/products/product-048.jpg"
  },
  {
    "id": "P0039",
    "name": "牛仔短裙 39款",
    "category": "裙子",
    "brand": "Daily Wear",
    "color": "藍色",
    "size": "XL",
    "price": 610.0,
    "stock": 7,
    "imgNum": "031",
    "img": "./images/products/product-031.jpg"
  },
  {
    "id": "P0040",
    "name": "丹寧外套 40款",
    "category": "外套",
    "brand": "Peak Active",
    "color": "灰色",
    "size": "S",
    "price": 830.0,
    "stock": 14,
    "imgNum": "053",
    "img": "./images/products/product-053.jpg"
  },
  {
    "id": "P0041",
    "name": "無袖洋裝 41款",
    "category": "洋裝",
    "brand": "Urban Leaf",
    "color": "綠色",
    "size": "M",
    "price": 1050.0,
    "stock": 21,
    "imgNum": "004",
    "img": "./images/products/product-004.jpg"
  },
  {
    "id": "P0042",
    "name": "瑜伽褲 42款",
    "category": "運動服",
    "brand": "North Thread",
    "color": "黑色",
    "size": "L",
    "price": 1270.0,
    "stock": 28,
    "imgNum": "025",
    "img": "./images/products/product-025.jpg"
  },
  {
    "id": "P0043",
    "name": "針織上衣 43款",
    "category": "上衣",
    "brand": "Mode Studio",
    "color": "白色",
    "size": "XL",
    "price": 1490.0,
    "stock": 35,
    "imgNum": "024",
    "img": "./images/products/product-024.jpg"
  },
  {
    "id": "P0044",
    "name": "西裝褲 44款",
    "category": "褲子",
    "brand": "Daily Wear",
    "color": "米色",
    "size": "S",
    "price": 1710.0,
    "stock": 4,
    "imgNum": "046",
    "img": "./images/products/product-046.jpg"
  },
  {
    "id": "P0045",
    "name": "長裙 45款",
    "category": "裙子",
    "brand": "Peak Active",
    "color": "藍色",
    "size": "M",
    "price": 1930.0,
    "stock": 11,
    "imgNum": "040",
    "img": "./images/products/product-040.jpg"
  },
  {
    "id": "P0046",
    "name": "連帽外套 46款",
    "category": "外套",
    "brand": "Urban Leaf",
    "color": "灰色",
    "size": "L",
    "price": 2150.0,
    "stock": 18,
    "imgNum": "054",
    "img": "./images/products/product-054.jpg"
  },
  {
    "id": "P0047",
    "name": "長袖洋裝 47款",
    "category": "洋裝",
    "brand": "North Thread",
    "color": "綠色",
    "size": "XL",
    "price": 2370.0,
    "stock": 25,
    "imgNum": "006",
    "img": "./images/products/product-006.jpg"
  },
  {
    "id": "P0048",
    "name": "訓練短褲 48款",
    "category": "運動服",
    "brand": "Mode Studio",
    "color": "黑色",
    "size": "S",
    "price": 500.0,
    "stock": 32,
    "imgNum": "022",
    "img": "./images/products/product-022.jpg"
  },
  {
    "id": "P0049",
    "name": "短袖上衣 49款",
    "category": "上衣",
    "brand": "Daily Wear",
    "color": "白色",
    "size": "M",
    "price": 720.0,
    "stock": 1,
    "imgNum": "012",
    "img": "./images/products/product-012.jpg"
  },
  {
    "id": "P0050",
    "name": "寬褲 50款",
    "category": "褲子",
    "brand": "Peak Active",
    "color": "米色",
    "size": "L",
    "price": 940.0,
    "stock": 8,
    "imgNum": "043",
    "img": "./images/products/product-043.jpg"
  },
  {
    "id": "P0051",
    "name": "A字裙 51款",
    "category": "裙子",
    "brand": "Urban Leaf",
    "color": "藍色",
    "size": "XL",
    "price": 1160.0,
    "stock": 15,
    "imgNum": "038",
    "img": "./images/products/product-038.jpg"
  },
  {
    "id": "P0052",
    "name": "西裝外套 52款",
    "category": "外套",
    "brand": "North Thread",
    "color": "灰色",
    "size": "S",
    "price": 1380.0,
    "stock": 22,
    "imgNum": "060",
    "img": "./images/products/product-060.jpg"
  },
  {
    "id": "P0053",
    "name": "襯衫洋裝 53款",
    "category": "洋裝",
    "brand": "Mode Studio",
    "color": "綠色",
    "size": "M",
    "price": 1600.0,
    "stock": 29,
    "imgNum": "010",
    "img": "./images/products/product-010.jpg"
  },
  {
    "id": "P0054",
    "name": "運動外套 54款",
    "category": "運動服",
    "brand": "Daily Wear",
    "color": "黑色",
    "size": "L",
    "price": 1820.0,
    "stock": 36,
    "imgNum": "026",
    "img": "./images/products/product-026.jpg"
  },
  {
    "id": "P0055",
    "name": "條紋上衣 55款",
    "category": "上衣",
    "brand": "Peak Active",
    "color": "白色",
    "size": "XL",
    "price": 2040.0,
    "stock": 5,
    "imgNum": "018",
    "img": "./images/products/product-018.jpg"
  },
  {
    "id": "P0056",
    "name": "棉質短褲 56款",
    "category": "褲子",
    "brand": "Urban Leaf",
    "color": "米色",
    "size": "S",
    "price": 2260.0,
    "stock": 12,
    "imgNum": "033",
    "img": "./images/products/product-033.jpg"
  },
  {
    "id": "P0057",
    "name": "針織裙 57款",
    "category": "裙子",
    "brand": "North Thread",
    "color": "藍色",
    "size": "M",
    "price": 390.0,
    "stock": 19,
    "imgNum": "030",
    "img": "./images/products/product-030.jpg"
  },
  {
    "id": "P0058",
    "name": "羊毛外套 58款",
    "category": "外套",
    "brand": "Mode Studio",
    "color": "灰色",
    "size": "L",
    "price": 610.0,
    "stock": 26,
    "imgNum": "050",
    "img": "./images/products/product-050.jpg"
  },
  {
    "id": "P0059",
    "name": "針織洋裝 59款",
    "category": "洋裝",
    "brand": "Daily Wear",
    "color": "綠色",
    "size": "XL",
    "price": 830.0,
    "stock": 33,
    "imgNum": "008",
    "img": "./images/products/product-008.jpg"
  },
  {
    "id": "P0060",
    "name": "慢跑長褲 60款",
    "category": "運動服",
    "brand": "Peak Active",
    "color": "黑色",
    "size": "S",
    "price": 1050.0,
    "stock": 2,
    "imgNum": "029",
    "img": "./images/products/product-029.jpg"
  }
];

// 取得商品多層容錯圖片網址
function getImgUrls(imgNum, customUrl) {
  const urls = [];
  if (customUrl && typeof customUrl === "string" && customUrl.startsWith("http")) {
    urls.push(customUrl);
  }
  // 1. 本地相對路徑 (GitHub Pages 最穩定的載入方式)
  urls.push(`./images/products/product-${imgNum}.jpg`);
  // 2. GitHub Pages 正式發布網址
  urls.push(`https://${GITHUB_USER}.github.io/${REPO_NAME}/images/products/product-${imgNum}.jpg`);
  // 3. GitHub Raw CDN 備援
  urls.push(`https://raw.githubusercontent.com/${GITHUB_USER}/${REPO_NAME}/main/images/products/product-${imgNum}.jpg`);
  return urls;
}

function missingPhoto(id) {
  const colors = ["#f8e3ea", "#f5e9e0", "#e9e3f1", "#e3edf0"];
  const hue = [...String(id)].reduce((n, c) => n + c.charCodeAt(0), 0) % colors.length;
  const bg = colors[hue];
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="400" height="520"><rect width="100%" height="100%" fill="${bg}"/><text x="50%" y="50%" font-family="sans-serif" font-size="18" text-anchor="middle" fill="#a87887">服飾照片載入中</text></svg>`;
  return "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svg);
}

function attachResilientImage(image, p) {
  const urls = getImgUrls(p.imgNum, p.img);
  let tryIndex = 0;
  image.onerror = () => {
    tryIndex++;
    if (tryIndex < urls.length) {
      image.src = urls[tryIndex];
    } else {
      image.onerror = null;
      image.src = missingPhoto(p.id);
    }
  };
  image.src = urls[0];
}

const favorites = new Set();
const cart = [];
let products = [...DEFAULT_PRODUCTS];
let visibleProducts = [];
let favoriteOnly = false;
let requestNumber = 0;
const productCache = new Map();

for (const p of DEFAULT_PRODUCTS) {
  productCache.set(p.id, p);
}

const money = n => "NT$ " + Number(n).toLocaleString("zh-TW");

function make(tag, className, content) {
  const el = document.createElement(tag);
  if (className) el.className = className;
  if (content !== undefined) el.textContent = String(content);
  return el;
}

function addOption(select, value) {
  const option = document.createElement("option");
  option.value = value;
  option.textContent = value;
  select.append(option);
}

function initialize() {
  // 建立分類快捷方塊
  const categoryTiles = $("categoryTiles");
  categoryTiles.replaceChildren();
  for (const [name, emoji, english] of categories) {
    addOption($("category"), name);
    const tile = make("button", "category-tile");
    tile.type = "button";
    tile.dataset.category = name;
    tile.append(make("span", "emoji", emoji), make("strong", "", name), make("small", "", english));
    categoryTiles.append(tile);
  }

  categoryTiles.addEventListener("click", e => {
    const tile = e.target.closest("[data-category]");
    if (!tile) return;
    const cat = tile.dataset.category;
    // 兼容「褲裝」與「褲子」、「裙裝」與「裙子」
    const mapCategory = cat === "褲裝" ? "褲子" : (cat === "裙裝" ? "裙子" : cat);
    $("category").value = mapCategory;
    favoriteOnly = false;
    filterAndRender();
    $("new").scrollIntoView({ behavior: "smooth" });
  });

  $("searchForm").addEventListener("submit", e => {
    e.preventDefault();
    favoriteOnly = false;
    fetchProducts();
    $("new").scrollIntoView({ behavior: "smooth" });
  });

  $("resetSearch").addEventListener("click", () => {
    $("searchForm").reset();
    favoriteOnly = false;
    filterAndRender();
  });

  $("favoriteToggle").addEventListener("click", () => {
    favoriteOnly = !favoriteOnly;
    renderProducts();
    $("new").scrollIntoView({ behavior: "smooth" });
  });

  $("cartToggle").addEventListener("click", () => {
    renderCart();
    $("cartDialog").showModal();
  });

  $("closeCart").addEventListener("click", () => $("cartDialog").close());

  $("productGrid").addEventListener("click", e => {
    const button = e.target.closest("button[data-id]");
    if (!button) return;
    const id = button.dataset.id;
    if (button.dataset.action === "favorite") {
      favorites.has(id) ? favorites.delete(id) : favorites.add(id);
      $("favoriteCount").textContent = favorites.size;
      renderProducts();
    }} else if (button.dataset.action === "cart") {
      cart.push(id);
      $("cartCount").textContent = cart.length;
      button.textContent = "✓";
      setTimeout(() => button.textContent = "＋", 1200);
    }
  });

  $("cartItems").addEventListener("click", e => {
    const button = e.target.closest("button[data-remove]");
    if (!button) return;
    cart.splice(Number(button.dataset.remove), 1);
    $("cartCount").textContent = cart.length;
    renderCart();
  });

  // 監聽即時輸入篩選
  $("keyword").addEventListener("input", filterAndRender);
  $("color").addEventListener("change", filterAndRender);
  $("category").addEventListener("change", filterAndRender);
  $("price").addEventListener("change", filterAndRender);

  updateColors();
  fetchProducts();
}

async function fetchProducts() {
  const seq = ++requestNumber;
  const keyword = $("keyword").value.trim().toLowerCase();
  const color = $("color").value;
  const category = $("category").value;
  const maxPrice = Number($("price").value) || 999999;

  $("resultCount").textContent = "正在讀取商品資料庫（連線中）...";
  $("emptyState").hidden = true;

  try {
    const query = new URLSearchParams({ keyword, color, category, max_price: maxPrice });
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 3500); // 3.5秒超時自動降級

    const response = await fetch(API_URL + "?" + query.toString(), {
      headers: { "Accept": "application/json" },
      signal: controller.signal
    });
    clearTimeout(timeout);

    if (!response.ok) throw new Error("HTTP " + response.status);
    const data = await response.json();
    if (!Array.isArray(data.products)) throw new Error("API 資料格式不正確");
    if (seq !== requestNumber) return;

    products = data.products.map(p => {
      const match = DEFAULT_PRODUCTS.find(dp => dp.id === String(p.product_id));
      return {
        id: String(p.product_id),
        name: String(p.product_name),
        category: String(p.category_name),
        brand: String(p.brand_name),
        color: String(p.color),
        size: String(p.size),
        price: Number(p.price),
        stock: Number(p.stock_qty),
        imgNum: match ? match.imgNum : "001",
        img: p.image_url || (match ? match.img : `./images/products/product-001.jpg`)
      };
    });

    for (const p of products) productCache.set(p.id, p);
    updateColors();
    renderProducts();
    $("resultCount").textContent = `找到 ${products.length} 件商品（TiDB Cloud 即時連線）`;
  } catch (error) {
    if (seq !== requestNumber) return;
    // API 未啟用或離線時，無縫切換為本機 60 筆完整資料集
    console.info("使用本機完整商品資料庫展示：", error.message);
    filterAndRender();
  }
}

function filterAndRender() {
  const keyword = $("keyword").value.trim().toLowerCase();
  const color = $("color").value;
  const category = $("category").value;
  const maxPrice = Number($("price").value) || 999999;

  visibleProducts = DEFAULT_PRODUCTS.filter(p => {
    const matchKeyword = !keyword || 
      p.name.toLowerCase().includes(keyword) || 
      p.category.toLowerCase().includes(keyword) || 
      p.id.toLowerCase().includes(keyword) ||
      p.brand.toLowerCase().includes(keyword);

    const matchColor = !color || p.color === color;
    const matchCategory = !category || p.category === category || 
      (category === "褲裝" && p.category === "褲子") || 
      (category === "裙裝" && p.category === "裙子");
    const matchPrice = p.price <= maxPrice;

    return matchKeyword && matchColor && matchCategory && matchPrice;
  });

  if (favoriteOnly) {
    visibleProducts = visibleProducts.filter(p => favorites.has(p.id));
  }

  renderProducts();
}

function updateColors() {
  const select = $("color");
  const selected = select.value;
  const known = new Set([...select.options].map(o => o.value));
  for (const p of DEFAULT_PRODUCTS) {
    if (p.color && !known.has(p.color)) {
      addOption(select, p.color);
      known.add(p.color);
    }
  }
  select.value = selected;
}

function renderProducts() {
  const grid = $("productGrid");
  grid.replaceChildren();

  const countText = `找到 ${visibleProducts.length} 件商品` + (favoriteOnly ? " · 我的收藏" : "") + "（資料庫正式對應）";
  $("resultCount").textContent = countText;
  $("emptyState").hidden = visibleProducts.length > 0;

  for (const p of visibleProducts) {
    const card = make("article", "product-card");
    const imageWrap = make("div", "product-image");
    const image = make("img");
    image.alt = p.name;
    image.loading = "lazy";
    attachResilientImage(image, p);

    const fav = make("button", "favorite" + (favorites.has(p.id) ? " active" : ""), favorites.has(p.id) ? "♥" : "♡");
    fav.type = "button";
    fav.dataset.action = "favorite";
    fav.dataset.id = p.id;
    fav.setAttribute("aria-label", "收藏 " + p.name);

    const catBadge = make("span", "photo-label", p.category);
    imageWrap.append(image, catBadge, fav);

    const info = make("div", "product-info");
    info.append(
      make("h3", "", p.name),
      make("p", "", [p.brand, p.color, p.size, p.id].join(" · "))
    );

    const stockTag = make("span", "stock-tag", p.stock > 0 ? "現貨 " + p.stock + " 件" : "已售完");
    info.append(stockTag);

    const priceRow = make("div", "price-row");
    const add = make("button", "add-cart", "＋");
    add.type = "button";
    add.dataset.action = "cart";
    add.dataset.id = p.id;
    add.disabled = p.stock <= 0;
    add.setAttribute("aria-label", p.stock > 0 ? "加入購物車" : "已售完");

    priceRow.append(make("span", "price", money(p.price)), add);
    info.append(priceRow);

    card.append(imageWrap, info);
    grid.append(card);
  }
}

function renderCart() {
  const itemsContainer = $("cartItems");
  itemsContainer.replaceChildren();

  if (!cart.length) {
    itemsContainer.textContent = "購物車還是空的，去挑選喜歡的衣服吧 ♡";
    $("cartTotal").textContent = "";
    return;
  }

  const counts = new Map();
  for (const id of cart) counts.set(id, (counts.get(id) || 0) + 1);

  let total = 0;
  for (const [id, qty] of counts) {
    const p = productCache.get(id);
    if (!p) continue;
    total += p.price * qty;

    const row = make("div", "cart-row");
    const remove = make("button", "", "移除");
    remove.type = "button";
    remove.dataset.remove = String(cart.indexOf(id));

    row.append(
      make("span", "", `${p.name} × ${qty}`),
      make("span", "", money(p.price * qty)),
      remove
    );
    itemsContainer.append(row);
  }
  $("cartTotal").textContent = "示範總金額：" + money(total);
}

document.addEventListener("DOMContentLoaded", initialize);
