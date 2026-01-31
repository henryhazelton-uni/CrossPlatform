// Screen to create an account and take in user inputs

import 'dart:ui';

import 'package:crossplatform_assessement_two_app/main.dart';
import 'package:crossplatform_assessement_two_app/models/user_name_widget.dart';
import 'package:crossplatform_assessement_two_app/models/user_password_widget.dart';
import 'package:crossplatform_assessement_two_app/networking/user_api.dart';
import 'package:crossplatform_assessement_two_app/models/user_payload.dart';
import 'package:crossplatform_assessement_two_app/pages/menus/screen_two.dart';

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String displayText = 'Hello from Signup Screen!!';
  int buttonPressCount = 0;
  // Add some variables to store values
  String _userName = "";
  String _userPassword = "";

  static const snackBar = SnackBar(content: Text('Successfully created an account!'));

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
            const Text('Create an account!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                User newUser = User(userName: _userName, password: _userPassword);
                await createUser(newUser);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenTwo()));
              },
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
              child: const Text('Create Account'), // Will need to create new screens for login/sign up
            ),
          ],
        ),
      ),
    );
  }
}
