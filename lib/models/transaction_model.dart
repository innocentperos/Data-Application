
import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';

class TransactionModel {

  final double amount;

  TransactionModel({required this.amount, this.fields = const [], this.disclaimer});

  final List<TransactionDescriptionField> fields;
  final TransactionDisclaimer? disclaimer;



  String formatAmount(){
    return amount.toString();
  }
}

class TransactionDescriptionField{
  final String key, value;

  final String? keyId, valueId;
  final bool hidden;

  TransactionDescriptionField(this.key, this.value, {this.keyId, this.valueId, this.hidden = false});
}

class TransactionDisclaimer {
  final String title, description;
  final Color color;

  TransactionDisclaimer({required this.title, required this.description, this.color = ThemedColor});
}