import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  const UserModel(
      {required this.email,});

  final String? email;

  static UserModel from(User user) {
    return UserModel(email: user.email);
  }
}
