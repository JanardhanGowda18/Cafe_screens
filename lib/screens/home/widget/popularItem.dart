import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_project/models/bestsell.dart';
import 'package:screen_project/screens/detail/detail1.dart';
import 'favouriteprovider2.dart';

class PopularItem extends StatefulWidget {
  final BestSellers bestSellers;

  PopularItem(this.bestSellers, {Key? key}) : super(key: key);

  @override
  _PopularItemState createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider2 = Provider.of<FavoritesProvider2>(context);
    bool isFavorite = favoritesProvider2.favorites.contains(widget.bestSellers);

    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPage1(bestSellers: widget.bestSellers),
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
                      tag: 'bestSellersImage${widget.bestSellers.title}', // Use the title as the tag
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(widget.bestSellers.imageUrl),
                            // fit: BoxFit.cover,
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
                            // Toggle the favorite status globally
                            favoritesProvider2.toggleFavorite(widget.bestSellers);
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
                  widget.bestSellers.title,
                  style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
