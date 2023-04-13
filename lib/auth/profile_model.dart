
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Profile{

  final String firstName, lastName, emailAddress;
  final double balance;

  static const String collectionPath = "profiles";



  Profile({required this.firstName, required this.lastName, required this.emailAddress,required this.balance});


  Map<String, dynamic> toMap () {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email_address": emailAddress,
      "balance": balance,
    };

  }
  static Profile from(dynamic data){
    return Profile(emailAddress: "",firstName: "",lastName: "",balance: 0);
  }

  static Future<bool?> insert(Profile profile) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(collectionPath);

    try{

      QuerySnapshot items = await collection.where("email_address", isEqualTo: profile.emailAddress).get();
      if(items.size != 0) return false;

      DocumentReference profileRef = await collection.add(profile.toMap());
      return true;
    }catch(err){
      if (kDebugMode){
        print("Profile::insert >> Error inserting a new profile for ${profile.emailAddress}");
        print(err);
        rethrow;
      }
    }
  }
}