import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String createUserTable = '''
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT NOT NULL,
  nickname TEXT,
  createdAt TEXT NOT NULL
);
''';

const String createCategoryTable = '''
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userId INTEGER NOT NULL,
  name TEXT NOT NULL,
  createdAt TEXT NOT NULL,
  updatedAt TEXT NOT NULL,
  isSynced INTEGER NOT NULL DEFAULT 0
);
''';

const String createItemTable = '''
CREATE TABLE items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  categoryId INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  done INTEGER NOT NULL DEFAULT 0,
  createdAt TEXT NOT NULL,
  updatedAt TEXT NOT NULL,
  isSynced INTEGER NOT NULL DEFAULT 0
);
''';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._internal();
  static Database? _database;

  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_sql.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createUserTable);
        await db.execute(createCategoryTable);
        await db.execute(createItemTable);
      },
    );
  }
}
