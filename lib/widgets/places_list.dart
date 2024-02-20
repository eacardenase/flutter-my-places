import 'package:flutter/material.dart';

import 'package:my_places/models/place.dart';
import 'package:my_places/widgets/place_list_item.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'No places added yet',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );

    if (places.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];

          return PlaceListItem(place: place);
        },
      );
    }

    return mainContent;
  }
}
