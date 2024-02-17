import 'package:flutter/material.dart';

import 'package:my_places/models/favorite_place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({
    super.key,
    required this.favoritePlace,
  });

  final FavoritePlace favoritePlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(favoritePlace.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          favoritePlace.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
