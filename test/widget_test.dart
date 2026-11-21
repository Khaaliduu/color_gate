import 'package:color_gate/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('COLOR GATE app launches successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ColorGateApp());

    // Verify that the application starts.
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify the application title.
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.title, 'COLOR GATE');

    // Verify that no immediate Flutter exception occurred.
    expect(tester.takeException(), isNull);
  });
}
