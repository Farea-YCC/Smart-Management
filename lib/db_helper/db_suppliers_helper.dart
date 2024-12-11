import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

// SQL statmant
String _supplierTbl = 'CREATE TABLE ${DbTables.Suppliers} (Id INTEGER PRIMARY KEY AUTOINCREMENT, supplierName TEXT, supplierLocation TEXT, phoneNumber INTEGER, Note  TEXT)';

// database table
class DbTables{
  static const String Suppliers = "Suppliers";
}

// control database CRUD oprations
class DbHelper{
  // db var
  static DbHelper? dbHelper;
  static Database? _database;

// db named constractor
  DbHelper._createInstance();

// db singleton
  factory DbHelper() {
    dbHelper ??= DbHelper._createInstance();
    return dbHelper as DbHelper;
  }
// fun initialize Database
  Future<Database> _initializeDatabase() async {
    int dbVersion =1;
    final dbFolder = await getExternalStorageDirectory();
    final dbPath = p.join(dbFolder!.path, "Database");
    Directory dbFolderDir = await Directory(dbPath).create(recursive: true);

    final file = File(p.join(dbFolderDir.path, 'Suppliers.db'));
    var supplierDb = await openDatabase(
        file.path,
        version: dbVersion,
        onCreate: _createDatabaseV1,
        onDowngrade: onDatabaseDowngradeDelete
    );
    return supplierDb;
  }

  // fun create db tables
  void _createDatabaseV1(Database db, int version) async {
    try {
      await db.execute(_supplierTbl);
    }
    catch(e){
      print("CreateExp:- "+ e.toString());
      rethrow;
    }
  }

  // fun open db for use (in RAM)
  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database as Database;
  }

// select all from
  Future<List<Map<String, dynamic>>?> getAll(String tbl) async{
    try {
      Database db = await database;
      var res = await db.query(tbl);
      return res;
    } on Exception catch (e) {
      print("Exception in getAll: $e");
      return null;
    }
  }

  // select by id
  Future<Map<String, dynamic>?> getById(String tableName, int id, {String pkName = "Id"}) async{
    try {
      Database db = await database;
      var result= await db.query(tableName,where: "$pkName = ?", whereArgs: [id]);
      return result.isNotEmpty ? result.first : null;
    } on Exception catch (e) {
      print("Exception in getById: ${e}");
      return null;
    }

  }

  //function add to database table
  Future<int> add(String tbl, Map<String, dynamic> obj)async{
    try {
      Database db = await database;
      var res = await db.insert(tbl, obj, conflictAlgorithm: ConflictAlgorithm.ignore );
      return res;
    } on Exception catch (e) {
      print("EXP in Insert : ${e}");
      return 0;
    }
  }

  //function update data in database table
  Future<int> update(String tbl, Map<String, dynamic> obj, {String pkName = 'Id'})async{
    try {
      Database db = await database;
      var pkValue = obj[pkName];
      if(pkValue != null){
        var res = await db.update(tbl, obj, where: '$pkName = ?', whereArgs: [pkValue], conflictAlgorithm: ConflictAlgorithm.ignore);
        return res;
      }
      return 0;
    } on Exception catch (e) {
      print("EXP in update : ${e}");
      return 0;
    }
  }

  // function delete data from database table
  Future<int> delete(String tbl,Object pkValue, {String pkName = 'Id'})async{
    try {
      Database db = await database;
      if(pkValue != null){
        var res = await db.delete(tbl, where: '$pkName = ?', whereArgs: [pkValue]);
        return res;
      }
      return 0;
    } on Exception catch (e) {
      print("EXP in delete : ${e}");
      return 0;
    }
  }

}

