import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/todo_model.dart';

class TodoService extends ChangeNotifier {
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  final db = DatabaseHelper();

  // Fetch todos from DB
  Future<void> fetchTodos({bool completed = false}) async {
    _todos = await db.getTodos(completed: completed);
    notifyListeners();
  }

  // Add a new todo with validations
  Future<String?> addTodo(TodoModel todo) async {
    if (todo.title.trim().isEmpty) return 'Title is required';

    // Check duplicate in DB
    final allTodos = await db.getTodos(completed: false);
    if (allTodos.any((t) => t.title.trim() == todo.title.trim())) {
      return 'Duplicate title';
    }

    await db.insertTodo(todo);
    await fetchTodos(completed: false);
    return null; // success
  }

  // Update todo with validations
  Future<String?> updateTodo(TodoModel todo) async {
    if (todo.title.trim().isEmpty) return 'Title is required';

    // Check duplicate excluding the current todo
    final allTodos = await db.getTodos();
    if (allTodos.any((t) => t.title.trim() == todo.title.trim() && t.id != todo.id)) {
      return 'Duplicate title';
    }

    await db.updateTodo(todo);
    await fetchTodos(completed: todo.isCompleted);
    return null; // success
  }

  // Delete todo with validations
  Future<String?> deleteTodo(int? id) async {
    if (id == null) return 'Invalid ID';

    final affectedRows = await db.deleteTodo(id);
    if (affectedRows == 0) return 'Todo does not exist';

    await fetchTodos();
    return null; // success
  }
}
