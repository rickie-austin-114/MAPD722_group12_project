import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './show_message.dart';


class EditPatientScreen extends StatefulWidget {
  final Map<String, dynamic> patient;
  final Function() onPop;

  EditPatientScreen({required this.patient, required this.onPop});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  Future<void> sendEditPatientRequest(BuildContext context) async {
    final String url =
        'http://localhost:5001/api/patients/${widget.patient["_id"]}'; // Replace with your API endpoint

    print(url);
    // Create the JSON data
    final Map<String, dynamic> jsonData = {
      'name': _nameController.text,
      'age': _ageController.text,
      "gender": _genderController.text,
      "address": _addressController.text,
      "zipCode": _zipCodeController.text,
      "profilePicture": _profilePictureController.text,
    };

    // Send the PUT request
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonData),
    );

    // Check the response
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      print('Response data: ${response.body}');

      showMessage(context, "Sucess", "Details of patient updated");

      Navigator.pop(context);
      widget.onPop();
    } else {
      // If the server did not return a 200 OK response, throw an exception
      showMessage(context, "Failed", 'Failed to update resource: ${response.statusCode}');

    }
  }

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _addressController;
  late TextEditingController _zipCodeController;
  late TextEditingController _profilePictureController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient["name"]);
    _ageController = TextEditingController(
      text: widget.patient["age"].toString(),
    );
    _genderController = TextEditingController(text: widget.patient["gender"]);
    _addressController = TextEditingController(text: widget.patient["address"]);
    _zipCodeController = TextEditingController(text: widget.patient["zipCode"]);
    _profilePictureController = TextEditingController(
      text: widget.patient["profilePicture"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Patient'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _zipCodeController,
              decoration: InputDecoration(labelText: 'Zip Code'),
            ),
            TextField(
              controller: _profilePictureController,
              decoration: InputDecoration(labelText: 'Profile Picture'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save changes logic here
                sendEditPatientRequest(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
