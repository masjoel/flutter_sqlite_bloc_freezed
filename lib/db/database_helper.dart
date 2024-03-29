import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_bloc/model/category_model.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  // DatabaseHelper._privateConstructor();
  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL
          )
          ''');
    });
  }

  Future<int> insertTodo(CategoryModel categoryModel) async {
    final db = await database;
    return await db.insert('todos', categoryModel.toMap());
  }

  Future<int> updateTodo(CategoryModel categoryModel) async {
    var db = await database;
    return await db.update('todos', categoryModel.toMap(),
        where: 'id = ?', whereArgs: [categoryModel.id]);
  }

  Future<List<CategoryModel>> getTodos() async {
    final db = await database;
    final results = await db.query('todos');
    return results.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<int> deleteTodo(int id) async {
    var db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  // Future close() async {
  //   var db = await database;
  //   db.close();
  // }
}
