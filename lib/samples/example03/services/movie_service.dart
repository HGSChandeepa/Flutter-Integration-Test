import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integration_tester/samples/example03/models/movie.dart';

class MovieService {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = '3fc8eb21e52fa176999b3a9b7851d167';

  Future<List<Movie>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    }
    throw Exception('Failed to load movies');
  }
}
