import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/service_provider_picker.dart';

class NetworkProviderModel extends ServiceProviderModel {
  NetworkProviderModel(super.title, super.description, super.icon, super.color,
      {required this.id});

  final String id;
}

final List<NetworkProviderModel> NigerianNetworkServiceProviders = [
  NetworkProviderModel(
      "MTN", "Nigeria", Icons.network_cell_rounded, const Color(0xFF4D4D0A),
      id: "mtn-ng"),
  NetworkProviderModel(
      "AIRTEL", "Nigeria", Icons.network_cell_rounded, Colors.redAccent,
      id: "airtel-ng"),
  NetworkProviderModel(
      "GLO", "Nigeria", Icons.network_cell_rounded, Colors.green,
      id: "glo-ng"),
  NetworkProviderModel(
      "9 MOBILE", "Nigeria", Icons.network_cell_rounded, Colors.teal,
      id: "9mobile-ng"),
];

enum DataUnit { GB, MB }

class NetworkProviderDataPlan {
  final double price;
  final int duration;
  final DataUnit unit;
  final int amount;
  final NetworkProviderModel provider;

  NetworkProviderDataPlan(
      {required this.price,
      this.duration = 30,
      this.unit = DataUnit.GB,
      required this.amount,
      required this.provider});
}
