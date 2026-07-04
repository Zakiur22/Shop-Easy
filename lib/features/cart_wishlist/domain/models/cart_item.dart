class CartItem {
  final int? id;
  final String title;
  final String brand;
  final String image;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent;
  final int selectedColor; // stored as ARGB color int value
  final String selectedSize;
  final int quantity;

  CartItem({
    this.id,
    required this.title,
    required this.brand,
    required this.image,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,
    required this.selectedColor,
    required this.selectedSize,
    required this.quantity,
  });

  double get effectivePrice => priceAfterDiscount ?? price;

  double get totalPrice => effectivePrice * quantity;

  CartItem copyWith({
    int? id,
    String? title,
    String? brand,
    String? image,
    double? price,
    double? priceAfterDiscount,
    int? discountPercent,
    int? selectedColor,
    String? selectedSize,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discountPercent: discountPercent ?? this.discountPercent,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'brand': brand,
      'image': image,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'discountPercent': discountPercent,
      'selectedColor': selectedColor,
      'selectedSize': selectedSize,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int?,
      title: map['title'] as String,
      brand: map['brand'] as String,
      image: map['image'] as String,
      price: (map['price'] as num).toDouble(),
      priceAfterDiscount: map['priceAfterDiscount'] != null
          ? (map['priceAfterDiscount'] as num).toDouble()
          : null,
      discountPercent: map['discountPercent'] as int?,
      selectedColor: map['selectedColor'] as int,
      selectedSize: map['selectedSize'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
