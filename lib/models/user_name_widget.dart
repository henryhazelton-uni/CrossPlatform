// Widget class to handle making user names
// see flutter documentation - https://docs.flutter.dev/learn/pathway/tutorial/user-input#:~:text=The%20simplest%20way%20to%20react,the%20text%20field%20has%20focus.

import 'package:flutter/material.dart';

class UserNameInput extends StatelessWidget {
  UserNameInput({super.key, required this.onSubmitEntry});

  final void Function(String) onSubmitEntry; // this will be the function to take the users input, returns nothing

  // This is responsible for controlling the text stuff
  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  void _onSubmit() {
    onSubmitEntry(_textEditingController.text);
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 12,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(35))),
              ),
              controller: _textEditingController, // Ability to capture text in this line
              autofocus: true,
              focusNode: _focusNode,
              onSubmitted: (String input) {
                // This takes the input when user presses enter on the keyboard
                _onSubmit();
              },
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_circle_up),
          onPressed: () {
            _onSubmit();
          },
        ),
      ],
    );
  }
}
