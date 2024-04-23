import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// The function `showSnackBar` displays a SnackBar with the provided text in a given BuildContext.
/// 
/// Args:
///   context (BuildContext): The `context` parameter in the `showSnackBar` function is typically the
/// `BuildContext` object that is used to locate the nearest `Scaffold` widget in the widget tree. This
/// context is necessary for showing the `SnackBar` within the appropriate `Scaffold` widget.
///   text (String): The `text` parameter is a string that represents the message or text content that
/// will be displayed in the SnackBar.
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

/// The function `httpErrorHandle` handles different HTTP response status codes by executing specific
/// actions based on the status code.
/// 
/// Args:
///   response (http): The `response` parameter is of type `http.Response` and contains the response
/// data received from an HTTP request.
///   context (BuildContext): The `context` parameter in the `httpErrorHandle` function is of type
/// `BuildContext`. It is typically used in Flutter to provide information about the location of the
/// widget within the widget tree. This context is necessary for showing a SnackBar in the current
/// widget's context.
///   onSuccess (VoidCallback): The `onSuccess` parameter is a `VoidCallback` type, which is a function
/// that takes no arguments and returns void. It is a callback function that will be executed when the
/// HTTP response status code is 200 (OK).
void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}