import 'package:flutter/material.dart';
import 'package:frontend/model/patient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "./add_record.dart";
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import 'dart:io';

const textSize = 20.0;

class ViewPatientScreen extends StatefulWidget {
  final Patient patient;
  final Function() onPop;
  ViewPatientScreen({required this.patient, required this.onPop});

  @override
  _ViewPatientState createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatientScreen> {
  @override
  void initState() {
    super.initState();
    getPatientRecords(context);
  }

  Future<void> getPatientRecords(BuildContext context) async {


    // Replace with your API URLs
    final String url = Platform.isAndroid ? 'http://10.0.2.2:5001/api/patient/record/${widget.patient.id}':
        'http://localhost:5001/api/patient/record/${widget.patient.id}';


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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                                image: AssetImage(
                                  'assets/images/background.png',
                                ),
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
                                image: NetworkImage(
                                  widget.patient.profilePicture,
                                ),
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
                          "View Patient",
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
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Name: ${widget.patient.name}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Age: ${widget.patient.age}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Gender: ${widget.patient.gender}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Address: ${widget.patient.address}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Zip Code: ${widget.patient.zipCode}',
                                  style: TextStyle(fontSize: textSize),
                                ),
                              ),

                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  height:
                                      200, // Set a specific height for the ListView
                                  child: ListView.builder(
                                    itemCount: patientRecords.length,
                                    itemBuilder: (context, index) {
                                      final record = patientRecords[index];
                                      final boxColor = Colors.grey;
                                      return Container(
                                        //color: boxColor,
                                        margin: EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey,
                                        ),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 5,
                                          ),
                                          title: Text(
                                            'Type: ${record["datatype"]}',
                                          ),
                                          subtitle: Text(
                                            'Reading value: ${record["readingValue"]}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(height: 30),
                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: MaterialButton(
                          onPressed:
                              () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => AddRecordScreen(
                                          onPop:
                                              () => {
                                                getPatientRecords(context),
                                              },
                                          patient: widget.patient,
                                        ),
                                  ),
                                ),
                              },
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
                            onPressed:
                                () => {Navigator.pop(context), widget.onPop()},
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
          ],
        ),
      ),
    );
  }
}