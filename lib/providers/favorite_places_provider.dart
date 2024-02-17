import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_places/models/favorite_place.dart';

class FavoritePlaceNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlaceNotifier() : super([]);

  void addPlace(FavoritePlace place) {
    state = [
      ...state,
      place,
    ];
  }
}

final favoritePlacesNotifier =
    StateNotifierProvider<FavoritePlaceNotifier, List<FavoritePlace>>(
  (ref) => FavoritePlaceNotifier(),
);
