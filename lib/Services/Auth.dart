import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class User {
  final uid;
  User({@required this.uid});
}

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInFaceBook();
  Future<User> signInWithEmailAndPass(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;
  Stream<User> get onAuthStateChanged {
    return _fireBaseAuth.onAuthStateChanged.map(_userFromFireBase);
  }

  User _userFromFireBase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Future<User> currentUser() async {
    final returnedAuth = await _fireBaseAuth.currentUser();
    return _userFromFireBase(returnedAuth);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _fireBaseAuth.signInAnonymously();
    return _userFromFireBase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      if (googleSignInAuthentication.accessToken != null &&
          googleSignInAuthentication.idToken != null) {
        final authResult = await _fireBaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken),
        );
        return _userFromFireBase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR MISSING GOOGLE AUTH TOKEN',
          message: 'MISSING GOOGLE AUTH TOKEN',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR ABBORTED BY USER!',
        message: 'YOU ABBORTED THE SIGN IN!',
      );
    }
  }

  @override
  Future<User> signInFaceBook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(
      ['email', 'public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _fireBaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _userFromFireBase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABBORTED_BY_USER',
        message: 'SIGN_IN_ABORTED_BY_USER',
      );
    }
  }

  Future<User> signInWithEmailAndPass(String email, String password) async {
    final authResult = await _fireBaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFireBase(authResult.user);
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFireBase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _fireBaseAuth.signOut();
  }
}
