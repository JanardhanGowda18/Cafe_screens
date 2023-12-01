import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_project/models/coffee.dart';
import 'coffees_item.dart';
import 'favouriteprovider.dart';

class CoffeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Coffees'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final List<Coffees> coffeesList = Coffees.generateCoffees();

          // Filter coffees based on selected category
          List<Coffees> filteredCoffees = favoritesProvider.selectedCategory == 'all'
              ? coffeesList
              : coffeesList
              .where((coffee) => coffee.subtitle == favoritesProvider.selectedCategory)
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: filteredCoffees.length,
            itemBuilder: (context, index) {
              return CoffeesItem(filteredCoffees[index]);
            },
          );
        },
      ),
    );
  }
}
