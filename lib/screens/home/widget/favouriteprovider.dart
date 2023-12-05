import 'package:flutter/material.dart';

import '../../../models/coffee.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<Coffees> _favorites = {};
  String _selectedCategory = 'all'; // Default to 'all'

  Set<Coffees> get favorites => _favorites;

  String get selectedCategory => _selectedCategory;

  void toggleFavorite(Coffees coffee, BuildContext context) {
    if (_favorites.contains(coffee)) {
      _favorites.remove(coffee);
    } else {
      _favorites.add(coffee);
      _showSnackBar(context, '${coffee.title} added to Favorites');
    }
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setDefaultCategory(List<Coffees> coffees) {
    if (coffees.isNotEmpty) {
      _selectedCategory = 'all';
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
