import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/favorite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'favorite.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT, symbol TEXT NOT NULL,name TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertFavorite(List<Favorite> favorites) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var favorite in favorites) {
      result = await db.insert('favorites', favorite.toMap());
    }
    return result;
  }

  Future<List<Favorite>> retrieveFavorites() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('favorites');
    return queryResult.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<void> deleteFavorite(String symbol) async {
    final db = await initializeDB();
    await db.delete(
      'favorites',
      where: "symbol = ?",
      whereArgs: [symbol],
    );
  }

  Future<Favorite?> findFavorite(String symbol) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('favorites',where:'symbol = ?',whereArgs:[symbol],);
    List<Favorite> favs = queryResult.map((e) => Favorite.fromMap(e)).toList();
    if (favs.isEmpty) {
      return null;
    } else {
      return favs.first;
    }
  }
}
