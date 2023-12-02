import 'package:flutter/foundation.dart';

class CartItem {
  final String productImageUrl;
  final String productName;
  final String productPrice;
  final int productQuantity;

  CartItem({
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,

    required this.productQuantity,
  });
}

class CartItemProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }
  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }
}
