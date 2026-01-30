import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Album myNewAlbum = Album(userId: 1, id: 101, title: 'A New Album Title');
  print('Successfully created Album instance: ${myNewAlbum.title}');

  createAlbum(myNewAlbum);
  print(myNewAlbum.id);
  Album someAlbum = await fetchAlbum(1);
  print(someAlbum.userId);
  print(someAlbum.id);
  print(someAlbum.title);
}

class Album {
  final int userId;
  int id;
  final String title;

  Album({required this.userId, this.id = 0, required this.title});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title};
  }

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(userId: userId, id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void createAlbum(Album album) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode(album.toJson()),
  );

  switch (response.statusCode) {
    case 201:
      Album albumResponse = Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      album.id = albumResponse.id;
      break;
    case 409:
      throw Exception('User already exists');
    default:
      throw Exception('Failed to create album (user for uni project)');
  }
}

Future<Album> fetchAlbum(int id) async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/${id}'));

  switch (response.statusCode) {
    case 200:
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    case 404:
      print('User not found, dumbass');
      throw Exception('User not found');
    default:
      throw Exception('Failed to fetch album (user for uni project)');
  }
}
