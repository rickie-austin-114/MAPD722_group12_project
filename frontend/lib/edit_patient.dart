import 'package:flutter/material.dart';
import 'package:frontend/model/patient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './show_message.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:io';


class EditPatientScreen extends StatefulWidget {
  final Patient patient;
  final Function() onPop;

  EditPatientScreen({required this.patient, required this.onPop});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

   



class _EditPatientScreenState extends State<EditPatientScreen> {
  Future<void> sendEditPatientRequest(BuildContext context) async {
    final String url = Platform.isAndroid ? 'http://10.0.2.2:5001/api/patients/${widget.patient.id}' :
        'http://localhost:5001/api/patients/${widget.patient.id}' ;// Replace with your API endpoint

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
      showMessage(
        context,
        "Failed",
        'Failed to update resource: ${response.statusCode}',
      );
    }
  }

  Future<void> Back(BuildContext context) async {
    Navigator.pop(context);
    widget.onPop();
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
    _nameController = TextEditingController(text: widget.patient.name);
    _ageController = TextEditingController(
      text: widget.patient.age.toString(),
    );
    _genderController = TextEditingController(text: widget.patient.gender);
    _addressController = TextEditingController(text: widget.patient.address);
    _zipCodeController = TextEditingController(text: widget.patient.zipCode);
    _profilePictureController = TextEditingController(
      text: widget.patient.profilePicture,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(
                      duration: Duration(seconds: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background-2.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Text(
                      "Edit Patient",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _nameController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _ageController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Age",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _genderController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Gender",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _addressController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Address",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _zipCodeController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Zip Code",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: _profilePictureController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Profile Picture",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: () => sendEditPatientRequest(context),
                      color: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Update Patient",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () => {
                          Back(context),
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, .6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class _EditPatientScreenState extends State<EditPatientScreen> {
  
  Future<void> sendEditPatientRequest(BuildContext context) async {
    final String url =
        'http://localhost:5001/api/patients/${widget.patient["_id"]}'; // Replace with your API endpoint

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
      showMessage(
        context,
        "Failed",
        'Failed to update resource: ${response.statusCode}',
      );
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


*/