import 'package:flutter/material.dart';
import './view_patient.dart';
import './add_patient.dart';
import './edit_patient.dart';
import './add_record.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> patients = [
      {
        "_id": "6759a2dc1d0a3006a394bcf7",
        "name": "Mike",
        "age": 87,
        "gender": "Male",
        "address": "937 Progress Ave",
        "zipCode": "M1G 3T8",
        "profilePicture":
            "https://booklumos.com/wp-content/uploads/2024/05/significance-of-the-sea-in-the-old-man-and-the-sea.jpeg",
        "condition": "Normal",
        "updatedAt": "2024-12-11T14:55:57.034Z",
        "__v": 0,
      },
      {
        "_id": "6759a6036d07ba5189b42384",
        "name": "Rico",
        "age": 78,
        "gender": "Male",
        "address": "937 Progress Ave",
        "zipCode": "M1G3T8",
        "profilePicture":
            "https://booklumos.com/wp-content/uploads/2024/05/significance-of-the-sea-in-the-old-man-and-the-sea.jpeg",
        "condition": "Critical",
        "updatedAt": "2024-12-11T17:14:58.440Z",
        "__v": 0,
      },
      {
        "_id": "6759ad0882e652b424bc6bd8",
        "name": "Rickie",
        "age": 24,
        "gender": "Apache Helicopter",
        "address": "937 Progress Ave",
        "zipCode": "M1G 3T8",
        "profilePicture":
            "https://static.wikia.nocookie.net/roblox/images/4/4b/Epic_Face_Icon.png",
        "condition": "Normal",
        "updatedAt": "2024-12-11T15:18:47.278Z",
        "__v": 0,
      },
      {
        "_id": "67c18ee2c10a6cf9c88a02fc",
        "name": "Mickie",
        "age": 23,
        "gender": "Male",
        "address": "937 Progress Ave",
        "zipCode": "M1G 3T8",
        "profilePicture":
            "https://booklumos.com/wp-content/uploads/2024/05/significance-of-the-sea-in-the-old-man-and-the-sea.jpeg",
        "condition": "Normal",
        "updatedAt": "2025-02-28T10:24:34.742Z",
        "__v": 0,
      },
      {
        "_id": "67c18f08c10a6cf9c88a02fe",
        "name": "Pickie",
        "age": 27,
        "gender": "Male",
        "address": "930 Progress Ave",
        "zipCode": "M1G 3T9",
        "profilePicture":
            "https://booklumos.com/wp-content/uploads/2024/05/significance-of-the-sea-in-the-old-man-and-the-sea.jpeg",
        "condition": "Normal",
        "updatedAt": "2025-02-28T10:25:12.581Z",
        "__v": 0,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Patient Management'), backgroundColor: Colors.blue),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPatientScreen()),
              );
            },
            child: Text('Add Patient'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                final boxColor =
                    patient["condition"] == "Critical"
                        ? Color(0xFFFFC0CB)
                        : Colors.white;

                return Container(
                  color: boxColor, // Apply the color to the container
                  child: ListTile(
                    title: Text('${patient["name"]}'),
                    subtitle: Text('Age: ${patient["age"]}'),
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
                                    (context) =>
                                        ViewPatientScreen(patient: patient),
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
                                    (context) =>
                                        EditPatientScreen(patient: patient),
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
                                builder: (context) => AddRecordScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
