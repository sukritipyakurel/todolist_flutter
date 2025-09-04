import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/todo_service.dart';
import '../widgets/todo_tile.dart';

class CompletedListScreen extends StatelessWidget {
  const CompletedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoService = Provider.of<TodoService>(context);
    todoService.fetchTodos(completed: true);

    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Consumer<TodoService>(
        builder: (_, service, __) {
          return ListView.builder(
            itemCount: service.todos.length,
            itemBuilder: (_, index) => TodoTile(todo: service.todos[index]),
          );
        },
      ),
    );
  }
}
