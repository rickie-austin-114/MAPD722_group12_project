import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../lib/main.dart'; // Adjust this path
import "../lib/login.dart";

class MockHttpClient extends Mock implements http.Client {}

void main() {
  testWidgets('Show error message for incorrect login', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Find the email and password text fields and login button
    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);
    final loginButton = find.byType(ElevatedButton).first;

    // Enter incorrect email and password
    await tester.enterText(emailField, 'rickie@example.com');
    await tester.enterText(passwordField, 'incorrect_password');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Check for the error message
    expect(find.text('Invalid email or password'), findsOneWidget);
  });

  testWidgets('Navigate to register page when Register button is pressed', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Find the Register button
    final registerButton = find.text('Register');

    // Tap the Register button
    await tester.tap(registerButton);
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Verify that we have navigated to the Register page
    expect(find.text('Register'), findsOneWidget);
  });
}

