import 'package:flutter/material.dart';
import 'package:nodejs_auth/models/user.dart';

/// The UserProvider class in Dart initializes a User object with empty values.
class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  );

/// In the Dart code snippet provided, `User get user => _user;` is a getter method in the
/// `UserProvider` class.
  User get user => _user;

/// The function `setUser` sets the user data by converting a JSON string to a User object and then
/// notifies listeners.
/// 
/// Args:
///   user (String): The `user` parameter in the `setUser` method is a string that represents user data
/// in JSON format. The method converts this JSON string into a `User` object using the `User.fromJson`
/// method and then notifies any listeners of the change.
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

/// The function `setUserFromModel` sets the user data and notifies listeners in Dart.
/// 
/// Args:
///   user (User): The `user` parameter in the `setUserFromModel` method is of type `User`. It is used
/// to update the `_user` variable with the new user information and then notify any listeners that the
/// user data has changed.
  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}