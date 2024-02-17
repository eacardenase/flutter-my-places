import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_places/providers/favorite_places_provider.dart';
import 'package:my_places/screens/add_place_screen.dart';
import 'package:my_places/widgets/places_list.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesNotifier);

    Widget mainContent = Center(
      child: Text(
        'No places added yet',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (userPlaces.isNotEmpty) {
      mainContent = PlacesList(
        places: userPlaces,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
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
