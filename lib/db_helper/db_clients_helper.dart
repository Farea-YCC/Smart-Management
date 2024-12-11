import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

// Updated SQL statement with new fields
String _clienTbl = '''
  CREATE TABLE ${DbTables.Clients} (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    clientName TEXT,
    clientLocation TEXT,
    phoneNumber INTEGER,
    Note TEXT,
    DebitMoney INTEGER,
    CreditMoney INTEGER,
    DateOfRegister TEXT,
    AmountPaid INTEGER
  )
''';

// Database table
class DbTables {
  static const String Clients = "Clients";
}

// Control database CRUD operations
class DbHelper {
  // DB var
  static DbHelper? dbHelper;
  static Database? _database;

  // DB named constructor
  DbHelper._createInstance();

  // DB singleton
  factory DbHelper() {
    dbHelper ??= DbHelper._createInstance();
    return dbHelper as DbHelper;
  }

  // Initialize Database
  Future<Database> _initializeDatabase() async {
    int dbVersion = 2;
    final dbFolder = await getExternalStorageDirectory();
    final dbPath = p.join(dbFolder!.path, "Database");
    Directory dbFolderDir = await Directory(dbPath).create(recursive: true);

    final file = File(p.join(dbFolderDir.path, 'Clients.db'));
    var clientDb = await openDatabase(
      file.path,
      version: dbVersion,
      onCreate: _createDatabaseV1,
      onUpgrade: _onUpgrade, // Update onUpgrade function
      onDowngrade: onDatabaseDowngradeDelete,
    );
    return clientDb;
  }

  // Create DB tables
  void _createDatabaseV1(Database db, int version) async {
    try {
      await db.execute(_clienTbl);
    } catch (e) {
      print("CreateExp: " + e.toString());
      rethrow;
    }
  }

  // Upgrade DB tables if schema changes
  // Upgrade DB tables if schema changes
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE ${DbTables.Clients} ADD COLUMN DebitMoney INTEGER');
      await db.execute(
          'ALTER TABLE ${DbTables.Clients} ADD COLUMN CreditMoney INTEGER');
      await db.execute(
          'ALTER TABLE ${DbTables.Clients} ADD COLUMN DateOfRegister TEXT');
      await db.execute(
          'ALTER TABLE ${DbTables.Clients} ADD COLUMN AmountPaid INTEGER');
    }
  }

  Future<void> deleteDatabase() async {
    final dbFolder = await getExternalStorageDirectory();
    final dbPath = p.join(dbFolder!.path, "Database");
    final file = File(p.join(dbPath, 'Clients.db'));
    if (await file.exists()) {
      await file.delete();
      print("Database deleted successfully.");
    }
  }

  // Open DB for use
  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database as Database;
  }

  // Select all from table
  Future<List<Map<String, dynamic>>?> getAll(String tbl) async {
    try {
      Database db = await database;
      var res = await db.query(tbl);
      return res;
    } on Exception catch (e) {
      print("Exception in getAll: $e");
      return null;
    }
  }

  // Select by ID
  Future<Map<String, dynamic>?> getById(String tableName, int id,
      {String pkName = "Id"}) async {
    try {
      Database db = await database;
      var result =
          await db.query(tableName, where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result.first : null;
    } on Exception catch (e) {
      print("Exception in getById: ${e}");
      return null;
    }
  }

  // Add to database table
  Future<int> add(String tbl, Map<String, dynamic> obj) async {
    try {
      Database db = await database;
      var res = await db.insert(tbl, obj,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } on Exception catch (e) {
      print("EXP in Insert: ${e}");
      return 0;
    }
  }

  // Update data in database table
  Future<int> update(String tbl, Map<String, dynamic> obj,
      {String pkName = 'Id'}) async {
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if (pkValue != null) {
        var res = await db.update(tbl, obj,
            where: '$pkName = ?',
            whereArgs: [pkValue],
            conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception catch (e) {
      print("EXP in update: ${e}");
      return 0;
    }
  }

  // Delete data from database table
  Future<int> delete(String tbl, Object pkValue, {String pkName = 'Id'}) async {
    try {
      Database db = await database;
      if (pkValue != null) {
        var res =
            await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
        return res;
      }
      return 0;
    } on Exception catch (e) {
      print("EXP in delete: ${e}");
      return 0;
    }
  }
}
