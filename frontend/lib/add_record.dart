import 'package:flutter/material.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  String? _selectedOption;
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Record'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a health parameter:'),
            ...[
              'Blood Pressure',
              'Respiratory Rate',
              'Blood Oxygen Level',
              'Heart Beat Rate',
            ].map((String option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20),
            Text('Enter a value:'),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Do nothing when pressed
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
