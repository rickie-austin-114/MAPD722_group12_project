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
                                    ? Colors.red
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

/*
class PatientItem extends StatelessWidget {
  final Patient patient;
  final onDeleteItem;

  const PatientItem({Key? key, required this.patient, required this.onDeleteItem})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // print('Clicked on Todo Item.');
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: patient.condition == "Critical" ? Colors.red : Colors.white,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            patient.profilePicture, // Replace with your image URL
          ),
          radius: 30, // Adjust the radius as needed
        ),
        title: Text(patient.name!, style: TextStyle(fontSize: 16, color: tdBlack)),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Clicked on delete icon');
              onDeleteItem(patient.id);
            },
          ),
        ),
      ),
    );
  }
}*/


/*

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  bool _isCriticalOn = false; // Initial state of the switch

  void _toggleSwitch(bool value) {
    _isCriticalOn = value; // Update the switch state
    getPatient(context);
  }

  String _searchText = '';

  @override
  void initState() {
    super.initState();
    getPatient(context);
  }

  Future<void> getPatient(BuildContext context) async {
    // Replace with your API URLs
    final String url =
        _isCriticalOn
            ? 'http://localhost:5001/api/critical'
            : 'http://localhost:5001/api/patients';

    try {
      // Send the GET request
      final response = await http.get(Uri.parse(url));

      // Check the response status
      if (response.statusCode == 200) {
        // Successfully received data
        print('Response data: ${response.body}');

        setState(() {
          patients = jsonDecode(response.body); // Parse the JSON array
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

  List<dynamic> patients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Management'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search Patients',
              ),
              onChanged:
                  (value) => {
                    setState(() {
                      _searchText = value;
                    }),
                  },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Critical Patients Only'),
              Switch(value: _isCriticalOn, onChanged: _toggleSwitch),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => AddPatientScreen(
                            onPop: () {
                              getPatient(context);
                            },
                          ),
                    ),
                  );
                },
                child: Text('Add Patient'),
              ),
            ],
          ),

          Expanded(
            child: ListView(
              
              children:
                  patients
                      .where(
                        (map) => map["name"]
                            .toString()
                            .toLowerCase()
                            .startsWith(_searchText.toLowerCase()),
                      )
                      .map(
                        (patient) => Container(
                          color:
                              patient["condition"] == "Critical"
                                  ? Color(0xFFFFC0CB)
                                  : Colors
                                      .white, // Apply the color to the container
                          child: ListTile(
                            title: Text('${patient["name"]}'),
                            subtitle: Text('Age: ${patient["age"]}'),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                patient["profilePicture"], // Replace with your image URL
                              ),
                              radius: 30, // Adjust the radius as needed
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
                                                getPatient(context);
                                              },
                                            ),
                                      ),
                                    );
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
                                                getPatient(context);
                                              },
                                            ),
                                      ),
                                    );
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
                                                getPatient(context);
                                              },
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
*/