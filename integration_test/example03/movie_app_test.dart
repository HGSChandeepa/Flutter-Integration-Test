import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tester/samples/example03/models/movie.dart';
import 'package:integration_tester/samples/example03/screens/movies_screen.dart';
import 'package:integration_tester/samples/example03/services/movie_service.dart';

/// Mock implementation of [MovieService]
class MockMovieService extends MovieService {
  List<Movie>? _mockedMovies;
  Exception? _mockedError;

  void mockGetPopularMovies(List<Movie> movies) {
    _mockedMovies = movies;
    _mockedError = null;
  }

  void mockError(Exception error) {
    _mockedError = error;
    _mockedMovies = null;
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    if (_mockedError != null) {
      throw _mockedError!;
    }
    return _mockedMovies ?? [];
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockMovieService mockMovieService;

  // Set up a mock movie service with test data
  setUp(() {
    mockMovieService = MockMovieService();
    mockMovieService.mockGetPopularMovies([
      Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: '', // Use an empty path or mock URL to avoid network errors
        rating: 8.5,
      ),
    ]);
  });

  // Create a test app with the mock service
  Widget createTestApp() => MaterialApp(
        home: MovieScreen(movieService: mockMovieService),
      );

  /// Test: Initial loading state
  testWidgets('Test 1: Initial loading state', (tester) async {
    await tester.pumpWidget(createTestApp());
    expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
  });

  /// Test: Successful movie load
  testWidgets('Test 2: Successful movie load', (tester) async {
    mockMovieService.mockGetPopularMovies([
      Movie(
        id: 1,
        title: 'Test Movie',
        overview: 'Test Overview',
        posterPath: '', // Use an empty path to prevent network loading
        rating: 8.5,
      ),
    ]);

    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle(); // Allow full tree settlement
    expect(find.text('Test Movie'), findsOneWidget);
  });

  /// Test: Error handling
  testWidgets('Test 3: Error handling', (tester) async {
    mockMovieService.mockError(Exception('Network error'));
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();
    expect(find.text('Failed to load movies'), findsOneWidget);
  });

  /// Test: Handle empty movie list
  testWidgets('Test 4: Handle empty movie list', (tester) async {
    mockMovieService.mockGetPopularMovies([]); // Mock empty movie list
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();
    // verify that there are no list items
    expect(find.byType(ListTile), findsNothing);
  });

  /// Test: Verify movie list item details
  testWidgets('Test 5: Verify movie details', (tester) async {
    mockMovieService.mockGetPopularMovies([
      Movie(
        id: 2,
        title: 'Sample Movie',
        overview: 'Sample Overview',
        posterPath: '', // Empty for test
        rating: 9.0,
      ),
    ]);

    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Sample Movie'), findsOneWidget);
    expect(find.text('Sample Overview'), findsOneWidget);
  });

  /// Test: Verify multiple movies in list
  testWidgets('Test 6: Multiple movies display', (tester) async {
    mockMovieService.mockGetPopularMovies([
      Movie(
        id: 1,
        title: 'Movie 1',
        overview: 'Overview 1',
        posterPath: '', // Empty for test
        rating: 7.5,
      ),
      Movie(
        id: 2,
        title: 'Movie 2',
        overview: 'Overview 2',
        posterPath: '', // Empty for test
        rating: 8.5,
      ),
    ]);

    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Movie 1'), findsOneWidget);
    expect(find.text('Movie 2'), findsOneWidget);
  });
}
