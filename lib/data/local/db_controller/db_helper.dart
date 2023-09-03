import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        note TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE amount (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        input TEXT,
        output TEXT,
        note TEXT,
        date TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<List<Map<String, dynamic>>?> getAllUsers() async {
    final db = await database;
    final res = await db?.query('users');
    return res;
  }


  Future<int?> addUser(String name, String note) async {
    final db = await database;
    final res = await db?.insert(
      'users',
      {'name': name, 'note': note},
    );
    return res;
  }

  Future<void> insertAmount(int userId, String date, {String? input, output, note}) async {
    final db = await database;
    await db?.insert(
      'amount',
      {
        'user_id': userId,
        'input': input,
        'output': output,
        'note': note,
        'date': date,
      },
    );
  }


  Future<List<Map<String, dynamic>>?> getAmountsForUser(int userId) async {
    final db = await database;
    return await db?.query(
      'amount',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<List<Map<String, Object?>>?> getUser(int id) async {
    final db = await database;
    return await db?.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int?> deleteAmount(int id, int userId) async {
    final db = await database;
    return await db?.delete(
      'amount',
      where: 'user_id = ? AND id = ?',
      whereArgs: [userId, id],
    );
  }

  Future<int?> updateAmount(int id, String date, {String? input, output, note}) async {
    final db = await database;
    return await db?.update(
      'amount',
      {
        'input': input,
        'output': output,
        'date': date,
        'note': note,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  Future<List<Map<String, dynamic>>?> getAllInputOutputAmounts() async {
    final db = await database;
    return await db?.rawQuery('''
      SELECT users.name, amount.input, amount.output, amount.date
      FROM users
      INNER JOIN amount ON users.id = amount.user_id
    ''');
  }
}
