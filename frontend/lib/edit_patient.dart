import 'package:flutter/material.dart';



class EditPatientScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  EditPatientScreen({required this.patient});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
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
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
