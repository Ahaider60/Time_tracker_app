import 'package:flutter/material.dart';
import 'package:time_tracker_app_mad/Services/Auth.dart';
import 'Email_Sign_In.dart';

class EmailLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
