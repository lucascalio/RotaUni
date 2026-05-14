import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  static Future<Database> database() async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'rotauni.db'),
      version: 3, 

      onCreate: (db, version) async {
        await db.execute(_createTable);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        
        await db.execute("DROP TABLE IF EXISTS users");
        await db.execute(_createTable);
      },
    );

    return _db!;
  }

  static const String _createTable = '''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      telefone TEXT,
      cep TEXT,
      endereco TEXT,
      username TEXT UNIQUE,
      senha TEXT,
      tipo TEXT,
      vai INTEGER
    )
  ''';
}