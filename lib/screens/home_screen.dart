import 'package:flutter/material.dart';
import 'package:nodejs_auth/providers/user_provider.dart';
import 'package:nodejs_auth/services/auth_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user.id),
          Text(user.email),
          Text(user.name),
          /// This code snippet is creating an `ElevatedButton` widget with the following properties:
          ElevatedButton(
            onPressed: () => signOutUser(context),
            /// This code snippet is defining the style properties for the `ElevatedButton` widget in
            /// Flutter. Here's a breakdown of what each property does:
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
/// The code snippet `minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width /
/// 2.5, 50)),` is setting the minimum size of the `ElevatedButton` widget.
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
/// The code snippet `child: const Text("Sign Out", style: TextStyle(color: Colors.white, fontSize:
/// 16),),` is defining the child widget of the `ElevatedButton`. In this case, it is setting the text
/// displayed on the button to "Sign Out" with a specific style. The `Text` widget is used to display
/// text within the button, and the provided `TextStyle` specifies the color of the text as white and
/// sets the font size to 16.
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}