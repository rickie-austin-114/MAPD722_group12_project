import 'package:flutter/material.dart';
import './view_patient.dart';
import './add_patient.dart';
import './edit_patient.dart';
import './add_record.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                                  icon: Icon(Icons.food_bank),
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
