import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewPatientScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  ViewPatientScreen({required this.patient});

  @override
  _ViewPatientState createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatientScreen> {

  @override
  void initState() {
    super.initState();
    getPatient(context);
  }

  Future<void> getPatient(BuildContext context) async {
    // Replace with your API URLs
    final String url = 'http://localhost:5001/api/patient/record/${widget.patient["_id"]}';

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
            Text('ID: ${widget.patient["_id"]}'),
            Text('Name: ${widget.patient["name"]}'),
            Text('Age: ${widget.patient["age"]}'),
            Text('Gender: ${widget.patient["gender"]}'),
            Text('Address: ${widget.patient["address"]}'),
            Text('Zip Code: ${widget.patient["zipCode"]}'),
            Text('Condition: ${widget.patient["condition"]}'),
            Text('Updated At: ${widget.patient["updatedAt"]}'),
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
