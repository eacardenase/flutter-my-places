import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:my_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(Place place) async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
      },
      version: 1,
    );

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

final userPlacesNotifier =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
