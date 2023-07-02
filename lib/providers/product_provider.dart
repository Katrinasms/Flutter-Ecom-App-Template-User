import 'package:flutter/material.dart';
import 'package:custom_shop/features/models/products.dart';

// final String name;
// final String description;
// final double quantity;
// final String image;
// final String provider;
// final double price;
// final String? id;

class ProductProvider extends ChangeNotifier {
  Product _product = Product(
    name: '',
    description: '',
    quantity: 1,
    image: '',
    provider: '',
    price: 0.0,
  );

  Product get product => _product;

  void setProduct(String product) {
    _product = Product.fromJson(product);
    notifyListeners();
  }

  void setProductFromModel(Product product) {
    _product = product;
    notifyListeners();
  }
}
