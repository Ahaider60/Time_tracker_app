import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Screens/LandingPage.dart';
import 'package:provider/provider.dart';
import 'Services/Auth.dart';

void main() {
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          backgroundColor: Colors.red,
          accentColor: Colors.green,
        ),
        home: LandingPage(
        ),
      ),
    );
  }
}
