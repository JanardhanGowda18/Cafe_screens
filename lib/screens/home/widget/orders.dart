import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late User _currentUser;
  late CollectionReference _userOrdersCollection;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userOrdersCollection =
        FirebaseFirestore.instance.collection('user_orders').doc(_currentUser.uid).collection('orders');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userOrdersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No orders yet.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Customize the UI for each order
                Map<String, dynamic> orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(orderData['productName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${orderData['productPrice']}'),
                        Text('Quantity: ${orderData['productQuantity']}'),
                      ],
                    ),
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(orderData['productImageUrl']),                        ),
                      ),
                    ),
                    // Add more details as needed
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}