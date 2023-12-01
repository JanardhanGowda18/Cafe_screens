import 'package:flutter/material.dart';

import '../../../models/coffee.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<Coffees> _favorites = {};

  Set<Coffees> get favorites => _favorites;

  void toggleFavorite(Coffees coffee) {
    if (_favorites.contains(coffee)) {
      _favorites.remove(coffee);
    } else {
      _favorites.add(coffee);
    }
    notifyListeners();
  }
}