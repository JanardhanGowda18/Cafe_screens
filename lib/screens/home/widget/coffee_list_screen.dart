import 'package:flutter/material.dart';
import 'package:screen_project/models/coffee.dart';
import 'coffees_item.dart';

class CoffeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Coffees'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of items in each row
          crossAxisSpacing: 8.0, // Set the horizontal spacing between items
          mainAxisSpacing: 8.0, // Set the vertical spacing between items
        ),
        itemCount: Coffees.generateCoffees().length,
        itemBuilder: (context, index) {
          final coffee = Coffees.generateCoffees()[index];
          return CoffeesItem(coffee);
        },
      ),
    );
  }
}
