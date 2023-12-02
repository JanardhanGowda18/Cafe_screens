import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item_provider.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Consumer<CartItemProvider>(
                builder: (context, cartItemProvider, child) {
                  List<CartItem> cartItems = cartItemProvider.cartItems;
                  return ListView(
                    children: cartItems.map((cartItem) {
                      return _buildOrderItem(context, cartItem);
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your checkout functionality here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, CartItem cartItem) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the product image
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Image.asset(
                cartItem.productImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            _buildOrderDetail('Product', cartItem.productName),
            _buildOrderDetail('Price', cartItem.productPrice),
            _buildOrderDetail('Quantity', cartItem.productQuantity.toString()),
            Divider(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              GestureDetector(
              onTap: () {
          // Remove the item from the cart
          Provider.of<CartItemProvider>(context, listen: false).removeFromCart(cartItem);
    },
      child: Icon(
        Icons.remove_circle,
        color: Colors.red,
        size: 30,
      ),
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
