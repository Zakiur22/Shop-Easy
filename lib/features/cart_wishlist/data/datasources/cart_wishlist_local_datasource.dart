import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/models/cart_item.dart';
import '../../domain/models/wishlist_item.dart';

class CartWishlistLocalDatasource {
  static final CartWishlistLocalDatasource instance = CartWishlistLocalDatasource._init();
  static Database? _database;

  CartWishlistLocalDatasource._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('shop_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        brand TEXT NOT NULL,
        image TEXT NOT NULL,
        price REAL NOT NULL,
        priceAfterDiscount REAL,
        discountPercent INTEGER,
        selectedColor INTEGER NOT NULL,
        selectedSize TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE wishlist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL UNIQUE,
        brand TEXT NOT NULL,
        image TEXT NOT NULL,
        price REAL NOT NULL,
        priceAfterDiscount REAL,
        discountPercent INTEGER
      )
    ''');
  }

  // --- CART QUERIES ---

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final result = await db.query('cart', orderBy: 'id ASC');
    return result.map((json) => CartItem.fromMap(json)).toList();
  }

  Future<void> addToCart(CartItem item) async {
    final db = await database;
    // Check if an item with the same title, color, and size already exists in the cart.
    // If so, increment its quantity instead of adding a new row.
    final existing = await db.query(
      'cart',
      where: 'title = ? AND selectedColor = ? AND selectedSize = ?',
      whereArgs: [item.title, item.selectedColor, item.selectedSize],
    );

    if (existing.isNotEmpty) {
      final existingItem = CartItem.fromMap(existing.first);
      await db.update(
        'cart',
        {'quantity': existingItem.quantity + item.quantity},
        where: 'id = ?',
        whereArgs: [existingItem.id],
      );
    } else {
      await db.insert('cart', item.toMap());
    }
  }

  Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateCartItemQuantity(int id, int quantity) async {
    final db = await database;
    if (quantity <= 0) {
      await removeFromCart(id);
    } else {
      await db.update(
        'cart',
        {'quantity': quantity},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  // --- WISHLIST QUERIES ---

  Future<List<WishlistItem>> getWishlistItems() async {
    final db = await database;
    final result = await db.query('wishlist', orderBy: 'id ASC');
    return result.map((json) => WishlistItem.fromMap(json)).toList();
  }

  Future<void> addToWishlist(WishlistItem item) async {
    final db = await database;
    await db.insert(
      'wishlist',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFromWishlistByTitle(String title) async {
    final db = await database;
    await db.delete(
      'wishlist',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<bool> isBookmarked(String title) async {
    final db = await database;
    final result = await db.query(
      'wishlist',
      where: 'title = ?',
      whereArgs: [title],
    );
    return result.isNotEmpty;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
