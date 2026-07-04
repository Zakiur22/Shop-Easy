class WishlistItem {
  final int? id;
  final String title;
  final String brand;
  final String image;
  final double price;
  final double? priceAfterDiscount;
  final int? discountPercent;

  WishlistItem({
    this.id,
    required this.title,
    required this.brand,
    required this.image,
    required this.price,
    this.priceAfterDiscount,
    this.discountPercent,
  });

  double get effectivePrice => priceAfterDiscount ?? price;

  WishlistItem copyWith({
    int? id,
    String? title,
    String? brand,
    String? image,
    double? price,
    double? priceAfterDiscount,
    int? discountPercent,
  }) {
    return WishlistItem(
      id: id ?? this.id,
      title: title ?? this.title,
      brand: brand ?? this.brand,
      image: image ?? this.image,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discountPercent: discountPercent ?? this.discountPercent,
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
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map) {
    return WishlistItem(
      id: map['id'] as int?,
      title: map['title'] as String,
      brand: map['brand'] as String,
      image: map['image'] as String,
      price: (map['price'] as num).toDouble(),
      priceAfterDiscount: map['priceAfterDiscount'] != null
          ? (map['priceAfterDiscount'] as num).toDouble()
          : null,
      discountPercent: map['discountPercent'] as int?,
    );
  }
}
