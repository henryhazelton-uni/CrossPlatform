class User {
  final int userId;
  String userName;
  final String password;

  User({this.userId = 0, required this.userName, required this.password});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'username': userName, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'username': String userName, 'password': String password} => User(
        userId: userId,
        userName: userName,
        password: password,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
