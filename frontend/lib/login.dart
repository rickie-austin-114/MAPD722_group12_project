


import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        ),
      )
      },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
