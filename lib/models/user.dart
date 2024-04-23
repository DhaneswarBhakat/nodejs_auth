import 'dart:convert';

/// The class `User` in Dart represents a user entity with properties such as id, name, email, token,
/// and password.
class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final String password;

/// The `User` class constructor in Dart is using named parameters with required keyword to specify that
/// these parameters are mandatory when creating an instance of the `User` class. This means that when
/// creating a new `User` object, you must provide values for `id`, `name`, `email`, `token`, and
/// `password` properties. If any of these parameters are not provided, it will result in a compile-time
/// error.
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.token,
      required this.password});


/// The `toMap` function converts object properties to a map with string keys and dynamic values.
/// 
/// Returns:
///   A Map<String, dynamic> is being returned with keys 'name', 'email', 'token', and 'password', each
/// mapped to their respective values in the current object.
Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'password': password,
    };
  }

/// The `User.fromMap` factory method creates a User object from a map of key-value pairs.
/// 
/// Args:
///   map (Map<String, dynamic>): The `map` parameter in the `User.fromMap` factory method is a `Map`
/// object that contains key-value pairs where the keys are `String` and the values are `dynamic`. This
/// method is used to create a `User` object by extracting values from the map based on specific keys
/// 
/// Returns:
///   The `User` object is being returned with properties `id`, `name`, `email`, `token`, and `password`
/// initialized with values from the `map` parameter. If a key is not found in the `map`, empty strings
/// are used as default values.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
    );
  }

/// The `toJson` function converts an object to a JSON string using the `json.encode` method.
  String toJson() => json.encode(toMap());

/// The function `fromJson` in the `User` class is a factory constructor that creates a `User` object
/// from a JSON string by decoding it into a map.
/// 
/// Args:
///   source (String): The `source` parameter in the `fromJson` method is a string that contains the
/// JSON data representing a user object. This method is used to create a `User` object by decoding the
/// JSON data from the `source` string.
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

