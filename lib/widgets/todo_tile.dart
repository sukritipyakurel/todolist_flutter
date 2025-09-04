import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';
import '../screens/add_edit_todo_screen.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todoService = Provider.of<TodoService>(context);

    return ListTile(
      title: Text(todo.title,
          style: TextStyle(
              decoration:
                  todo.isCompleted ? TextDecoration.lineThrough : null)),
      subtitle: Text(todo.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: todo.isCompleted,
            onChanged: (val) {
              todo.isCompleted = val!;
              todoService.updateTodo(todo);
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddEditTodoScreen(todo: todo))),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final todoService =
                  Provider.of<TodoService>(context, listen: false);
              final result = await todoService.deleteTodo(todo.id);
              if (result != null) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(result)));
              }
            },
          ),
        ],
      ),
    );
  }
}
