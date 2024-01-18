import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// The `registerUser` function registers a new user with the provided email, password, and username,
  /// and returns a `UserModel` object if the registration is successful.
  ///
  /// Args:
  ///   email (String): The email parameter is a string that represents the user's email address.
  ///   password (String): The password parameter is a string that represents the user's password for
  /// registration.
  ///   username (String): The `username` parameter is a string that represents the desired username for
  /// the user being registered.
  ///
  /// Returns:
  ///   a Future<UserModel?>.
  Future<UserModel?> registerUser(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser =
            UserModel(uid: user.uid, email: email, username: username);
        // Store user data in the database if needed
        // (e.g., Firestore or Realtime Database).
        // Implement this according to your backend setup.
        return newUser;
      }
    } catch (e) {
      print("Error during registration: $e");
      return null;
    }
    return null;
  }

  /// The loginUser function is a Future that attempts to authenticate a user with the provided email
  /// and password.
  ///
  /// Args:
  ///   email (String): A string representing the email address of the user trying to log in.
  ///   password (String): A string representing the user's password.
  Future<UserModel?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Fetch additional user data from the database if needed.
        // Implement this according to your backend setup.
        return UserModel(uid: user.uid, email: user.email!, username: 'Sample');
      }
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
    return null;
  }
}
