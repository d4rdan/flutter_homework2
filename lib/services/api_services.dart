import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/joke.dart';
import '../models/joke_type.dart';

class ApiService {
  static const baseUrl = 'https://official-joke-api.appspot.com';

  // Fetch joke types
  static Future<List<JokeType>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    
    if (response.statusCode == 200) {
      List<dynamic> types = json.decode(response.body);
      return types.map((type) => JokeType.fromJson(type)).toList();
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  // Fetch jokes by type
  static Future<List<Joke>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    
    if (response.statusCode == 200) {
      List<dynamic> jokesJson = json.decode(response.body);
      return jokesJson.map((jokeJson) => Joke.fromJson(jokeJson)).toList();
    } else {
      throw Exception('Failed to load jokes for type $type');
    }
  }

  // Fetch random joke
  static Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    
    if (response.statusCode == 200) {
      return Joke.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}