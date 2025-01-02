import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:integration_tester/samples/example03/models/movie.dart';

class MovieService {
  static const baseUrl = 'https://api.themoviedb.org/3';
  static const apiKey = 'API_KEY';

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
