import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:my_places/models/place.dart';

Future<Database> _getDatabase() async {
  // final dbPath = await sql.getDatabasesPath();
  final appDir = await syspaths.getApplicationDocumentsDirectory();

  final db = await sql.openDatabase(
    path.join(appDir.path, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
    },
    version: 2,
  );

  // print(dbPath);

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map((row) {
      print(row['image']);

      return Place(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(
          row['image'] as String,
        ),
        location: PlaceLocation(
          latitude: row['latitude'] as double,
          longitude: row['longitude'] as double,
          address: row['address'] as String,
        ),
      );
    }).toList();

    state = places;
  }

  void addPlace(Place place) async {
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'latitude': place.location.latitude,
      'longitude': place.location.latitude,
      'address': place.location.address,
    });

    state = [
      place,
      ...state,
    ];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
