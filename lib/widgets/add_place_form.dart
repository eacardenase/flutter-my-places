import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:my_places/models/place.dart';
import 'package:my_places/providers/favorite_places_provider.dart';
import 'package:my_places/widgets/image_input.dart';
import 'package:my_places/widgets/location_input.dart';

class NewPlaceForm extends ConsumerStatefulWidget {
  const NewPlaceForm({super.key});

  @override
  ConsumerState<NewPlaceForm> createState() => _NewPlaceForm();
}

class _NewPlaceForm extends ConsumerState<NewPlaceForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _selectImage(File image) {
    _selectedImage = image;
  }

  void _selectLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  void _saveForm() async {
    final formState = _formKey.currentState!;
    final formIsValid = formState.validate();

    if (!formIsValid || _selectedImage == null || _selectedLocation == null) {
      return;
    }

    formState.save();

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_selectedImage!.path);
    final copiedImage = await _selectedImage!.copy('${appDir.path}/$fileName');

    print(appDir.path);
    print(fileName);

    final newPlace = Place(
      title: _enteredTitle,
      image: copiedImage,
      location: _selectedLocation!,
    );

    ref.read(userPlacesNotifier.notifier).addPlace(newPlace);

    // Checks `this.mounted`, not `context.mounted`
    if (!mounted) return;

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
          ImageInput(
            onPickImage: _selectImage,
          ),
          const SizedBox(height: 16),
          LocationInput(
            onSelectLocation: _selectLocation,
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
