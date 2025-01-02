import 'package:flutter/material.dart';
import 'package:integration_tester/samples/example03/models/movie.dart';
import 'package:integration_tester/samples/example03/services/movie_service.dart';

class MovieScreen extends StatefulWidget {
  final MovieService movieService;
  const MovieScreen({
    super.key,
    required this.movieService,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late MovieService _movieService;
  List<Movie> _movies = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _movieService =
        widget.movieService; // Ensure service is initialized correctly
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    if (!mounted) return;
    try {
      setState(() => _isLoading = true);
      final movies = await _movieService.getPopularMovies();
      if (!mounted) return;
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load movies';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        backgroundColor: Colors.yellow[400],
        actions: [
          IconButton(
            key: const Key('refresh_button'),
            icon: const Icon(Icons.refresh),
            onPressed: _loadMovies,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        key: Key('loading_indicator'),
        child: CircularProgressIndicator(),
      );
    }
    if (_error != null) {
      return Center(
        key: const Key('error_message'),
        child: Text(_error!),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadMovies,
      child: ListView.builder(
        key: const Key('movies_list'),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.yellow[100],
            ),
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  key: Key('movie${movie.id}'),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  trailing: Text('★ ${movie.rating.toStringAsFixed(1)}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
