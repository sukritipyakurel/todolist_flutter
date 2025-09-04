import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'screens/login_screen.dart';

import 'services/auth_service.dart';
import 'services/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('users');
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TodoService()),
      ],
      child: MaterialApp(
        title: 'Flutter ToDo App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
      ),
    );
  }
}
