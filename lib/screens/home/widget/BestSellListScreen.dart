import 'package:flutter/material.dart';
import 'package:screen_project/screens/home/widget/popularItem.dart';
import '../../../models/bestsell.dart';

class BestSellListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best of All Items'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of items in each row
          crossAxisSpacing: 10.0, // Set the horizontal spacing between items
          mainAxisSpacing: 10.0, // Set the vertical spacing between items
        ),
        itemCount: BestSellers.generateBestSellers().length,
        itemBuilder: (context, index) {
          final bestSellers = BestSellers.generateBestSellers()[index];
          return PopularItem(bestSellers);
        },
      ),
    );
  }
}
