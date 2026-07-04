# 🛍️ ShopEasy: Premium E-Commerce App Template


A premium, fluid, and state-of-the-art E-Commerce application template built using Flutter, modern Material 3 design, and an offline-first SQLite persistence engine.


**ShopEasy** features a curated, harmonious visual architecture with seamless page transitions, interactive detail widgets, and a fully production-ready localized checkout calculation engine.


---


## 🎨 Design & Aesthetic Excellence


ShopEasy is meticulously crafted to wow users at first glance, incorporating premium modern UI/UX design paradigms:

* **Material 3 Engine:** Leverages the latest Material Design specifications, featuring dynamic color matching, responsive grids, and elegant, fluid bottom sheets.
* **Micro-Animations:** Fluid interactive hover states, bouncy spring-based detail expansions, and responsive transitions that feel alive.
* **AMOLED Optimized Mode:** Curated dark modes and high-contrast color palettes (using sophisticated HSL systems rather than plain browser defaults) to make your screen pop.
* **Responsive Image Carousels:** High-fidelity product displays with interactive pagination indicator dots, swipe gestures, and soft parallax effects.


---


## ✨ Key Features & User Guide


### 🛒 Persistent Shopping Cart

* **SQLite-Backed Persistence:** Ensures the user's cart is fully saved on-device and persists perfectly between app launches.
* **Composite Key Increments:** Automatically groups duplicates by product specifications (e.g., specific sizes, colors) with reactive quantity controllers.
* **🔍 How to Access & Use:**
  1. Browse the home page catalog and tap on any product card (e.g., "Premium Leather Jacket") to view its details.
  2. Select your desired specifications (Size, Color, Quantity) and tap **Add to Cart**.
  3. The Cart Badge on the bottom navigation bar will instantly increment.
  4. Tap the **Cart** icon in the bottom menu to open the Shopping Cart drawer.
  5. Adjust individual item quantities using the `+` and `-` buttons. The subtotal, tax, shipping, and total amounts will instantly re-calculate with beautiful text animations.
  6. To delete an item from the cart, tap the **Trash** icon or swipe left on the cart card.


### 💖 Interactive Wishlist

* **One-Tap Bookmarking:** Tap the animated floating heart icon to instantly bookmark products to the offline wishlist database.
* **Dynamic Badges:** Emits instant state notifications using `ChangeNotifier` to update badge counts on the bottom navigation bar without layout rebuilds.
* **🔍 How to Access & Use:**
  1. When browsing products, tap the **Heart Icon** in the top right corner of any product card.
  2. The icon will fill with a vibrant crimson color, indicating it has been added to your favorites list.
  3. Access your favorites list by tapping the **Wishlist** tab from the bottom navigation bar.
  4. Inside your Wishlist, you can view all saved items. Tap any item to view its details or add it directly to your shopping cart.
  5. To remove an item from your favorites, tap the crimson heart icon again.


### 🏷️ Intelligent Discount & Checkout Engine

* **Mathematical Coupon Verification:** Easily apply promotional vouchers to get dynamic percentage discounts.
* **Smart Order Calculation:** Handles local states, taxes, shipping fees, and active promotional vouchers.
* **🔍 How to Access & Use:**
  1. Open your **Shopping Cart**.
  2. Locate the **Promo Code** text field under the cart ledger.
  3. Enter one of the following active promotional vouchers:
     
     | Voucher Code | Discount Applied | Minimum Spend |
     |---|---|---|
     | **FLUTTER10** | 10% Off Entire Cart | No Minimum |
     | **WELCOME15** | 15% Off Entire Cart | $50.00 |
     | **SUPER20** | 20% Off Entire Cart | $100.00 |
     
  4. Tap **Apply**. The checkout engine will verify your eligibility (minimum spend thresholds), apply the discount, compute a flat 5% sales tax, and output your final price.
  5. **Free Shipping Threshold:** Note that standard shipping ($15.00) is automatically waived if your cart subtotal exceeds **$150.00**!


---


## 🏗️ Architectural Blueprint


The SQLite database and promotional engine follow a strict, decoupled **Clean Architecture** layout under `lib/features/shopping_cart/`:

```
lib/features/shopping_cart/
├── domain/
│   ├── models/           # Pure, immutable CartItem, WishlistItem, and Coupon entities
│   └── repositories/     # Repository contracts defining SQLite transactions and voucher matches
├── data/
│   ├── datasources/      # Concrete raw SQL query helpers and database migration triggers
│   └── repositories/     # SQLite database repository implementations bridging domain contracts
└── presentation/
    ├── controllers/      # CartController & WishlistController (ChangeNotifier) updating UI elements
    ├── pages/            # Curated Shopping Cart and Wishlist overlay views
    └── widgets/          # Checkout summary cards, voucher input blocks, and custom badges
```


---


## 🛠️ Developer Setup & Guidelines


### Requirements
* **Flutter SDK:** Latest Stable Channel
* **Dart SDK:** Latest Stable Channel


### Step-by-Step Installation

1. Navigate to the project directory:
   ```bash
   cd ShopEasy
   ```

2. Retrieve required package dependencies:
   ```bash
   git submodule update --init --recursive
   flutter pub get
   ```

3. Verify static code quality:
   ```bash
   flutter analyze
   ```

4. Build a pristine production release APK:
   ```bash
   flutter build apk --release
   ```


---


## 🙏 Acknowledgements & Attribution


We would like to express our sincere gratitude to the original creators and maintainers of the original [abuanwar072/E-commerce-Complete-Flutter-UI](https://github.com/abuanwar072/E-commerce-Complete-Flutter-UI) repository, which served as the foundation of this work.


> [!NOTE]
> This repository represents an **extensive, premium upgrade** from the original codebase. It introduces a modernized responsive Material 3 layout, high-performance SQLite-backed cart and wishlist persistence engines, and an advanced checkout discount coupon verification suite following strict S.O.L.I.D. Clean Architecture standards.


---


## 📄 License & Open-Source


**ShopEasy** is open-source software licensed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information. Contributions and Pull Requests are welcome!
