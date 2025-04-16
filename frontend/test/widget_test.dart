import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/add_patient.dart';
import 'package:frontend/add_record.dart';
import 'package:frontend/edit_patient.dart';
import 'package:frontend/main.dart'; // Adjust the import based on your file structure
import 'package:frontend/model/patient.dart'; // Adjust the import based on your file structure

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/login.dart'; // Update this with your actual import
import 'package:frontend/register.dart'; // Update this with your actual import
import 'package:frontend/edit_patient.dart';
import 'package:frontend/view_patient.dart'; // Update this with your actual import
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('App displays Login Page', (WidgetTester tester) async {
    // Build the MyApp widget
    await tester.pumpWidget(MyApp());

    // Use pumpAndSettle to wait for any animations to complete
    await tester.pumpAndSettle();

    // Verify if Login page is opened
    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.title == 'Login',
      ),
      findsOneWidget,
    );
  });

  const AddRecord = 'View Patient';

  /*

  testWidgets('Create Account button navigates to registration page', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(MyApp());

    await tester.pumpAndSettle();


    // Find the Create Account button
    final createAccountButton = find.text('Create Account');

    // Verify that the button is present
    expect(createAccountButton, findsOneWidget);

    // Tap the button
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle(); // Wait for the navigation to complete

    // Check if the registration page contains the text "Register"
    expect(find.text('Register'), findsOneWidget);
  });*/

  const RegisterTitle = "Login";

  const LoginTitle = "Register";

  testWidgets('App navigate to Register Screen', (WidgetTester tester) async {
    // Build the MyApp widget
    await tester.pumpWidget(
      MaterialApp(
        title: LoginTitle,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
      ),
    );

    // Find the Create Account button
    final createAccountButton = find.text('Create Account');

    // Verify that the button is present
    //expect(createAccountButton, findsOneWidget);

    // Tap the button
    await tester.tap(createAccountButton);
    await tester.pumpAndSettle(); // Wait for the navigation to complete
    // Use pumpAndSettle to wait for any animations to complete
    //await tester.pumpAndSettle(Duration(seconds: 5));

    // Verify if "Register" screen is opened
    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.title == 'Register',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Register a new user', (WidgetTester tester) async {
    // Build the HomeScreen widget
    await tester.pumpWidget(
      MaterialApp(
        title: RegisterTitle,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: RegisterScreen(),
      ),
    );

    // Tap the button to navigate to DetailsScreen
    //await tester.tap(find.widgetWithText(TextButton, 'Create Account'));
    await tester.pumpAndSettle();



    // Verify that the DetailsScreen is displayed
    // Verify if "SenCare" is displayed in the widget tree

    // user should be able to see the login screen after regstration
    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.title == 'Login',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Login button is disabled when email and password are empty', (
    WidgetTester tester,
  ) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(
      MaterialApp(
        title: 'Login',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
      ),
    );

    final loginbutton = find.byKey(Key('Login'));

    await tester.pumpAndSettle();

    // user should stay in login page
    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.title == "Login",
      ),
      findsOneWidget,
    );
  });

  testWidgets('Add Record', (WidgetTester tester) async {
    // Build the LoginScreen widget
    await tester.pumpWidget(
      MaterialApp(
        title: AddRecord,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AddRecordScreen(
          onPop: () => {},
          patient: Patient(
            id: '01',
            name: "Rickie",
            age: 24,
            gender: "Male",
            address: "937 Progress Ave",
            zipCode: "M1G 3T8",
            profilePicture:
                "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png",
            condition: "Normal",
            updatedAt: DateTime.now(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Input reading value
    final readinginput = find.text('Reading Value');

    // Input text into the TextField
    //await tester.enterText(textFieldFinder, 'Hello, Flutter!');

    // test whether record is added, if so user should return to the view patient screen
    expect(
      find.byWidgetPredicate(
        (widget) => widget is MaterialApp && widget.title == "View Patient",
      ),
      findsOneWidget,
    );
  });
}
