import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            isCompleted INTEGER NOT NULL,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertTodo(TodoModel todo) async {
    final db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<TodoModel>> getTodos({bool completed = false}) async {
    final db = await database;
    final maps = await db.query('todos',
        where: 'isCompleted = ?', whereArgs: [completed ? 1 : 0]);
    return List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  Future<int> updateTodo(TodoModel todo) async {
    final db = await database;
    return await db.update('todos', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
