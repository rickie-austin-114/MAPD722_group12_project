import 'package:flutter/material.dart';
import './show_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddRecordScreen extends StatefulWidget {
  final Map<String, dynamic> patient;
  final Function() onPop;
  AddRecordScreen({required this.onPop, required this.patient});
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {

Future<void> sendAddRecordRequest(BuildContext context) async {
    // Replace with your API URL
    final String url = 'http://localhost:5001/api/record';

    // Prepare the JSON data
    Map<String, dynamic> jsonData = {
      "patient": widget.patient["_id"],
      "datatype": _datatype,
      "readingValue": _readingValueController.text,
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
        showMessage(context,"Error", 'Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      showMessage(context, "Error", e.toString());
      print('Error: $e');
    }
}



  String? _datatype;
  final TextEditingController _readingValueController = TextEditingController();

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
              'blood pressure',
              'respiratory rate',
              'blood oxygen level',
              'heart beat rate',
            ].map((String option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _datatype,
                onChanged: (String? value) {
                  setState(() {
                    _datatype = value;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20),
            Text('Enter a value:'),
            TextField(
              controller: _readingValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendAddRecordRequest(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
