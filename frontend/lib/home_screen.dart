import 'package:flutter/material.dart';
import './view_patient.dart';
import './add_patient.dart';
import './edit_patient.dart';
import './add_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/patient.dart';
import '../constants/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  List<Patient> todosList = [];
  List<Patient> _foundToDo = [];
  final _todoController = TextEditingController();

  bool _isCriticalOn = false; // Initial state of the switch

  void _toggleSwitch(bool value) {
    setState(() {
      _isCriticalOn = value; // Update the switch state
    });

    updatePatient();
  }

  final backendURL = 'http://localhost:5001/api';

  @override
  void initState() {
    super.initState();
    fetchPatients(context)
        .then((patients) {
          setState(() {
            todosList = patients;
            _foundToDo = patients;
          });
        })
        .catchError((error) {
          // Handle error
          print('Error fetching patients: $error');
        });
  }

  void updatePatient() {
    fetchPatients(context)
        .then((patients) {
          setState(() {
            todosList = patients;
            _foundToDo = patients;
          });
        })
        .catchError((error) {
          // Handle error
          print('Error fetching patients: $error');
        });
  }

  Future<List<Patient>> fetchPatients(BuildContext context) async {
    final String url =
        _isCriticalOn ? '$backendURL/critical' : '$backendURL/patients';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Patient.fromJson(data)).toList();
    } else {
      // If the server does not return a 200 OK response, throw an exception
      throw Exception('Failed to load patients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'All ToDos',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Switch(
                            value: _isCriticalOn,
                            onChanged: _toggleSwitch,
                          ),
                        ],
                      ),

                      for (Patient patient in _foundToDo.reversed)
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              // print('Clicked on Todo Item.');
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            tileColor:
                                patient.condition == "Critical"
                                    ? const Color.fromARGB(255, 234, 167, 174)
                                    : Colors.white,
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                patient
                                    .profilePicture, // Replace with your image URL
                              ),
                              radius: 30, // Adjust the radius as needed
                            ),
                            title: Text(
                              patient.name!,
                              style: TextStyle(fontSize: 16, color: tdBlack),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ViewPatientScreen(
                                              patient: patient,
                                              onPop: () {
                                                fetchPatients(context);
                                              },
                                            ),
                                      ),
                                    ).then((value) {
                                      // This function will run after popping SecondPage
                                      updatePatient();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => EditPatientScreen(
                                              patient: patient,
                                              onPop: () {
                                                fetchPatients(context);
                                              },
                                            ),
                                      ),
                                    ).then((value) {
                                      // This function will run after popping SecondPage
                                      updatePatient();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.accessibility_outlined),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => AddRecordScreen(
                                              patient: patient,
                                              onPop: () {
                                                fetchPatients(context);
                                              },
                                            ),
                                      ),
                                    ).then((value) {
                                      // This function will run after popping SecondPage
                                      updatePatient();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 40),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => AddPatientScreen(
                                onPop: () {
                                  fetchPatients(context);
                                },
                              ),
                        ),
                      ).then((value) {
                        // This function will run after popping SecondPage
                        updatePatient();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    List<Patient> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results =
          todosList
              .where(
                (item) => item.name!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}

