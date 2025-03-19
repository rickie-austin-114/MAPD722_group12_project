import 'package:flutter/material.dart';

void showMessage(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

    name,
    age,
    gender,
    address,
    zipCode,
    profilePicture,


class _AddPatientState extends State<AddPatientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _profilePictureController = TextEditingController();

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
              controller: _nameController,
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
              controller: _nameController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your profile picture',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
