import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_app/globals/globals.dart';
import 'package:test_flutter_app/home_screen.dart';
import 'package:test_flutter_app/login_screen.dart';
import 'package:test_flutter_app/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // login
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await getCurrentUser(authResult.user!.uid, context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // register
  Future<void> createUserWithEmailAndPassword(BuildContext context,
      String firstName, String lastName, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User currentUser = userCredential.user!;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      }).then((value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> registerUser(
      String firstName, String lastName, String email, String password) async {
    final UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User currentUser = userCredential.user!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
  }

  // get user by id
  Future<void> getCurrentUser(String uid, BuildContext context) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDocument.exists) {
      currentUser = UserModel.fromMap(userDocument.data()!);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

// signout user
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
