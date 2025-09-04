import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../services/todo_service.dart';
import '../widgets/custom_text_field.dart';

class AddEditTodoScreen extends StatelessWidget {
  final TodoModel? todo;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  AddEditTodoScreen({super.key, this.todo}) {
    if (todo != null) {
      _titleController.text = todo!.title;
      _descController.text = todo!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(todo == null ? 'Add Todo' : 'Edit Todo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: _titleController, label: 'Title'),
            CustomTextField(controller: _descController, label: 'Description'),
            SizedBox(height: 20),
             ElevatedButton(
              onPressed: () async {
                final newTodo = TodoModel(
                  id: todo?.id,
                  title: _titleController.text.trim(),
                  description: _descController.text.trim(),
                  isCompleted: todo?.isCompleted ?? false,
                );

                final todoService = Provider.of<TodoService>(context, listen: false);

                String? result;
                if (todo == null) {
                  result = await todoService.addTodo(newTodo);
                } else {
                  result = await todoService.updateTodo(newTodo);
                }

                if (result != null) {
                  // show alert
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: Text(todo == null ? 'Add' : 'Update'),
            ),

          ],
        ),
      ),
    );
  }
}
