import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/todo_service.dart';
import '../widgets/todo_tile.dart';
import 'add_edit_todo_screen.dart';
import 'completed_list_screen.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = Provider.of<TodoService>(context);
    todoService.fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CompletedListScreen())),
          )
        ],
      ),
      body: Consumer<TodoService>(
        builder: (_, service, __) {
          return ListView.builder(
            itemCount: service.todos.length,
            itemBuilder: (_, index) => TodoTile(todo: service.todos[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddEditTodoScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
