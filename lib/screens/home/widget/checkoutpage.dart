import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../detail/widget/success_page.dart';
import 'cart_item_provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod? selectedPaymentMethod;

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
            _buildTotalAmount(context),
            SizedBox(height: 16),
            _buildPaymentOptions(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {

                if (selectedPaymentMethod == PaymentMethod.COD) {

                } else if (selectedPaymentMethod == PaymentMethod.UPI) {

                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SuccessPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete_sweep_outlined),
                  onPressed: () {
                    Provider.of<CartItemProvider>(context, listen: false)
                        .removeFromCart(cartItem);
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    cartItem.productImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderDetail('Product', cartItem.productName),
                      _buildOrderDetail('Price', cartItem.productPrice),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Quantity: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 30),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartItemProvider>(
                                    context,
                                    listen: false,
                                  ).removeFromCart(cartItem);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                cartItem.productQuantity.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartItemProvider>(
                                    context,
                                    listen: false,
                                  ).incrementQuantity(cartItem);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
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

  Widget _buildTotalAmount(BuildContext context) {
    double totalAmount = Provider.of<CartItemProvider>(context)
        .calculateTotalAmount();
    double discountAmount = totalAmount > 500 ? 49.0 : 0.0;
    double couponAmount = totalAmount >= 1000 ? 100.0 : 0.0;
    double discountedTotalAmount = totalAmount - discountAmount - couponAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildOrderDetail(
            'SubTotal Amount', '\₹${totalAmount.toStringAsFixed(2)}'),
        if (totalAmount > 500)
          _buildOrderDetail(
              'Delivery Fee', '-\₹${discountAmount.toStringAsFixed(2)}'),
        if (totalAmount >= 1000)
          _buildOrderDetail(
              'Coupon', '-\₹${couponAmount.toStringAsFixed(2)}'),
        SizedBox(height: 8),
        _buildOrderDetail('Total Amount',
            '\₹${discountedTotalAmount.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPaymentOption(
          PaymentMethod.COD,
          'Cash on Delivery',
        ),
        _buildPaymentOption(
          PaymentMethod.UPI,
          'UPI Payment',
        ),
      ],
    );
  }

  Widget _buildPaymentOption(PaymentMethod method, String label) {
    return ListTile(
      title: Text(label),
      leading: Radio(
        value: method,
        groupValue: selectedPaymentMethod,
        onChanged: (PaymentMethod? value) {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
      ),
    );
  }
}

enum PaymentMethod {
  COD,
  UPI,
}
