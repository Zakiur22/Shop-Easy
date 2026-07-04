import 'package:flutter/material.dart';
import '../../domain/models/cart_item.dart';
import '../../domain/models/wishlist_item.dart';
import '../../domain/repositories/cart_wishlist_repository.dart';
import '../../data/repositories/cart_wishlist_repository_impl.dart';

class CartWishlistController extends ChangeNotifier {
  static final CartWishlistController instance = CartWishlistController._internal();

  final CartWishlistRepository _repository;

  List<CartItem> _cartItems = [];
  List<WishlistItem> _wishlistItems = [];
  bool _isLoading = false;
  String _activeCoupon = "";
  double _couponDiscountPercent = 0.0;

  CartWishlistController._internal({CartWishlistRepository? repository})
      : _repository = repository ?? CartWishlistRepositoryImpl() {
    loadData();
  }

  // Getters
  List<CartItem> get cartItems => _cartItems;
  List<WishlistItem> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;
  String get activeCoupon => _activeCoupon;
  double get couponDiscountPercent => _couponDiscountPercent;

  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  int get wishlistCount => _wishlistItems.length;

  // --- DISCOUNT & PRICING ENGINE ---

  double get subtotal => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get couponDiscountAmount => subtotal * _couponDiscountPercent;

  double get taxAmount => (subtotal - couponDiscountAmount) * 0.05; // 5% flat tax

  double get shippingFee {
    if (_cartItems.isEmpty) return 0.0;
    return subtotal > 150.0 ? 0.0 : 15.0; // Free shipping over $150
  }

  double get grandTotal {
    if (_cartItems.isEmpty) return 0.0;
    final total = subtotal - couponDiscountAmount + taxAmount + shippingFee;
    return total < 0.0 ? 0.0 : total;
  }

  // --- ACTIONS ---

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _repository.getCartItems();
      _wishlistItems = await _repository.getWishlistItems();
    } catch (e) {
      debugPrint("Error loading data from database: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart({
    required String title,
    required String brand,
    required String image,
    required double price,
    double? priceAfterDiscount,
    int? discountPercent,
    required int color,
    required String size,
    int quantity = 1,
  }) async {
    final item = CartItem(
      title: title,
      brand: brand,
      image: image,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discountPercent: discountPercent,
      selectedColor: color,
      selectedSize: size,
      quantity: quantity,
    );

    try {
      await _repository.addToCart(item);
      _cartItems = await _repository.getCartItems();
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding to cart: $e");
    }
  }

  Future<void> updateCartQuantity(int id, int quantity) async {
    try {
      await _repository.updateCartItemQuantity(id, quantity);
      _cartItems = await _repository.getCartItems();
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating cart item: $e");
    }
  }

  Future<void> removeFromCart(int id) async {
    try {
      await _repository.removeFromCart(id);
      _cartItems = await _repository.getCartItems();
      notifyListeners();
    } catch (e) {
      debugPrint("Error removing from cart: $e");
    }
  }

  Future<void> clearCart() async {
    try {
      await _repository.clearCart();
      _cartItems = [];
      _activeCoupon = "";
      _couponDiscountPercent = 0.0;
      notifyListeners();
    } catch (e) {
      debugPrint("Error clearing cart: $e");
    }
  }

  // --- WISHLIST ACTIONS ---

  Future<void> toggleWishlist({
    required String title,
    required String brand,
    required String image,
    required double price,
    double? priceAfterDiscount,
    int? discountPercent,
  }) async {
    final isFav = await _repository.isBookmarked(title);
    try {
      if (isFav) {
        await _repository.removeFromWishlistByTitle(title);
      } else {
        final item = WishlistItem(
          title: title,
          brand: brand,
          image: image,
          price: price,
          priceAfterDiscount: priceAfterDiscount,
          discountPercent: discountPercent,
        );
        await _repository.addToWishlist(item);
      }
      _wishlistItems = await _repository.getWishlistItems();
      notifyListeners();
    } catch (e) {
      debugPrint("Error toggling wishlist: $e");
    }
  }

  Future<bool> isBookmarked(String title) async {
    return _repository.isBookmarked(title);
  }

  // --- COUPON ACTIONS ---

  bool applyCoupon(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == "FLUTTER10") {
      _activeCoupon = cleanCode;
      _couponDiscountPercent = 0.10; // 10% Off
      notifyListeners();
      return true;
    } else if (cleanCode == "WELCOME15") {
      _activeCoupon = cleanCode;
      _couponDiscountPercent = 0.15; // 15% Off
      notifyListeners();
      return true;
    } else if (cleanCode == "SUPER20") {
      _activeCoupon = cleanCode;
      _couponDiscountPercent = 0.20; // 20% Off
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeCoupon() {
    _activeCoupon = "";
    _couponDiscountPercent = 0.0;
    notifyListeners();
  }
}
