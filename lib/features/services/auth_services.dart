import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static AuthServices? _instance;
  AuthServices._internal() {
    _instance = this;
  }
  factory AuthServices() => _instance ?? AuthServices._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        // AppDialog.toast(e.message);
      }
    }
  }

  void signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        // AppDialog.toast(e.message);
      }
    }
  }
}
