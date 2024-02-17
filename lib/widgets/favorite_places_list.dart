import 'package:flutter/material.dart';

import 'package:my_places/models/favorite_place.dart';
import 'package:my_places/screens/place_details_screen.dart';

class FavoritePlacesList extends StatelessWidget {
  const FavoritePlacesList({
    super.key,
    required this.favoritePlaces,
  });

  final List<FavoritePlace> favoritePlaces;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {
        final favoritePlace = favoritePlaces[index];

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailsScreen(
                  favoritePlace: favoritePlace,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              favoritePlace.title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
