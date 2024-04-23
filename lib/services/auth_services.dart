import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nodejs_auth/models/user.dart';
import 'package:nodejs_auth/providers/user_provider.dart';
import 'package:nodejs_auth/screens/home_screen.dart';
import 'package:nodejs_auth/screens/signup_screen.dart';
import 'package:nodejs_auth/utils/constants.dart';
import 'package:nodejs_auth/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        token: '',
      );

/// This code snippet is sending a POST request to the specified URL `${Constants.uri}/api/signup` with
/// the user data in the body of the request. Here's a breakdown of what each part is doing:
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

/// The `httpErrorHandle` function is being called with the `response`, `context`, and `onSuccess`
/// parameters.
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } /// The above function catches an error and displays it as a snack bar message in a Dart
    /// application.
    /// 
    /// Args:
    ///   e: The parameter "e" typically represents an error object in a try-catch block in
    /// programming languages like JavaScript or Dart. When an error occurs within the try block, it
    /// is caught and stored in the variable "e" for further handling or logging. In the provided code
    /// snippet, the error message is
    catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
/// This code snippet is sending a POST request to the specified URL `${Constants.uri}/api/signin` with
/// the user's email and password in the body of the request. Here's a breakdown of what each part is
/// doing:
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
/// The `httpErrorHandle` function in the provided code snippet is being called with specific
/// parameters: `response`, `context`, and an `onSuccess` callback function. Here's a breakdown of what
/// this code block is doing:
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${Constants.uri}/'),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'x-auth-token': token},
        );
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

/// The `signOut` function signs the user out by clearing the authentication token and navigating to the
/// SignupScreen while removing all previous routes.
/// 
/// Args:
///   context (BuildContext): The `context` parameter in the `signOut` function is a reference to the
/// BuildContext of the widget that called the function. It is typically used to access information
/// about the current widget's location in the widget tree and to perform operations like navigating to
/// a new screen or accessing inherited widget data.
  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
      (route) => false,
    );
  }
}