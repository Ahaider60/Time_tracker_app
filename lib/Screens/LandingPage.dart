import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_mad/Screens/JobsPage.dart';
import 'package:time_tracker_app_mad/Services/Auth.dart';
import 'package:time_tracker_app_mad/Services/Database.dart';
import 'app_sign_in.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SingInPage(
              );
            } else {
              return Provider<Database>(
                create: (context) => FireStoreDatabase(uid: user.uid),
                child: JobsPage(),
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
