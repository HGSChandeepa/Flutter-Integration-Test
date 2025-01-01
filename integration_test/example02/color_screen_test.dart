
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_tester/main.dart';

void main() {
  // Initialize the integration test binding
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Group of integration tests for the Color Screen
  group('Integration Tests for Color Screen', () {
    
    // Test 1: Verify the initial state of the Color Screen
    testWidgets('Test 1: Initial state verification', (WidgetTester tester) async {
      // Build the MyApp widget and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify if the initial text is 'Click Count: 0'
      expect(find.text('Click Count: 0'), findsOneWidget);

      // Find the container by key and verify its initial properties
      final container = tester.widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      expect(container.decoration, BoxDecoration(color: Colors.green));
      expect(container.constraints!.maxWidth, 200.0); // Medium size
    });

    // Test 2: Verify the color toggle functionality and counter increment
    testWidgets('Test 2: Color toggle and counter increment', (WidgetTester tester) async {
      // Build the MyApp widget and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Find the initial container and get its color
      final initialContainer = tester.widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      final initialColor = (initialContainer.decoration as BoxDecoration).color;

      // Tap on the toggle button and trigger a frame
      await tester.tap(find.byKey(const Key('toggle_button')));
      await tester.pumpAndSettle();

      // Find the updated container and get its new color
      final updatedContainer = tester.widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      final newColor = (updatedContainer.decoration as BoxDecoration).color;

      // Verify if the counter is incremented and the color has changed
      expect(find.text('Click Count: 1'), findsOneWidget);
      expect(newColor, isNot(equals(initialColor)));
    });

    // Test 3: Verify the visibility toggle functionality of the counter
    testWidgets('Test 3: Counter visibility toggle', (WidgetTester tester) async {
      // Build the MyApp widget and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Verify if the counter is initially visible
      expect(find.byKey(const Key('click_counter')), findsOneWidget);

      // Tap on the visibility button and trigger a frame
      await tester.tap(find.byKey(const Key('visibility_button')));
      await tester.pumpAndSettle();

      // Verify if the counter is hidden
      expect(find.byKey(const Key('click_counter')), findsNothing);
    });

    // Test 4: Verify the size change functionality
    testWidgets('Test 4: Size changes', (WidgetTester tester) async {
      // Build the MyApp widget and trigger a frame
      await tester.pumpWidget(const MyApp());

      // Tap on the size dropdown and select 'Large'
      await tester.tap(find.byKey(const Key('size_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Large'));
      await tester.pumpAndSettle();

      // Find the container by key and verify its new size
      final container = tester.widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      expect(container.constraints!.maxWidth, 300.0);
    });
  });
}
