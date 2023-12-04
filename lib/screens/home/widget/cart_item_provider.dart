import 'package:flutter/cupertino.dart';

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
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      if (item.productQuantity > 1) {
        _cartItems[index] = CartItem(
          productImageUrl: item.productImageUrl,
          productName: item.productName,
          productPrice: item.productPrice,
          productQuantity: item.productQuantity - 1,
        );
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }


  void incrementQuantity(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems[index] = CartItem(
        productImageUrl: item.productImageUrl,
        productName: item.productName,
        productPrice: item.productPrice,
        productQuantity: item.productQuantity + 1,
      );
      notifyListeners();
    }
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;

    for (CartItem item in _cartItems) {
      String priceString = item.productPrice.replaceAll('₹', '').trim();
      double price = double.parse(priceString);
      totalAmount += price * item.productQuantity;
    }

    return totalAmount;
  }
}
