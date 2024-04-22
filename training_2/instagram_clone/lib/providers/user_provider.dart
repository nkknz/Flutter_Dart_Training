import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

//refreshes and notify users about the changes
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    //notifyListeners() this notifies listeners to this user provide that the data of the global variable has changed
    notifyListeners();
  }
}
