import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_places/models/place.dart';
import 'package:my_places/providers/favorite_places_provider.dart';
import 'package:my_places/screens/place_details_screen.dart';

class PlaceListItem extends ConsumerWidget {
  const PlaceListItem({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(place.id),
      onDismissed: (direction) {
        ref.read(userPlacesProvider.notifier).removePlace(place.id);
      },
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailsScreen(
                place: place,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(
            place.image,
          ),
        ),
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        subtitle: Text(
          place.location.address,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
