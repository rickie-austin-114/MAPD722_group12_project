import 'package:flutter/material.dart';
import 'package:frontend/model/patient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "./add_record.dart";
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';

const textSize = 20.0;

class ViewPatientScreen extends StatefulWidget {
  final Patient patient;
  final Function() onPop;
  ViewPatientScreen({required this.patient, required this.onPop});

  @override
  _ViewPatientState createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatientScreen> {
  @override
  void initState() {
    super.initState();
    getPatientRecords(context);
  }

  Future<void> getPatientRecords(BuildContext context) async {
    // Replace with your API URLs
    final String url =
        'http://localhost:5001/api/patient/record/${widget.patient.id}';

    print(url);

    try {
      // Send the GET request
      final response = await http.get(Uri.parse(url));

      // Check the response status
      if (response.statusCode == 200) {
        // Successfully received data
        print('Response data: ${response.body}');

        setState(() {
          patientRecords = jsonDecode(response.body); // Parse the JSON array
        });
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
  }

  List<dynamic> patientRecords = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                                image: AssetImage(
                                  'assets/images/background.png',
                                ),
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
                                image: NetworkImage(
                                  widget.patient.profilePicture,
                                ),
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
                          "View Patient",
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
                                child: Text(
                                  'Name: ${widget.patient.name}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Age: ${widget.patient.age}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Gender: ${widget.patient.gender}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Address: ${widget.patient.address}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Zip Code: ${widget.patient.zipCode}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),

                              // for (final record in patientRecords.reversed)
                              //   Container(
                              //     margin: EdgeInsets.only(bottom: 20),
                              //     child: ListTile(
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(20),
                              //       ),
                              //       contentPadding: EdgeInsets.symmetric(
                              //         horizontal: 20,
                              //         vertical: 5,
                              //       ),
                              //       tileColor: Colors.blueGrey,
                              //       title: Text(
                              //         "Type: ${record["datatype"]}",
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           color: tdBlack,
                              //         ),
                              //       ),

                              //       subtitle: Text(
                              //         "Reading value: ${record["readingValue"]}",
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           color: tdBlack,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height:
                                      200, // Set a specific height for the ListView
                                  child: ListView.builder(
                                    itemCount: patientRecords.length,
                                    itemBuilder: (context, index) {
                                      final record = patientRecords[index];
                                      final boxColor = Colors.grey;
                                      return Container(
                                        //color: boxColor,
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 5,
                                          ),
                                          title: Text(
                                            'Type: ${record["datatype"]}',
                                          ),
                                          subtitle: Text(
                                            'Reading value: ${record["readingValue"]}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(height: 30),
                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: MaterialButton(
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AddRecordScreen(
                                          onPop:
                                              () => {
                                                getPatientRecords(context),
                                              },
                                          patient: widget.patient,
                                        ),
                                  ),
                                ),
                              },
                          color: Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 50,
                          child: Center(
                            child: Text(
                              "Add Record",
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
                            onPressed:
                                () => {Navigator.pop(context), widget.onPop()},
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
          ],
        ),
      ),
    );
  }
}

/*
class _ViewPatientState extends State<ViewPatientScreen> {
  @override
  void initState() {
    super.initState();
    getPatientRecords(context);
  }

  Future<void> getPatientRecords(BuildContext context) async {
    // Replace with your API URLs
    final String url =
        'http://localhost:5001/api/patient/record/${widget.patient.id}';

    print(url);

    try {
      // Send the GET request
      final response = await http.get(Uri.parse(url));

      // Check the response status
      if (response.statusCode == 200) {
        // Successfully received data
        print('Response data: ${response.body}');

        setState(() {
          patientRecords = jsonDecode(response.body); // Parse the JSON array
        });
      } else {
        // Handle error
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error: $e');
    }
  }

  List<dynamic> patientRecords = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Patient'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.patient.profilePicture, // Replace with your image URL
              ),
              radius: 100, // Adjust the radius as needed
            ),
            Text(
              'ID: ${widget.patient.id}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Name: ${widget.patient.name}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Age: ${widget.patient.age}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Gender: ${widget.patient.gender}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Address: ${widget.patient.address}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Zip Code: ${widget.patient.zipCode}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Condition: ${widget.patient.condition}',
              style: TextStyle(fontSize: textSize),
            ),
            Text(
              'Updated At: ${widget.patient.updatedAt}',
              style: TextStyle(fontSize: textSize),
            ),
            TextButton(
              onPressed:
                  () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => AddRecordScreen(
                              onPop: () => {getPatientRecords(context)},
                              patient: widget.patient,
                            ),
                      ),
                    ),
                  },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: Text("Add Measurement Record"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patientRecords.length,
                itemBuilder: (context, index) {
                  final record = patientRecords[index];
                  final boxColor = Colors.grey;

                  return Container(
                    color: boxColor,
                    child: ListTile(
                      title: Text('Type: ${record["datatype"]}'),
                      subtitle: Text(
                        'Reading value: ${record["readingValue"]}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'show_message.dart';
import 'package:animate_do/animate_do.dart';


class AddPatientScreen extends StatefulWidget {
  final Function() onPop;

  AddPatientScreen({required this.onPop});

  @override
  _AddPatientState createState() => _AddPatientState();
}

/*
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
*/
*/
