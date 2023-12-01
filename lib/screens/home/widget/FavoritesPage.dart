import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/coffee.dart';
import 'favouriteprovider.dart';
import 'coffees_item.dart'; // Assuming you've named your item widget as CoffeesItem

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    List<Coffees> favoriteItems = favoritesProvider.favorites.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite items'),
      ),
      body: favoriteItems.isEmpty
          ? Center(
        child: Text('No favorite items yet.'),
      )
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          return CoffeesItem(favoriteItems[index]);
        },
      ),
    );
  }
}