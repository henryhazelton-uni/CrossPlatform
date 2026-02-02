import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crossplatform_assessement_two_app/models/maintenance_log.dart';
import 'package:crossplatform_assessement_two_app/networking/log_api.dart';

// Save a log to local storage when offline
Future<void> saveLogLocally(MaintenanceLog log) async {
  var storageBox = Hive.box('pendingLogs');
  var jsonLog = log.toJson();
  storageBox.add(jsonLog);
}

// Get all pending (unsynced) logs from local storage
List<MaintenanceLog> getPendingLogs() {
  var storageBox = Hive.box('pendingLogs');
  List<MaintenanceLog> logs = [];

  for (var item in storageBox.values) {
    // Convert the hive map to regular map
    var map = Map<String, dynamic>.from(item);
    logs.add(
      MaintenanceLog(
        title: map['title'],
        description: map['description'],
        priority: map['priority'],
        status: map['status'],
        userId: map['user_id'],
        isSynced: false,
      ),
    );
  }

  return logs;
}

// Push all pending logs to the server, remove from local storage on success
Future<void> syncPendingLogs() async {
  if (!await isOnline()) {
    return;
  }
  var storageBox = Hive.box('pendingLogs');
  // These keys will be deleted during the loop
  var keys = storageBox.keys.toList();

  for (var key in keys) {
    var map = Map<String, dynamic>.from(storageBox.get(key));
    var log = MaintenanceLog(
      title: map['title'],
      description: map['description'],
      priority: map['priority'],
      status: map['status'],
      userId: map['user_id'],
    );

    try {
      await createLog(log);
      await storageBox.delete(key);
    } catch (e) {
      // If this log fails to sync, skip it and try again next time
    }
  }
}

// Check if the device has network connectivity
Future<bool> isOnline() async {
  var result = await Connectivity().checkConnectivity();
  return !result.contains(ConnectivityResult.none);
}
