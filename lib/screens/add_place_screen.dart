import 'package:flutter/material.dart';
import 'package:my_places/widgets/new_place_form.dart';

class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add new Place',
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: NewPlaceForm(),
      ),
    );
  }
}
