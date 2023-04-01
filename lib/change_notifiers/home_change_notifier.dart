
import 'package:flutter/cupertino.dart';

class HomeChangeNotifier extends ChangeNotifier{

  bool _showAccount = true;
  bool _loadingBalance = true;
  double _balance = 6700;

  double get balance => _balance;

  set balance(double value) {
    _balance = value;
    notifyListeners();
  }

  bool get loadingBalance => _loadingBalance;

  set loadingBalance(bool value) {
    _loadingBalance = value;
    notifyListeners();
  }

  bool get showAccount => _showAccount;

  set showAccount(bool value) {
    _showAccount = value;
    notifyListeners();
  }

  void refreshBalance() {
    loadingBalance = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), (){
      loadingBalance = false;
      balance = balance + 1300;
      notifyListeners();
    });
  }
}