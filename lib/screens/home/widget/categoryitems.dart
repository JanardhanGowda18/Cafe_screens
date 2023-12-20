import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favouriteprovider.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(height: 80),

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
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                color: favoritesProvider.selectedCategory == 'all'
                    ? favoritesProvider.selectedCategoryColor
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  'All Categories',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'all'
                        ? Colors.white
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
                color: favoritesProvider.selectedCategory == 'coffee'
                    ? favoritesProvider.selectedCategoryColor
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  'Coffee',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'coffee'
                        ? Colors.white
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
                color: favoritesProvider.selectedCategory == 'tea'
                    ? favoritesProvider.selectedCategoryColor
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  'Tea',
                  style: TextStyle(
                    fontSize: 15,
                    color: favoritesProvider.selectedCategory == 'tea'
                        ? Colors.white
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
