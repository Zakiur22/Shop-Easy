# 🛍️ ShopEasy: Premium E-Commerce App Template


A premium, fluid, and state-of-the-art E-Commerce application template built using Flutter, modern Material 3 design, and an offline-first SQLite persistence engine.


<p align="center">
  <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&q=80" alt="ShopEasy Apparel Banner" width="100%" style="border-radius: 8px;" />
</p>


<p align="center">
  <img src="readme image/Build you shop app in days.png" alt="Build Your Shop App in Days Banner" style="width: 500px; height: auto; border-radius: 8px;" />
</p>


**ShopEasy** features a curated, harmonious visual architecture with seamless page transitions, interactive detail widgets, and a fully production-ready localized checkout calculation engine.


<p align="center">
  <img src="readme image/Device_frame.png" alt="ShopEasy Device Frame Mockup" style="width: 100%; height: auto; border-radius: 8px;" />
</p>


---


## 🚀 Technical Stack & Architecture


This project is built using professional, scalable, and robust development technologies.


### 🛠️ Core Technology Stack

* **Framework:** Flutter SDK (Latest Stable Channel) & Dart (Latest Stable Channel)
* **State Management:** ChangeNotifier and Provider State Patterns (`provider` package for modular state updates)
* **Local Persistence:** SQLite Database (`sqflite` package) for managing on-device cart rows and wishlist structures.
* **Layout Specification:** Complete Material 3 adaptation including responsive card systems, modern drawers, and custom navigation matrices.
* **Mathematical Engines:** Customized rounding algorithms and double-precision tax/shipping calculation models.


### 🏗️ Architecture & Folder Structure

The application isolates functional layers cleanly. The persistent shopping cart and coupon voucher engines follow a strict **Clean Architecture** directory design, isolating pure business entities from layout states:

```
lib/
├── features/
│   └── shopping_cart/            # Clean Architecture Shopping Cart Module
│       ├── domain/
│       │   ├── models/           # Pure, immutable CartItem, WishlistItem, and Coupon entities
│       │   └── repositories/     # Repository contracts defining SQLite transactions and voucher matches
│       ├── data/
│       │   ├── datasources/      # Concrete raw SQL query helpers and database migration triggers
│       │   └── repositories/     # SQLite database repository implementations bridging domain contracts
│       └── presentation/
│           ├── controllers/      # CartController & WishlistController (ChangeNotifier) updating UI elements
│           ├── pages/            # Curated Shopping Cart and Wishlist overlay views
│           └── widgets/          # Checkout summary cards, voucher input blocks, and custom badges
├── components/                   # Curated layout containers
├── constants/                    # Standardized HSL color tokens and UI dimension scales
├── screens/                      # Legacy Catalog, Product Details, and Home layouts
└── main.dart                     # Main entrypoint establishing SQLite files and active ChangeNotifier providers
```


---


## 🛠️ Software Coding & Clean Code Principles


To ensure high quality, maintainability, and clean code standards, we applied rigorous software principles:

* **S.O.L.I.D. Architectural Guidelines:**
  * **Single Responsibility (SRP):** The `Coupon` validator entity strictly parses and checks coupon thresholds; it does not display error alerts or affect database logs.
  * **Open/Closed (OCP):** Easily add brand new promotional voucher calculations without altering the underlying Checkout controller class.
  * **Liskov Substitution (LSP):** Base repository interfaces support seamless mocking during checkout unit tests.
  * **Interface Segregation (ISP):** Keeping checkout computations isolated from general catalogue configurations.
  * **Dependency Inversion (DIP):** UI Widgets communicate exclusively with abstract providers, resolving dependency implementations dynamically.
* **DRY (Don't Repeat Yourself):** Highly reusable image carousels, custom item badges, and product cards are extracted into central components.
* **Separation of Concerns:** Loose coupling between visual state elements and hardware persistence databases.
* **Type Safety & Precision:** Strictly avoids floats for currency calculations, utilizing double-precision models to safeguard checkout values against rounding issues.


---


## ✨ Extensive Features & Subfeatures Guide


### 🛒 Persistent Shopping Cart

* **SQLite-Backed Persistence:** 
  Ensures the user's cart is fully saved on-device and persists perfectly between app launches.
* **Composite Key Increments:** 
  Automatically groups duplicates by product specifications (e.g., specific sizes, colors) with reactive quantity controllers.
* **🔍 How to Access & Use:**
  1. Browse the home page catalog and tap on any product card (e.g., "Premium Leather Jacket") to view its details.
  2. Select your desired specifications (Size, Color, Quantity) and tap **Add to Cart**.
  3. The Cart Badge on the bottom navigation bar will instantly increment.
  4. Tap the **Cart** icon in the bottom menu to open the Shopping Cart drawer.
  5. Adjust individual item quantities using the `+` and `-` buttons. The subtotal, tax, shipping, and total amounts will instantly re-calculate with beautiful text animations.
  6. To delete an item from the cart, tap the **Trash** icon or swipe left on the cart card.


### 💖 Interactive Wishlist

* **One-Tap Bookmarking:** 
  Tap the animated floating heart icon to instantly bookmark products to the offline wishlist database.
* **Dynamic Badges:** 
  Emits instant state notifications using `ChangeNotifier` to update badge counts on the bottom navigation bar without layout rebuilds.
* **🔍 How to Access & Use:**
  1. When browsing products, tap the **Heart Icon** in the top right corner of any product card.
  2. The icon will fill with a vibrant crimson color, indicating it has been added to your favorites list.
  3. Access your favorites list by tapping the **Wishlist** tab from the bottom navigation bar.
  4. Inside your Wishlist, you can view all saved items. Tap any item to view its details or add it directly to your shopping cart.
  5. To remove an item from your favorites, tap the crimson heart icon again.


### 🏷️ Intelligent Discount & Checkout Engine

* **Mathematical Coupon Verification:** 
  Easily apply promotional vouchers to get dynamic percentage discounts.
* **Smart Order Calculation:** 
  Handles local states, taxes, shipping fees, and active promotional vouchers.
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
> We have extensively worked on their original codebase, refactored the underlying logic, updated legacy dependencies, resolved complex build and runtime errors, and introduced many advanced modern enhancements. These upgrades include an interactive Checkout Coupon Verification Engine and SQLite Shopping Cart persistence pipeline built following strict Clean Architecture guidelines, a state-notifying Wishlist sync with badge updates, and elegant Material 3 parallax product details layouts to create a highly optimized, state-of-the-art, and production-ready portfolio application.


---


## 📄 License & Open-Source


**ShopEasy** is open-source software licensed under the **MIT License**. Refer to the [LICENSE](LICENSE) file for more information. Contributions and Pull Requests are welcome!
