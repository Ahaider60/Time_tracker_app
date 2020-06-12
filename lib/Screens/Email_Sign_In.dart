import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_mad/Services/Auth.dart';
import 'package:time_tracker_app_mad/Widgets/PlatformAlertDialog.dart';

enum FormType { signIn, register }

class EmailSignInForm extends StatefulWidget {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  String email;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _pass => _passwordController.text;

  FormType _formType = FormType.signIn;

  bool _isLoading = false;

  List<Widget> _buildChildren() {
    final primaryText =  _formType == FormType.signIn ? 'Sign In' : 'Create User';
    final secondaryText = _formType == FormType.signIn  ? 'Need an account? Sign up' : 'Already have an account? Sign In';

    bool submitEnabled = _email.isNotEmpty && _pass.isNotEmpty;

    return [
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onEditingComplete: _emailEditingDone,
        onChanged: (email) => _updateState(),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        textInputAction: TextInputAction.done,
        obscureText: true,
        onEditingComplete: submitEnabled ?  _submit : null,
        onChanged: (_pass) => _updateState(),
      ),
      SizedBox(
        height: 8.0,
      ),
      RaisedButton(
        child: Text(primaryText),
        onPressed: _submit,
        color: Colors.orange,
      ),
      SizedBox(
        height: 8.0,
      ),
      FlatButton(
        child: Text(secondaryText),
        onPressed: _toggleForm,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == FormType.signIn) {
        await auth.signInWithEmailAndPass(_email, _pass);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _pass);
      }
      Navigator.of(context).pop();
    } catch (e) {
      PlatformAlertDialog(
        title: 'sign in failed',
        content: e.toString(),
        defaultActionText: 'OK',
        cancelActionText: 'Cancel',
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleForm() {
    setState(() {
      _formType =
          _formType == FormType.signIn ? FormType.register : FormType.signIn;
    });
  }

  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

   void _updateState() {
    print('email:$_email , password:$_pass');
    setState(() {

    });
   }
}
