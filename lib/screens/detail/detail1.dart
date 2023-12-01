import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_project/screens/detail/widget/detail_app_bar.dart';

import '../../models/bestsell.dart';
import '../home/widget/favouriteprovider2.dart';

class QuantityButton extends StatelessWidget {
  final int quantity;
  final Function() onIncrement;
  final Function() onDecrement;

  QuantityButton({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: onDecrement,
          style: ElevatedButton.styleFrom(
            primary: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPrimary: Colors.white, // Set text color for the button
          ),
          child: Icon(Icons.remove),
        ),
        SizedBox(width: 16),
        Text(
          '$quantity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Set color for the middle number
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: onIncrement,
          style: ElevatedButton.styleFrom(
            primary: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPrimary: Colors.white, // Set text color for the button
          ),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}

// DetailPage1 Widget
class DetailPage1 extends StatefulWidget {
  final BestSellers bestSellers;

  const DetailPage1({Key? key, required this.bestSellers}) : super(key: key);

  @override
  _DetailPage1State createState() => _DetailPage1State();
}

class _DetailPage1State extends State<DetailPage1> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final favoritesProvider2 = Provider.of<FavoritesProvider2>(context);
    bool isFavorite = favoritesProvider2.favorites.contains(widget.bestSellers);

    return Scaffold(
      appBar: AppBar(
        // Add the back button to the app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              // Toggle the favorite status locally
              favoritesProvider2.toggleFavorite(widget.bestSellers);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display "Product Details" Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Set color for the "Product Details" text
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
              child: Hero(
                tag: 'bestSellersImage${widget.bestSellers.title}', // Use the title as the tag
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    widget.bestSellers.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.bestSellers.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Set color for the product title
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.bestSellers.price,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Ingredients: ${widget.bestSellers.ingredients}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Display Description
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Description: ${widget.bestSellers.description}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 106),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity
                  QuantityButton(
                    quantity: quantity,
                    onIncrement: () {
                      setState(() {
                        quantity = quantity + 1;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        quantity = quantity - 1 > 0 ? quantity - 1 : 1;
                      });
                    },
                  ),
                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: () {
                      // Implement your add to cart functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPrimary: Colors.white, // Set text color for the button
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
