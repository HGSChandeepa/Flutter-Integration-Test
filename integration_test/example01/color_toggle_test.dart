import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_tester/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Color toggle test', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Verify initial color is green
    final container = find.byKey(const Key('color_container'));
    expect(
      tester.widget<Container>(container).color,
      equals(Colors.green),
    );

    // Find and tap toggle button
    final button = find.byKey(const Key('toggle_button'));
    await tester.tap(button);
    await tester.pumpAndSettle();

    // Verify color changed
    expect(
      tester.widget<Container>(container).color,
      isNot(equals(Colors.green)),
    );
  });
}
