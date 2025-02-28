import 'package:flutter/material.dart';

class ViewPatientScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  final List<Map<String, dynamic>> patientRecords = [
    {
      "_id": "6759a2ea1d0a3006a394bcfb",
      "measurementDate": "2024-12-11T14:34:18.919Z",
      "patient": "6759a2dc1d0a3006a394bcf7",
      "datatype": "respiratory rate",
      "readingValue": 20,
      "__v": 0,
    },
    {
      "_id": "6759a2ec1d0a3006a394bd02",
      "measurementDate": "2024-12-11T14:34:20.345Z",
      "patient": "6759a2dc1d0a3006a394bcf7",
      "datatype": "respiratory rate",
      "readingValue": 20,
      "__v": 0,
    },
    {
      "_id": "6759a3871d0a3006a394bd0f",
      "measurementDate": "2024-12-11T14:36:55.200Z",
      "patient": "6759a2dc1d0a3006a394bcf7",
      "datatype": "respiratory rate",
      "readingValue": 30,
      "__v": 0,
    },
    {
      "_id": "6759a3c46297c897674a8763",
      "measurementDate": "2024-12-11T14:37:56.156Z",
      "patient": "6759a2dc1d0a3006a394bcf7",
      "datatype": "respiratory rate",
      "readingValue": 30,
      "__v": 0,
    },
    {
      "_id": "6759a41a30fd41014861208a",
      "measurementDate": "2024-12-11T14:39:22.019Z",
      "patient": "6759a2dc1d0a3006a394bcf7",
      "datatype": "respiratory rate",
      "readingValue": 30,
      "__v": 0,
    },
  ];

  ViewPatientScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Patient'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${patient["_id"]}'),
            Text('Name: ${patient["name"]}'),
            Text('Age: ${patient["age"]}'),
            Text('Gender: ${patient["gender"]}'),
            Text('Address: ${patient["address"]}'),
            Text('Zip Code: ${patient["zipCode"]}'),
            Text('Condition: ${patient["condition"]}'),
            Text('Updated At: ${patient["updatedAt"]}'),
                      Expanded(
            child: ListView.builder(
              itemCount: patientRecords.length,
              itemBuilder: (context, index) {
                final record = patientRecords[index];
                final boxColor =
                    Colors.grey;

                return Container(
                  color: boxColor,
                  child: ListTile(
                    title: Text('Type: ${record["datatype"]}'),
                    subtitle: Text('Reading value: ${record["readingValue"]}'),
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
