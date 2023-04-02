import 'package:flutter/material.dart';

class CableTVPaymentChangeNotifier extends ChangeNotifier{

  int _amount = 0;
  String _phoneNumber ="";
  String _usersPhoneNumber = "09163674665";

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
    amountController.text = value.toString();
    notifyListeners();
  }

  void changeAmount(value){
    _amount = value;
    notifyListeners();
  }

  void useUsersPhoneNumber(){
    _phoneNumber = _usersPhoneNumber;
    phoneNumberController.text = _phoneNumber;
    notifyListeners();
  }
}