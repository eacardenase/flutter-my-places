import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_places/providers/favorite_places_provider.dart';
import 'package:my_places/screens/add_place_screen.dart';
import 'package:my_places/widgets/favorite_places_list.dart';

class FavoritePlacesScreen extends ConsumerStatefulWidget {
  const FavoritePlacesScreen({super.key});

  @override
  ConsumerState<FavoritePlacesScreen> createState() =>
      _FavoritePlacesScreenState();
}

class _FavoritePlacesScreenState extends ConsumerState<FavoritePlacesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritePlaces = ref.watch(favoritePlacesNotifier);

    Widget mainContent = Center(
      child: Text(
        'No places added yet',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 16,
        ),
      ),
    );

    if (favoritePlaces.isNotEmpty) {
      mainContent = FavoritePlacesList(
        favoritePlaces: favoritePlaces,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Places',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: mainContent,
    );
  }
}
