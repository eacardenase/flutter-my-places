import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_places/models/place.dart';
import 'package:my_places/providers/favorite_places_provider.dart';

class NewPlaceForm extends ConsumerStatefulWidget {
  const NewPlaceForm({super.key});

  @override
  ConsumerState<NewPlaceForm> createState() => _NewPlaceForm();
}

class _NewPlaceForm extends ConsumerState<NewPlaceForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';

  void _saveForm() {
    final formState = _formKey.currentState!;
    final formIsValid = formState.validate();

    if (!formIsValid) {
      return;
    }

    formState.save();

    final newFavoritePlace = Place(
      title: _enteredTitle,
    );

    ref.read(userPlacesNotifier.notifier).addPlace(newFavoritePlace);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            maxLength: 50,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            validator: (value) {
              if (value == null ||
                  value.trim().length <= 1 ||
                  value.trim().length > 50) {
                return 'Must be between 2 and 50 characters.';
              }

              return null;
            },
            onSaved: (newValue) {
              _enteredTitle = newValue!;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _saveForm,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          )
        ],
      ),
    );
  }
}
