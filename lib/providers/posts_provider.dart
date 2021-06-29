import 'dart:convert';
import 'dart:io';
import 'package:easystory/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:easystory/models/post.dart';

class PostsProvider {
  Future<String> getAuthToken() async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    http.Response auth = await http.post(Uri.parse(requestUrl + "auth/sign-in"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': 'admin', 'password': 'admin'}));
    return (json.decode(auth.body))['token'];
  }

  Future<Post> create(String urlOption) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Post.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<List> getAll(String urlOption) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption);
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final arrayMap = jsonResponse['content'];
      List items = arrayMap.map((map) => Post.fromJson(map)).toList();
      return items;
    } else {
      throw Exception('Failed request');
    }
  }

  Future<Post> getOne(String urlOption, int id) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption + "$id");
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return Post.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }

  Future<User> getAuthor(String urlOption, int id) async {
    final requestUrl = "https://easystory-api.herokuapp.com/api/";
    final url = Uri.parse(requestUrl + urlOption + "$id");
    final token = await getAuthToken();
    http.Response result = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Failed request');
    }
  }
}
