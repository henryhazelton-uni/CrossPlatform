// Maintenance Log Data Model

class MaintenanceLog {
  String title;
  String description;
  String priority;
  String status;
  int userId;
  int logId;
  String dateCreated;
  String dateUpdated;

  MaintenanceLog({
    this.title = "",
    this.description = "",
    this.priority = "",
    this.status = "",
    this.userId = 0,
    this.logId = 0,
    this.dateCreated = "",
    this.dateUpdated = "",
  });

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'priority': priority, 'status': status, 'user_id': userId};
  }

  factory MaintenanceLog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int logId,
        'title': String title,
        'description': String description,
        'priority': String priority,
        'status': String status,
        'user_id': int userId, // dont need userid from server only when sending
        'created_at': String dateCreated,
        'updated_at': String dateUpdated,
      } =>
        MaintenanceLog(
          logId: logId,
          title: title,
          description: description,
          priority: priority,
          status: status,
          userId: userId,
          dateCreated: dateCreated,
          dateUpdated: dateUpdated,
        ), // unsure what goes in both of these things
      _ => throw const FormatException('Failed to load maintenance log.'),
    };
  }
}
