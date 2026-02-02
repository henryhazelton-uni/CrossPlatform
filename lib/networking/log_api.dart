// A place to handle all the functions for creating, editing, and deleting logs

import 'dart:convert';

import 'package:crossplatform_assessement_two_app/models/maintenance_log.dart';
import 'package:crossplatform_assessement_two_app/networking/offline_log_service.dart';
import 'package:http/http.dart' as http;

Future<MaintenanceLog> createLog(MaintenanceLog maintenanceLog) async {
  try {
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
        throw Exception('Failed to create maintenance log');
    }
  } catch (e) {
    // Network failed, back up locally
    await saveLogLocally(maintenanceLog);
    maintenanceLog.isSynced = false;
    return maintenanceLog;
  }
}

Future<List<MaintenanceLog>> getMaintenanceLogs(int userId) async {
  final response = await http.get(
    Uri.parse('http://localhost:5000/api/v1/logs'),
    headers: {'X-API-Key': 'api_warehouse_student_key_1234567890abcdef'},
  );

  switch (response.statusCode) {
    case 200:
      List<dynamic> responseData = jsonDecode(response.body);
      List<MaintenanceLog> logEntries = responseData
          .map((e) => MaintenanceLog.fromJson(e))
          .where((log) => log.userId == userId)
          .toList();
      return logEntries;
    default:
      throw Exception('Failed to fetch logs');
  }
}

Future<MaintenanceLog> getIndvidualLog(int logId) async {
  final response = await http.get(
    Uri.parse('http://localhost:5000/api/v1/logs/$logId'),
    headers: {'X-API-Key': 'api_warehouse_student_key_1234567890abcdef'},
  );

  switch (response.statusCode) {
    case 200:
      return MaintenanceLog.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    default:
      throw Exception('Failed to fetch log');
  }
}
