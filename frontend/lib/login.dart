import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './show_message.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    // Replace with your API URL
    final String url = 'http://localhost:5001/api/login';

    // Prepare the JSON data
    Map<String, dynamic> jsonData = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonData),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Successfully posted

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        print('Response data: ${response.body}');
      } else {
        // Handle error
        showMessage(context, "Error", "Invalid email or password");
        print('Failed to post data: ${response.statusCode}');
      }

    } catch (e) {
      // Handle any exceptions
      showMessage(context, "Error", e.toString());
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    ),
                  },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
