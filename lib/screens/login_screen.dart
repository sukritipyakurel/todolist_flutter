import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';
import 'todo_list_screen.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: _usernameController, label: 'Username'),
            CustomTextField(controller: _passwordController, label: 'Password', obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final success = authService.login(
                  _usernameController.text.trim(),
                  _passwordController.text.trim(),
                );
                if (success) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TodoListScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid login')));
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
