import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';



void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SenCare',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}




