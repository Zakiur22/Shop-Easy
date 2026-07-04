# 🛍️ ShopEasy: Premium E-Commerce App Template

A premium, fluid, and state-of-the-art E-Commerce application template built using Flutter, modern Material 3 design, and an offline-first SQLite persistence engine.

<p align="center">
  <b>ShopEasy</b> features a curated, harmonious visual architecture with seamless page transitions, interactive detail widgets, and a fully production-ready localized checkout calculation engine.
</p>

---

## 🎨 Design & Aesthetic Excellence

ShopEasy is meticulously crafted to wow users at first glance, incorporating premium modern UI/UX design paradigms:
* **Material 3 Engine:** Leverages the latest Material Design specifications, featuring color matching, responsive layouts, and modern bottom sheets.
* **Micro-Animations:** Fluid interactive hover states, dynamic detail expansion elements, and spring-based reactive transitions.
* **AMOLED Optimized Mode:** Curated dark modes and high-contrast color palettes (using sophisticated HSL systems rather than browser defaults).
* **Responsive Image Carousels:** High-fidelity product displays with interactive pagination indicator dots and parallax effects.

---

## ✨ Features at a Glance

### 🛒 Persistent Shopping Cart
* **Composite Key Increments:** Automatically groups duplicates by product specifications (e.g., specific sizes/colors) with reactive quantity controls.
* **SQLite-Backed Persistence:** Ensures the user's cart is fully saved on-device and persists between app sessions.

### 💖 Interactive Wishlist
* **One-Tap Bookmarking:** Tap the animated floating heart icon to instantly bookmark products to the offline wishlist database.
* **Dynamic Navigation Badges:** Emits instant state notifications using `ChangeNotifier` to update badge counts on the bottom navigation bar without layout rebuilds.

### 🏷️ Intelligent Discount & Checkout Engine [Phase 4 Update]
ShopEasy incorporates a robust, mathematical checkout calculator that handles local states, taxes, shipping, and active promotional vouchers:

| Voucher Code | Discount Applied | Minimum Spend |
|---|---|---|
| **FLUTTER10** | 10% Off Entire Cart | No Minimum |
| **WELCOME15** | 15% Off Entire Cart | $50.00 |
| **SUPER20** | 20% Off Entire Cart | $100.00 |

* **Free Shipping Threshold:** Standard shipping fee ($15.00) is automatically waived on order subtotals exceeding **$150.00**.
* **Tax Calculation:** Handles state/local sales tax (5% flat rate) computed dynamically over discounted order totals.

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

## 🛠️ Setup & Installation

### Requirements
* **Flutter SDK:** Latest Stable Channel
* **Dart SDK:** Latest Stable Channel

### Step-by-Step Run Guide
1. Clone the repository:
   ```bash
   git clone https://github.com/Zakiur22/Shop-Easy.git
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
4. Build the production release APK:
   ```bash
   flutter build apk --release
   ```

---

## 📄 License
ShopEasy is distributed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information.
Contributions and feature pull requests are highly welcomed!
