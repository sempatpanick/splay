import 'package:sqflite/sqflite.dart';

import '../../models/directory_saved_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _dbName = 'splay.db';
  static const String _tblDirectorySaved = 'directory_saved';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$_dbName';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblDirectorySaved (
        id TEXT PRIMARY KEY,
        path TEXT
      );
    ''');
  }

  Future<int> insertDirectorySaved({required DirectorySavedModel directory}) async {
    final db = await database;
    return await db!.insert(_tblDirectorySaved, directory.toJson());
  }

  Future<int> removeDirectorySaved({required DirectorySavedModel directory}) async {
    final db = await database;
    return await db!.delete(
      _tblDirectorySaved,
      where: 'id = ?',
      whereArgs: [directory.id],
    );
  }

  Future<Map<String, dynamic>?> getDirectorySavedById({required String id}) async {
    final db = await database;
    final results = await db!.query(
      _tblDirectorySaved,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getDirectorySaved() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblDirectorySaved);

    return results;
  }
}
