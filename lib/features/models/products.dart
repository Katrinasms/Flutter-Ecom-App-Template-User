import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double quantity;
  final String image;
  final String provider;
  final double price;
  final String? id;
  bool addedToCart;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.image,
    required this.price,
    required this.provider,
    this.id,
    this.addedToCart = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'image': image,
      'price': price,
      'provider': provider,
      'id': id,
      'addedToCart': addedToCart,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      provider: map['provider'] ?? '',
      id: map['_id'],
      addedToCart: map['addedToCart'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
