import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CategorySelector.dart';
import 'coffee_list_screen.dart';
import 'favouriteprovider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('all');
            },
            child: Container(
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: favoritesProvider.selectedCategory == 'all'
                      ? Theme.of(context).primaryColor // Change color as needed
                      : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  'All Categories',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'all'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('coffee');
            },
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: favoritesProvider.selectedCategory == 'coffee'
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  'Coffee',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'coffee'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('tea');
            },
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: favoritesProvider.selectedCategory == 'tea'
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  'Tea',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'tea'
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


