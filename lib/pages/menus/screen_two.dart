// Screen Two
// Going to be the place to manage logs

import 'package:crossplatform_assessement_two_app/models/maintenance_log.dart';
import 'package:crossplatform_assessement_two_app/networking/log_api.dart';
import 'package:flutter/material.dart';

class ScreenTwo extends StatefulWidget {
  final int userId;
  const ScreenTwo({super.key, required this.userId});
  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  // add a list to hold all the logs in
  List<MaintenanceLog> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() async {
    try {
      List<MaintenanceLog> logs = await getMaintenanceLogs();
      setState(() {
        _logs = logs;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  final TextEditingController _textController = TextEditingController();
  String userMessage = 'Enter text below and press submit';
  bool isMessageVisible = true;

  // Create the log
  Future<void> _createLog() async {
    if (_textController.text.isEmpty) {
      return;
    }
    try {
      MaintenanceLog newLog = MaintenanceLog(
        title: _textController.text,
        description: 'A description of the log', // could add functionality in future
        priority: 'medium', // default to medium, could be used to update in future
        status: 'open', // can add functionality in future to change this
        userId: widget.userId, // this means the log is automatically assigned to the user the screen has
      );
      await createLog(newLog);
      _textController.clear();
      _loadLogs(); // refresh the logs showing
    } catch (e) {
      throw Exception(e);
    }
    // setState(() {
    //   if (_textController.text.isNotEmpty) {
    //     userMessage = 'You entered: ${_textController.text}';
    //   } else {
    //     userMessage = 'Please enter some text!';
    //   }
    // });
  }

  void toggleVisibility() {
    setState(() {
      isMessageVisible = !isMessageVisible;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Two'), backgroundColor: Colors.teal.shade700),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isMessageVisible)
              Card(
                elevation: 4,
                color: Colors.amber.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(userMessage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: const Icon(Icons.message),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: _createLog, child: const Text('Submit')),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _textController.clear();
                        userMessage = 'Enter text below and press submit';
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: toggleVisibility,
              icon: Icon(isMessageVisible ? Icons.visibility_off : Icons.visibility),
              label: Text(isMessageVisible ? 'Hide Message' : 'Show Message'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade600),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 2),
            const SizedBox(height: 10),

            // Display the logs here
            ..._logs.map(
              (log) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: ListTile(title: Text(log.title), subtitle: Text(log.description), trailing: Text(log.priority)),
              ),
            ),

            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Return to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
