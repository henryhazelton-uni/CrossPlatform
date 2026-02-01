// A place to handle all the functions for creating, editing, and deleting logs

import 'dart:convert';

import 'package:crossplatform_assessement_two_app/models/maintenance_log.dart';
import 'package:http/http.dart' as http;

Future<MaintenanceLog> createLog(MaintenanceLog maintenanceLog) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/v1/logs'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-API-Key': 'api_warehouse_student_key_1234567890abcdef',
    },
    body: jsonEncode(maintenanceLog.toJson()),
  );

  switch (response.statusCode) {
    case 201:
      var responseDate = jsonDecode(response.body);
      return MaintenanceLog.fromJson(responseDate as Map<String, dynamic>);
    case 400:
      throw Exception('Bad, faulty, request');
    default:
      throw Exception('Failed to create User (user for uni project)');
  }
}
