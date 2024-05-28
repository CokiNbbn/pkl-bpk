import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_pkl/models/activity.dart';

class DatabaseHelper {
  DatabaseHelper(this.userId);

  final String userId;

  static DatabaseHelper? _instance;

  DatabaseHelper._privateConstructor(this.userId);

  static DatabaseHelper getInstance(userId) {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor(userId);
    }
    return _instance!;
  }

  Future<Database> _openDatabase(userId) async {
    String path = join(await getDatabasesPath(), '$userId/activity_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createActivityTable,
    );
  }

  // Future<Database> _initDatabase(String userId) async {
  //   String path = join(await getDatabasesPath(), '$userId/activity_database.db');
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: _createActivityTable,
  //   );
  // }

  Future<void> _createActivityTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activities(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertActivity(Activity activity) async {
    Database db = await _openDatabase(userId);
    return await db.insert('activities', activity.toMap());
  }

  Future<List<Map<String, dynamic>>> getActivities() async {
    Database db = await _openDatabase(userId);
    return await db.query('activities');
  }

  Future<int> deleteActivity(int id) async {
    final db = await _instance!._openDatabase(userId);
    return await db.delete(
      'activities',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
