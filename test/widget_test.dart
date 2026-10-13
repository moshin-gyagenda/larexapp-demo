import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:larexapp/main.dart';

void main() {
  testWidgets('Student can open an account and see home cards', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Campus Service Portal'), findsOneWidget);
    expect(find.text('Helpdesk for students and staff'), findsOneWidget);

    // The splash screen waits 2 seconds, then opens the welcome screen.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Create account'), findsOneWidget);

    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Amina');
    await tester.enterText(find.byType(TextField).at(1), 'amina@campus.ac.ug');
    await tester.enterText(find.byType(TextField).at(2), '1234');
    await tester.enterText(find.byType(TextField).at(3), '1234');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Create account'));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Amina'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('Services'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Estates'), findsOneWidget);
    expect(find.text('ICT'), findsOneWidget);

    await tester.tap(
      find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('Tickets'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No display in Hall B2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Contact'));
    await tester.pumpAndSettle();

    expect(find.text('helpdesk@campus.ac.ug'), findsOneWidget);
  });
}
