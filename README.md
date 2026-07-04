# Flutter E-Commerce App Template

<p align="center">
  <img src="readme%20image/Build%20you%20shop%20app%20in%20days.png" alt="Build you shop app in days" style="width: 500px; height: auto;">
</p>

<p align="center">
  The FlutterShop template makes it easier to develop an e-commerce app using Flutter. It includes all the necessary pages to build a shopping app for both Android and iOS using flutter.
</p>

<!-- Buttons -->
<p align="center">
  <a href="https://cutt.ly/fefxdqE9" style="text-decoration: none;" target="_blank">
    <img src="readme image/buy_now_btn.png" alt="Full template" style="margin-right: 32px; width: 170px; height: 50px;">
  </a>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <a href="https://cutt.ly/1efxdynN" style="text-decoration: none;" target="_blank">
    <img src="readme image/preview_btn.png" alt="Preview" style="width: 136px; height: 50px;">
  </a>
</p>

<!-- Device image -->
</br >
</br >
<p align="center">
  <img src="readme image/Device_frame.png" alt="Ecommerce app Home, product details page" style="width: 1100px; height: auto;">
</p>
</br >
</br >

This shop app template comes with 100+ screens. Some of these pages are Splash, Login, Signup, Home, Product, Search, Cart, Profile, Payment, Wallet, Order Tracking, and Order History. Additionally, all pages support both light and dark themes.You just need to connect the UI to your preferred backend, such as Firebase, WordPress, or your custom API. You can do anything you want with it.

<!-- Gif preview -->
</br >
</br >
<p align="center">
  <img src="readme image/FlutterShop_Intro.gif" alt="Build you shop app in days" style="width: 643px; height: auto;">
</p>
</br >
</br >

### Well organized project very easy to customize

![FlutterShop E-commerce Template Project Structure](https://public-files.gumroad.com/v1kbfvdugf3urvw03qrqgmc5pl1c)

<!-- Full preview -->
</br >
</br >
<p align="center">
  <img src="https://public-files.gumroad.com/m3v3lyyipbzczcws5gcuhpbkmczk" alt="Build you shop app in days" style="width: 100%; height: auto;">
</p>

### Loading is no longer boring [New update V1.1] [Doc](https://abu-anwar.gitbook.io/fluttershop-doc/custom-loading)

The progress indicator that comes with Flutter, by default is okay in most places, but not in every place. Especially when you build an ecommerce app. This is why we have created a custom loading effect that boosts your user engagement even during the loading process. This kind of loading is common in popular apps like YouTube and LinkedIn. It's a small detail, but it makes a big difference.
![FlutterShop Custom loading](https://public-files.gumroad.com/qqnmt9nu5677thkq1961tlwj405u)

## Screens on the FlutterShop E-commerce Template

As mentioned, this kit contains 100+ nicely crafted minimal screens that cover everything you need!👇

### Onboarding

- Onboarding Choose item
- Onboarding Add to cart
- Onboarding Pay online
- Onboarding Track order
- Onboarding Find store
- Notification permission
- Select language

### Authentication

- Log in
- Forgot password
  - Choose verification method
  - Verification code
- Set new password
- Done reset password
- Sign up
  - Setup profile
  - Verification code
- Successfully sign up
- Terms and conditions
- Enable fingerprint
- Enable face ID

### Product

- Product page
  - Notify when available (Out of stock)
  - Buy Now
  - Product details
  - Product reviews
  - Add review
  - Shipping methods
  - Product return policy
  - Product size guide
  - Store Pickup Availability
  - Added to cart message
  - Product gallery (Will be added soon)

### Main Page

- Home page
- On sales page
- Kids product page
- Brand page
- Discover Page (Categories)
  - Style 1
  - Style 2 (Will be added soon)
  - Style 3 (Will be added soon)
- Bookmark products page

### Search

- Recent search (Search history)
- Search suggestions
- Search filters
  - Size filter
  - Color filter
  - Brand filter
  - Price filter
  - Sort by
- Search results
  - Product not found

### Cart

- Products on Cart
- Empty cart
- Choose address
- Review & payment
- Checkout / Payment method
  - Select card
  - Pay with cash
  - Use credit
- Thanks for order
- Add new card
- Scan card (Will be added soon)

### Profile

- Account
  - Normal version
  - Pro version
  - Profile
    - Edit profile
  - Notifications
    - Empty notification
    - Enable notification
    - Notification options
  - Select Language
  - Addresses
    - Empty address
    - Add new address
  - Add number
    - Verification code
  - Selected location
  - Payment
    - Cards
    - Empty payment
  - Wallet
    - Empty Wallet
    - Wallet history
  - Help & Chat (Support)
    - Chat
  - Preferences

### Order

- Account Orders
  - Processing orders
    - Cancel order
  - Canceled orders
  - Delivered orders
  - Return orders (Will be added soon)
  - More screens added in that sector soon

### Return & Request (Will be added soon)

- Return order list
- Empty return order
- Return order
- Return detail

### Error & Permission

- Notification permission
- No notification
- Select language
- No internet
- Server error
- Location permissions
- No search result
- Empty order list
- No Address found
- Empty payment
- Empty wallet

and MORE!!!! 🤩

If you want to learn how to build ecommerce template on Flutter [watch the playlist on YouTube](https://youtube.com/playlist?list=PLxUBb2A_UUy8OlaNZpS2mfL8xpHcnd_Af), In the first video, we start by making a neat onboarding screen for our shopping app. This works on both Android and iOS because it's made with Flutter. In the next video, we tackle the 'Sign In' and 'Forgot Password' screens, adding some unique error messages. The third video covers the 'Sign Up' and OTP processes. The fourth one is fun – we create the main homepage. In the fifth, we dive into the product page, and in the sixth, we craft an order page with cool features like 'swipe to delete.' Finally, in the seventh video, we design the user profile page.

Visit FlutterLibrary.com to Download the [Flutter e-commerce app template](https://www.flutterlibrary.com/templates/e-commerce-app) & other templates, and components.



## 🚀 Offline Database & Advanced Discount Engine [New Update - Phase 4]

We have integrated a full-featured, persistent offline storage layer using SQLite (`sqflite`) and a dynamic business-logic checkout & coupon calculator. This implementation elevates the template from a static UI mockup into a fully operational, offline-first application, while strictly adhering to Clean Architecture principles.

### 🏗️ Clean Architecture File Map
The new module is encapsulated under `lib/features/cart_wishlist/` and separated into independent, testable layers:

```
lib/features/cart_wishlist/
├── domain/
│   ├── models/
│   │   ├── cart_item.dart              # Core domain representation of a cart item
│   │   └── wishlist_item.dart          # Core domain representation of a wishlist item
│   └── repositories/
│       └── cart_wishlist_repository.dart # Abstract contract for persistence operations
├── data/
│   ├── datasources/
│   │   └── cart_wishlist_local_datasource.dart # Direct SQLite raw query implementation
│   └── repositories/
│       └── cart_wishlist_repository_impl.dart # Bridge concrete repository implementation
└── presentation/
    └── controllers/
        └── cart_wishlist_controller.dart # Singleton ChangeNotifier managing cart, wishlist state, and checkout pricing
```

---

### 🗄️ SQLite Database Schema & Structure
The local database `shop_database.db` contains two highly optimized relational tables:

#### 1. Cart Table (`cart`)
Tracks item selections, quantities, tailored product options (color, size), and initial/discounted product pricing:
| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Auto-incrementing unique identifier |
| `title` | `TEXT` | `NOT_NULL` | Name of the product |
| `brand` | `TEXT` | `NOT_NULL` | Product brand |
| `image` | `TEXT` | `NOT_NULL` | Asset/network image path |
| `price` | `REAL` | `NOT_NULL` | Base price |
| `priceAfterDiscount` | `REAL` | `NULLABLE` | Promotional price if applicable |
| `discountPercent` | `INTEGER` | `NULLABLE` | Percentage discount |
| `selectedColor` | `INTEGER` | `NOT_NULL` | ARGB representation of user's selected color |
| `selectedSize` | `TEXT` | `NOT_NULL` | User's selected size string (e.g., "S", "M", "L") |
| `quantity` | `INTEGER` | `NOT_NULL` | Quantity added to cart (auto-increments if added again) |

#### 2. Wishlist Table (`wishlist`)
Tracks bookmarked products persistently:
| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Unique identifier |
| `title` | `TEXT` | `NOT_NULL UNIQUE` | Unique product name (ensures unique bookmarks) |
| `brand` | `TEXT` | `NOT_NULL` | Product brand |
| `image` | `TEXT` | `NOT_NULL` | Thumbnail image |
| `price` | `REAL` | `NOT_NULL` | Base price |
| `priceAfterDiscount` | `REAL` | `NULLABLE` | Promotional price if applicable |
| `discountPercent` | `INTEGER` | `NULLABLE` | Discount percentage |

---

### 💸 Dynamic Checkout & Coupon Engine
The presentation layer contains a highly reactive singleton `CartWishlistController` that manages Cart quantities and executes instant billing computations:

* **Dynamic Subtotal:** Sum of active cart items, automatically respecting promotional prices (`priceAfterDiscount`) where available:
  $$\text{Subtotal} = \sum (\text{Active Price} \times \text{Quantity})$$
* **Interactive Coupon Codes:** Users can key in standard coupons directly on the checkout screen:
  * `FLUTTER10` — Grants a flat **10%** discount on subtotal.
  * `WELCOME15` — Grants a flat **15%** discount on subtotal.
  * `SUPER20` — Grants a flat **20%** discount on subtotal.
* **Taxation Engine:** Applies a standard flat **5% tax** on the coupon-discounted total:
  $$\text{Tax} = (\text{Subtotal} - \text{Discount}) \times 0.05$$
* **Intelligent Shipping Fee:**
  * Free shipping automatically triggers if the pre-discounted subtotal exceeds **$150.00**.
  * Otherwise, a standard **$15.00** shipping fee is charged.
* **Grand Total Formulation:**
  $$\text{Grand Total} = \text{Subtotal} - \text{Coupon Discount} + \text{Tax} + \text{Shipping Fee}$$

---

### 🔄 Dynamic Reactive State Triggers
All checkout-related visual elements are tied directly to the `CartWishlistController`'s state changes using highly efficient Flutter `ListenableBuilder`s instead of rebuilding the entire page hierarchy:
1. **Navigation Badges:** The bottom navigation bar tracks cart count (sum of all quantities) and wishlist count, displaying floating notification badges dynamically over the icons.
2. **Product Detail Syncing:** Adds instant database integration to "Add to Cart" and the heart icon. Detail screens dynamically toggle the icon's filled/outlined appearance depending on local database state.
3. **Responsive Empty Views:** Empty cart/bookmark screens immediately display modern, descriptive placeholder views if local query arrays return empty, and dynamically morph into interactive checkout grids as soon as items are saved.

</br >
</br >
<!-- Buttons -->
<p align="center">
  <a href="https://app.gumroad.com/checkout?product=uxznc&option=B3wWhE6QH46cfm31C7jEmQ%3D%3D&quantity=1&referrer=https://github.com" style="text-decoration: none;" target="_blank">
    <img src="readme image/buy_now_btn.png" alt="Full template" style="margin-right: 32px; width: 170px; height: 50px;">
  </a>
</p>
