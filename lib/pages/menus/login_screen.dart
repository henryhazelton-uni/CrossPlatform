// Screen to create an account and take in user inputs

import 'package:crossplatform_assessement_two_app/main.dart';
import 'package:crossplatform_assessement_two_app/models/user_name_widget.dart';
import 'package:crossplatform_assessement_two_app/models/user_password_widget.dart';
import 'package:crossplatform_assessement_two_app/models/user_payload.dart';
import 'package:crossplatform_assessement_two_app/networking/user_api.dart';
import 'package:crossplatform_assessement_two_app/pages/menus/screen_two.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String displayText = 'Hello from Signup Screen!!';
  int buttonPressCount = 0;
  // Add some variables to store values
  String _userName = "";
  String _userPassword = "";

  // snack bar
  static const snackBar = SnackBar(content: Text('Successfully logged in!'));

  void updateText() {
    setState(() {
      buttonPressCount++;
      displayText = 'Button pressed $buttonPressCount times';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
        leading: Builder(
          builder: (context) => IconButton(icon: Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu Header', style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation or action
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation or action
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle navigation or action
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login to your account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            const SizedBox(height: 20),
            UserNameInput(
              onSubmitEntry: (String userName) {
                _userName = userName;
              },
            ),
            UserPasswordInput(
              onSubmitEntry: (String password) {
                _userPassword = password;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                User existingUser = User(userName: _userName, password: _userPassword);
                await loginUser(existingUser);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenTwo()));
              },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text('Login'), // Will need to create new screens for login/sign up
            ),
          ],
        ),
      ),
    );
  }
}
