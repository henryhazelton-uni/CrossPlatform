class User {
  final int id;
  String userName;
  final String password;

  User({this.id = 0, this.userName = "", this.password = ""});

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': userName, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'username': String userName} => User(id: id, userName: userName),
      _ => throw const FormatException('Failed to load user.'),
    };
  }
}
