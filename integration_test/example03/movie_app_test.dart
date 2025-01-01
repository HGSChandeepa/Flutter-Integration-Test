import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_tester/samples/example03/models/movie.dart';
import 'package:integration_tester/samples/example03/screens/movies_screen.dart';
import 'package:integration_tester/samples/example03/services/movie_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MovieService])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockMovieService mockMovieService;

  setUp(() {
    mockMovieService = MockMovieService();
    when(mockMovieService.getPopularMovies()).thenAnswer((_) async => [
          Movie(
            id: 1,
            title: 'Test Movie',
            overview: 'Test Overview',
            posterPath: '/test.jpg',
            rating: 8.5,
          ),
        ]);
  });

  Widget createTestApp() => MaterialApp(
        home: MovieScreen(movieService: mockMovieService),
      );

  testWidgets('Test 1: Initial loading state', (tester) async {
    await tester.pumpWidget(createTestApp());
    expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
  });

  testWidgets('Test 2: Successful movie load', (tester) async {
    when(mockMovieService.getPopularMovies()).thenAnswer((_) async => [
          Movie(
              id: 1,
              title: 'Test Movie',
              overview: 'Test Overview',
              posterPath: '/test.jpg',
              rating: 8.5),
        ]);

    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('Test Movie'), findsOneWidget);
  });

  testWidgets('Test 4: Error handling', (tester) async {
    when(mockMovieService.getPopularMovies())
        .thenAnswer((_) async => throw Exception('Network error'));

    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Failed to load movies'), findsOneWidget);
  });
}
