import 'package:flutter/material.dart';

class CableTVProviderModel {
  final title;
  final String id;
  final Color color;
  final IconData icon;
  final String? description;
  final int identificationLength;

  CableTVProviderModel(
      {required this.title,
      required this.color,
      required this.icon,
      this.description,
      this.identificationLength = 10,
      required this.id});
}

class CableTvPlanModel {
  CableTvPlanModel(
      {required this.title,
      required this.price,
      required this.provider,
      this.description});

  final String title;
  final double price;
  final String? description;
  final CableTVProviderModel provider;
}
