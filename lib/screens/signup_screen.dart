import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(controller: _usernameController, label: 'Username'),
            CustomTextField(controller: _passwordController, label: 'Password', obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final success = authService.signup(
                  _usernameController.text.trim(),
                  _passwordController.text.trim(),
                );
                if (success) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username already exists')));
                }
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
