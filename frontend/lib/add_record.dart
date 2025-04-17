import 'package:flutter/material.dart';
import 'package:frontend/model/patient.dart';
import './show_message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';

class AddRecordScreen extends StatefulWidget {
  final Patient patient;
  final Function() onPop;
  AddRecordScreen({required this.onPop, required this.patient});
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

/*
class _AddRecordScreenState extends State<AddRecordScreen> {
  Future<void> sendAddRecordRequest(BuildContext context) async {
    // Replace with your API URL
    final String url = 'http://localhost:5001/api/record';

    // Prepare the JSON data
    Map<String, dynamic> jsonData = {
      "patient": widget.patient.id,
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
        showMessage(context, "Error", 'Failed to post data: ${response.body}');
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


*/

class _AddRecordScreenState extends State<AddRecordScreen> {
  Future<void> sendAddRecordRequest(BuildContext context) async {
    // Replace with your API URL
    final String url = Platform.isAndroid ? 'http://10.0.2.2:5001/api/record' : 'http://localhost:5001/api/record';

    // Prepare the JSON data
    Map<String, dynamic> jsonData = {
      "patient": widget.patient.id,
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
        showMessage(context, "Error", 'Failed to post data: ${response.body}');
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(
                      duration: Duration(seconds: 1),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/background-2.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Text(
                      "Add Record",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
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

                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: _readingValueController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Reading Value",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: () => sendAddRecordRequest(context),
                      color: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Add Record",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, .6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
