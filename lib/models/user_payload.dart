class User {
  final int userId;
  int id;
  final String password;

  User({required this.userId, this.id = 0, required this.password});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'password': password};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'password': String password} => User(
        userId: userId,
        id: id,
        password: password,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
