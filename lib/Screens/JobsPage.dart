import 'package:flutter/material.dart';
import 'package:time_tracker_app_mad/Models/Job.dart';
import 'package:time_tracker_app_mad/Models/User_firestore.dart';
import 'package:time_tracker_app_mad/Screens/app_sign_in.dart';
import 'package:time_tracker_app_mad/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_mad/Services/Database.dart';
import 'package:time_tracker_app_mad/Widgets/PlatformAlertDialog.dart';

import 'LandingPage.dart';

class JobsPage extends StatelessWidget {


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to Logout',
      defaultActionText: 'Logout',
      cancelActionText: 'No',
    ).show(context);
    if(didRequestSignOut){
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() => _createJob(context),
      ),
    );
  }

  Future<void> _createJob(BuildContext context) async{
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(
        name: 'User2Testing',
        ratePerHour: 1000,
      ) );
  }

  }
