// Widget class to handle making user names
// see flutter documentation - https://docs.flutter.dev/learn/pathway/tutorial/user-input#:~:text=The%20simplest%20way%20to%20react,the%20text%20field%20has%20focus.

import 'package:flutter/material.dart';

class UserNameInput extends StatefulWidget {
  const UserNameInput({super.key, required this.onSubmitEntry});
  final void Function(String) onSubmitEntry; // this will be the function to take the users input, returns nothing

  @override
  State<UserNameInput> createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  // This is responsible for controlling the text stuff
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 12,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35)))),
        controller: _textEditingController, // Ability to capture text in this line
        autofocus: true,
        focusNode: _focusNode,
        onChanged: (String input) {
          // This takes the input when user presses enter on the keyboard
          widget.onSubmitEntry(input);
        },
      ),
    );
  }
}
