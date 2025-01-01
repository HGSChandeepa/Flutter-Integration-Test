import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_tester/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration Tests for Color Screen', () {
    testWidgets('Test 1: Initial state verification',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Click Count: 0'), findsOneWidget);

      final container = tester
          .widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      expect(container.decoration, BoxDecoration(color: Colors.green));
      expect(container.constraints!.maxWidth, 200.0); // Medium size
    });

    testWidgets('Test 2: Color toggle and counter increment',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final initialContainer = tester
          .widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      final initialColor = (initialContainer.decoration as BoxDecoration).color;

      await tester.tap(find.byKey(const Key('toggle_button')));
      await tester.pumpAndSettle();

      final updatedContainer = tester
          .widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      final newColor = (updatedContainer.decoration as BoxDecoration).color;

      expect(find.text('Click Count: 1'), findsOneWidget);
      expect(newColor, isNot(equals(initialColor)));
    });

    testWidgets('Test 3: Counter visibility toggle',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byKey(const Key('click_counter')), findsOneWidget);

      await tester.tap(find.byKey(const Key('visibility_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('click_counter')), findsNothing);
    });

    testWidgets('Test 4: Size changes', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byKey(const Key('size_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Large'));
      await tester.pumpAndSettle();

      final container = tester
          .widget<AnimatedContainer>(find.byKey(const Key('color_container')));
      expect(container.constraints!.maxWidth, 300.0);
    });
  });
}
