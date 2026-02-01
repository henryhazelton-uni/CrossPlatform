import 'package:crossplatform_assessement_two_app/models/user_payload.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() async {
//   User myNewUser = User(userId: 1, id: 101, password: 'password');
//   print('Successfully created User instance: ${myNewUser.password}');

//   createUser(myNewUser);
//   print(myNewUser.id);
//   User someUser = await fetchUser(1);
//   print(someUser.userId);
//   print(someUser.id);
//   print(someUser.password);
// }

Future<User> createUser(User user) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/v1/users'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(user.toJson()),
  );

  switch (response.statusCode) {
    case 201:
      var responseData = jsonDecode(response.body);
      return User.fromJson(responseData as Map<String, dynamic>);
    case 409:
      throw Exception('User already exists');
    default:
      throw Exception('Failed to create user');
  }
}

Future<User> fetchUser(User user) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/Users/$user.id'));

  switch (response.statusCode) {
    case 200:
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    case 404:
      throw Exception('User not found');
    default:
      throw Exception('Failed to fetch User (user for uni project)');
  }
}

Future<int> loginUser(User user) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api/v1/users/login'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(user.toJson()),
  );

  switch (response.statusCode) {
    case 200:
      var responseData = jsonDecode(response.body);
      var userData = responseData['user'];
      var user = User.fromJson(userData);
      return user.id;
    case 401:
      throw Exception('Invalid username or password');
    case 400:
      throw Exception('Username and password are required');
    default:
      throw Exception('Failed to login');
  }
}
