import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'rotauni.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            cep TEXT,
            endereco TEXT,
            vai INTEGER
          )
        ''');
      },
      version: 1,
    );

    return _db!;
  }

  static Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await getDB();
    await db.insert('users', user);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await getDB();
    return db.query('users');
  }
}