import 'package:flutter/material.dart';

import '../../../models/coffee.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<Coffees> _favorites = {};
  String _selectedCategory = 'all'; // Default to 'all'

  Set<Coffees> get favorites => _favorites;

  String get selectedCategory => _selectedCategory;

  void toggleFavorite(Coffees coffee) {
    if (_favorites.contains(coffee)) {
      _favorites.remove(coffee);
    } else {
      _favorites.add(coffee);
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
      _selectedCategory = coffees.first.subtitle;
    }
  }
}

