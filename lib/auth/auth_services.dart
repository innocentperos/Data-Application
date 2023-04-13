import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/auth/profile_model.dart';

class AuthService {


  static Future<UserCredential?> signIn(String emailAddress,
      String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      return userCredential;
    } on FirebaseAuthException catch (err) {
      if (kDebugMode) {
        print("Failed to log in user $emailAddress}");
        print(err.code);
        print(err.message);
      }

      rethrow;
    } catch (err) {
      if (kDebugMode) {
        print("Error while logging in user $emailAddress}");
        print(err);
      }
    }
    return null;
  }

  static Future<UserCredential?> register(String emailAddress,
      String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      return userCredential;
    } on FirebaseAuthException catch (err) {
      if (kDebugMode) {
        print("Failed to create new user $emailAddress}");
        print(err.code);
        print(err.message);
      }

      rethrow;
    } catch (err) {
      if (kDebugMode) {
        print("Error while creating user $emailAddress}");
        print(err);
      }
    }
    return null;
  }

  static Future<Profile?> getProfile(String emailAddress) async {
    try {
      CollectionReference collections = FirebaseFirestore.instance.collection(
          Profile.collectionPath);

      QuerySnapshot profiles = await collections.where(
          "email_address", isEqualTo: emailAddress).get();

      if (profiles.size < 1) return null;

      QueryDocumentSnapshot profileDoc = profiles.docs[0];

      return Profile(firstName: profileDoc.get("first_name"),
          lastName: profileDoc.get("last_name"),
          emailAddress:  profileDoc.get("email_address"),
          balance:  profileDoc.get("balance"));

    } catch (err) {
      if (kDebugMode) {
        print("Error getting profile $emailAddress");
        print(err);
      }
      rethrow;
    }
  }
}