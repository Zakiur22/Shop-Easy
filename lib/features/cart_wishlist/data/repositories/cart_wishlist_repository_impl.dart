import '../../domain/models/cart_item.dart';
import '../../domain/models/wishlist_item.dart';
import '../../domain/repositories/cart_wishlist_repository.dart';
import '../datasources/cart_wishlist_local_datasource.dart';

class CartWishlistRepositoryImpl implements CartWishlistRepository {
  final CartWishlistLocalDatasource _localDatasource;

  CartWishlistRepositoryImpl({CartWishlistLocalDatasource? localDatasource})
      : _localDatasource = localDatasource ?? CartWishlistLocalDatasource.instance;

  @override
  Future<List<CartItem>> getCartItems() {
    return _localDatasource.getCartItems();
  }

  @override
  Future<void> addToCart(CartItem item) {
    return _localDatasource.addToCart(item);
  }

  @override
  Future<void> removeFromCart(int id) {
    return _localDatasource.removeFromCart(id);
  }

  @override
  Future<void> updateCartItemQuantity(int id, int quantity) {
    return _localDatasource.updateCartItemQuantity(id, quantity);
  }

  @override
  Future<void> clearCart() {
    return _localDatasource.clearCart();
  }

  @override
  Future<List<WishlistItem>> getWishlistItems() {
    return _localDatasource.getWishlistItems();
  }

  @override
  Future<void> addToWishlist(WishlistItem item) {
    return _localDatasource.addToWishlist(item);
  }

  @override
  Future<void> removeFromWishlistByTitle(String title) {
    return _localDatasource.removeFromWishlistByTitle(title);
  }

  @override
  Future<bool> isBookmarked(String title) {
    return _localDatasource.isBookmarked(title);
  }
}
