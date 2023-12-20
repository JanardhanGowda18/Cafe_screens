import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'cart_item_provider.dart';
import '../../detail/widget/success_page.dart';
import '../../login/login.dart';

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
        backgroundColor: Colors.white,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            color: Colors.brown,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
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
            Center(
              child: Text(
                "Choose pick-up method",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontFamily: 'RubikBubbles',
                ),
              ),
            ),
            _buildPaymentOptions(),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Check if the user is already logged in
                  if (isLoggedIn()) {
                    // Save user-specific cart items before navigating to the success page
                    await Provider.of<CartItemProvider>(context, listen: false)
                        .saveUserCartItems(FirebaseAuth.instance.currentUser);
                    // Navigate to success page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuccessPage()),
                    );
                  } else {
                    // User is not logged in, navigate to sign-in page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
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
                  icon: Icon(Icons.delete_outline_outlined),
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
                    height: 120,
                    width: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        cartItem.productImageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                ),
                SizedBox(width: 10),
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
                            'Quantity : ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          // SizedBox(width: 10.0 ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartItemProvider>(
                                    context,
                                    listen: false,
                                  ).DecrementQuantity(cartItem);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.brown,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
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
                                    color: Colors.brown,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(Icons.add,color: Colors.white,),
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
    double totalAmount = Provider.of<CartItemProvider>(context).calculateTotalAmount();
    double discountAmount = totalAmount > 500 ? 49.0 : 0.0;
    double couponAmount = totalAmount >= 1000 ? 100.0 : 0.0;
    double discountedTotalAmount = totalAmount - discountAmount - couponAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildOrderDetail(
            'SubTotal Amount', '\₹${totalAmount.toStringAsFixed(2)}'),
        Divider(
          color: Colors.black,
        ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 16),
        _buildPaymentOption(
          PaymentMethod.COD,
          'Cash on Delivery',
          Icons.money,
        ),
        _buildPaymentOption(
          PaymentMethod.UPI,
          'UPI Payment',
          Icons.payment,
        ),
      ],
    );
  }

  Widget _buildPaymentOption(PaymentMethod method, String label, IconData money) {
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
        activeColor: Colors.brown,
      ),
    );
  }
}
enum PaymentMethod {
  COD,
  UPI,
}

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser != null;
}