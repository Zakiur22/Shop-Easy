import '../models/cart_item.dart';
import '../models/wishlist_item.dart';

abstract class CartWishlistRepository {
  // Cart Actions
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(int id);
  Future<void> updateCartItemQuantity(int id, int quantity);
  Future<void> clearCart();

  // Wishlist Actions
  Future<List<WishlistItem>> getWishlistItems();
  Future<void> addToWishlist(WishlistItem item);
  Future<void> removeFromWishlistByTitle(String title);
  Future<bool> isBookmarked(String title);
}
