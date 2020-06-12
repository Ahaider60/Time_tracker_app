import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_mad/Screens/EmailLogin.dart';
import 'package:time_tracker_app_mad/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_mad/widgets/CustomRaisedButton.dart';

class SingInPage extends StatelessWidget {

  Future<void> _signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {

      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailLogin(),
    ));
    print('Done');
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {

      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInFaceBook();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _signInConetent(context),
      backgroundColor: Colors.white,
    );
  }

  Widget _signInConetent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomRaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('images/google-logo.png'),
                Text(
                  'Sing in with google',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Opacity(
                    opacity: 0.0, child: Image.asset('images/google-logo.png')),
              ],
            ),
            color: Colors.white,
            onPressed:() => _signInWithGoogle(context),
            borderRadius: 4.0,
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomRaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset('images/facebook-logo.png'),
                Text(
                  'Sing in with facebook',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                Opacity(
                  opacity: 0,
                  child: Image.asset('images/facebook-logo.png'),
                )
              ],
            ),
            color: Colors.indigo,
            onPressed:() => _signInWithFacebook (context),
            borderRadius: 6.0,
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomRaisedButton(
            child: Text(
              'Sing in with Email',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            color: Colors.orange,
            onPressed: () => _signInWithEmail(context),
            borderRadius: 6.0,
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            'OR',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomRaisedButton(
            child: Text(
              'Sing in Anonymously',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            color: Colors.lime,
            onPressed:() => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
