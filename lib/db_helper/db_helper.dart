import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pas_mobile_11pplg1_05/models/store_models.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;
  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookmarks.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    if (kIsWeb) {
      throw UnsupportedError('Local SQLite not supported on web. Use another storage.');
    }

    String dbDir;
    try {
      // use sqflite helper first (returns a proper writable folder on Android/iOS)
      dbDir = await getDatabasesPath();
      if (dbDir.isEmpty) throw Exception('empty databasesPath');
    } catch (_) {
      try {
        final appDoc = await getApplicationDocumentsDirectory();
        dbDir = appDoc.path;
      } catch (_) {
        // last fallback to system temp (writable)
        dbDir = Directory.systemTemp.path;
      }
    }

    final path = join(dbDir, fileName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE bookmarks (
      id INTEGER PRIMARY KEY,
      title TEXT,
      price REAL,
      description TEXT,
      category TEXT,
      image TEXT,
      rate REAL,
      count INTEGER
    )
    ''');
  }

  Future<int> insertBookmark(Store store) async {
    final db = await instance.database;
    final map = {
      'id': store.id,
      'title': store.title,
      'price': store.price,
      'description': store.description,
      'category': categoryValues.reverse[store.category],
      'image': store.image,
      'rate': store.rating.rate,
      'count': store.rating.count,
    };
    return await db.insert('bookmarks', map, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeBookmark(int id) async {
    final db = await instance.database;
    return await db.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isBookmarked(int id) async {
    final db = await instance.database;
    final res = await db.query('bookmarks', where: 'id = ?', whereArgs: [id], limit: 1);
    return res.isNotEmpty;
  }

  Future<List<Store>> getAllBookmarks() async {
    final db = await instance.database;
    final res = await db.query('bookmarks', orderBy: 'title ASC');
    return res.map((r) {
      final json = {
        "id": r['id'],
        "title": r['title'],
        "price": r['price'],
        "description": r['description'],
        "category": r['category'],
        "image": r['image'],
        "rating": {"rate": r['rate'], "count": r['count']}
      };
      return Store.fromJson(json as Map<String, dynamic>);
    }).toList();
  }
}