import 'package:flutter/material.dart';
import 'package:screen_project/models/bestsell.dart';
import 'package:screen_project/screens/detail/detail1.dart';

class PopularItem extends StatefulWidget {
  final BestSellers bestSellers;

  PopularItem(this.bestSellers, {Key? key}) : super(key: key);

  @override
  _PopularItemState createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPage1(bestSellers: widget.bestSellers),
            ),
          );
        },
        child: SingleChildScrollView( // Wrap the entire card with SingleChildScrollView
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.bestSellers.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 15,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            size: 15,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.bestSellers.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
