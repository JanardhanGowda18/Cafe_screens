import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../detail/detail.dart';
import 'cart_item_provider.dart';
import 'favouriteprovider.dart';
import 'package:screen_project/models/coffee.dart';

class CoffeesItem extends StatefulWidget {
  final Coffees coffees;

  CoffeesItem(this.coffees, {Key? key}) : super(key: key);

  @override
  _CoffeesItemState createState() => _CoffeesItemState();
}

class _CoffeesItemState extends State<CoffeesItem> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final cartProvider = Provider.of<CartItemProvider>(context);
    bool isFavorite = favoritesProvider.favorites.contains(widget.coffees);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailPage(coffees: widget.coffees),
            transitionsBuilder: (context, animation, secondaryAnimation,
                child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },

      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'coffeeImage${widget.coffees.title}',
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(widget.coffees.imageUrl),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 15,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          favoritesProvider.toggleFavorite(widget.coffees,
                              context);
                        },
                        child: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.coffees.title,
                style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              ),
              Text(
                widget.coffees.price,
                style: TextStyle(
                  color: pricecolor,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  CartItem cartItem = CartItem(
                    productImageUrl: widget.coffees.imageUrl,
                    productName: widget.coffees.title,
                    productPrice: widget.coffees.price,
                    productQuantity: 1,
                  );
                  cartProvider.addToCart(cartItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to Cart'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: buttoncolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}