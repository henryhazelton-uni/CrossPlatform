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

Future<void> createUser(User user) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/Users'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(user.toJson()),
  );

  switch (response.statusCode) {
    case 201:
      User userResponse = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      user.userName = userResponse.userName;
      break;
    case 409:
      throw Exception('User already exists');
    default:
      throw Exception('Failed to create User (user for uni project)');
  }
}

Future<User> fetchUser(int id) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/Users/$id'));

  switch (response.statusCode) {
    case 200:
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    case 404:
      print('User not found, dumbass');
      throw Exception('User not found');
    default:
      throw Exception('Failed to fetch User (user for uni project)');
  }
}
