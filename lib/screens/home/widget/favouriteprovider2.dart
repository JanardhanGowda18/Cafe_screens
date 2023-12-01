import 'package:flutter/material.dart';

import '../../../models/bestsell.dart';


class FavoritesProvider2 extends ChangeNotifier {
  Set<BestSellers> _favorites = {};

  Set<BestSellers> get favorites => _favorites;

  void toggleFavorite(BestSellers bestSellers) {
    if (_favorites.contains(bestSellers)) {
      _favorites.remove(bestSellers);
    } else {
      _favorites.add(bestSellers);
    }
    notifyListeners();
  }
}