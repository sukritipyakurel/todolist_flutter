import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  Box<UserModel> userBox = Hive.box<UserModel>('users');
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool login(String username, String password) {
    final user = userBox.values.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => UserModel(username: '', password: ''),
    );
    if (user.username != '') {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool signup(String username, String password) {
    if (userBox.values.any((u) => u.username == username)) return false;
    final user = UserModel(username: username, password: password);
    userBox.add(user);
    _currentUser = user;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
