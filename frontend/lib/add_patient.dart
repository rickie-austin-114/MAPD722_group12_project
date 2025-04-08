import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'show_message.dart';

class AddPatientScreen extends StatefulWidget {
  final Function() onPop;

  AddPatientScreen({required this.onPop});

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatientScreen> {
  Future<void> addPatient(BuildContext context) async {
    // Replace with your API URL
    final String url = 'http://localhost:5001/api/patients';

    // Prepare the JSON data
    Map<String, dynamic> jsonData = {
      "name": _nameController.text,
      "age": _ageController.text,
      "gender": _genderController.text,
      "address": _addressController.text,
      "zipCode": _zipCodeController.text,
      "profilePicture": _profilePictureController.text,
    };

    try {
      // Send the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonData),
      );

      // Check the response status
      if (response.statusCode == 201) {
        // Successfully posted

        print('Response data: ${response.body}');

        Navigator.pop(context);
        widget.onPop();
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Patient'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name:'),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),

            Text('Age:'),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your age',
              ),
            ),
            SizedBox(height: 20),

            Text('Gender:'),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your gender',
              ),
            ),
            SizedBox(height: 20),
            Text('Address:'),
            TextField(
              controller: _addressController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your adress',
              ),
            ),
            SizedBox(height: 20),
            Text('Zip Code:'),
            TextField(
              controller: _zipCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Zip Code',
              ),
            ),
            SizedBox(height: 20),
            Text('Profile Picture :'),
            TextField(
              controller: _profilePictureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your profile picture',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addPatient(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
