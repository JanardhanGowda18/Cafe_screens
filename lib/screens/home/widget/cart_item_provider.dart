import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'checkoutpage.dart';

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

  // Set user-specific cart items in the provider
  Future<void> setUserCartItems(User? user) async {
    if (user != null) {
      // Retrieve user-specific cart items from Firestore
      CollectionReference userCartCollection =
      FirebaseFirestore.instance.collection('user_carts');

      DocumentSnapshot<Object?> userCart =
      await userCartCollection.doc(user.uid).get();

      if (userCart.exists) {
        // If cart data exists, update _cartItems
        List<dynamic> cartData = userCart['cart'] ?? [];
        _cartItems = cartData
            .map((item) => CartItem(
          productImageUrl: item['productImageUrl'],
          productName: item['productName'],
          productPrice: item['productPrice'],
          productQuantity: item['productQuantity'],
        ))
            .toList();
      } else {
        // If cart data doesn't exist, initialize _cartItems to an empty list
        _cartItems = [];
      }
    } else {
      // If the user is null (logged out), clear _cartItems
      _cartItems = [];
    }

    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Clear user-specific cart items when the user logs out
  void clearUserCartItems() {
    _cartItems = [];
    notifyListeners();
  }
  void clearCartItems() {
    _cartItems = [];
    notifyListeners();
  }
  // Add an item to the cart
  void addToCart(CartItem cartItem) {
    if (isLoggedIn()) {
      User? user = FirebaseAuth.instance.currentUser;

      // Save cart item to Firestore
      FirebaseFirestore.instance.collection('users').doc(user?.uid).collection('cart').add({
        'productName': cartItem.productName,
        'productPrice': cartItem.productPrice,
        // Add other properties as needed
      });
    }

    // Add the item to the local cart
    _cartItems.add(cartItem);

    // Notify listeners that the state has changed
    notifyListeners();
  }
  void removeFromCart(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void DecrementQuantity(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems[index] = CartItem(
        productImageUrl: item.productImageUrl,
        productName: item.productName,
        productPrice: item.productPrice,
        productQuantity: item.productQuantity - 1,
      );
      notifyListeners();
    }
  }
  // Increment the quantity of an item in the cart
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

  // Calculate the total amount of the items in the cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;

    for (CartItem item in _cartItems) {
      String priceString = item.productPrice.replaceAll('₹', '').trim();
      double price = double.parse(priceString);
      totalAmount += price * item.productQuantity;
    }

    return totalAmount;
  }

  // Save user-specific cart items to Firestore
  Future<void> saveUserCartItems(User? user) async {
    if (user != null) {
      CollectionReference userCartCollection =
      FirebaseFirestore.instance.collection('user_carts');

      // Convert _cartItems to a format suitable for Firestore
      List<Map<String, dynamic>> cartData = _cartItems
          .map((item) => {
        'productImageUrl': item.productImageUrl,
        'productName': item.productName,
        'productPrice': item.productPrice,
        'productQuantity': item.productQuantity,
      })
          .toList();

      // Save cart data to Firestore
      await userCartCollection.doc(user.uid).set({'cart': cartData});
    }
  }
}