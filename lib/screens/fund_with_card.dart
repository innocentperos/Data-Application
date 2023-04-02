import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/text_input_field.dart';

import '../uis/button.dart';
import '../utils.dart';

class FundWithCardScreen extends StatefulWidget {
  const FundWithCardScreen({Key? key}) : super(key: key);

  @override
  State<FundWithCardScreen> createState() => _FundWithCardScreenState();
}

class _FundWithCardScreenState extends State<FundWithCardScreen> {
  double amount = 0;

  final TextEditingController _amountController = TextEditingController();

  final double _gateWayPercent = 1.5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _amountController.text = amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      appBar: AppBar(
        title: const Text("Fund With Card"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        panelDescription(label: "Amount", value: "N ${formatAmount(amount)}"),
                        panelDescription(
                            label: "Charges at $_gateWayPercent%",
                            value:
                                "N ${formatAmount(double.parse(((amount / 100) * _gateWayPercent).toStringAsFixed(2)))}"),
                        panelDescription(
                            label: "Payment Amount",
                            value:
                                "N ${formatAmount(double.parse(getTotalPaymentAmount().toStringAsFixed(2)))}"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 32)
                              .copyWith(bottom: 8),
                          child: Text(
                            "Enter Amount ",
                            style: WhiteText.copyWith(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0).copyWith(top: 4),
                          child: TextInputField(
                            hint: "Amount",
                            inputType: TextInputType.number,
                            controller: _amountController,
                            onChanged: (value) {
                              if (value.trim().isEmpty) {
                                setState(() {
                                  amount = 0;
                                });
                                return;
                              }
                              try {
                                setState(() {
                                  amount = double.parse(value);
                                });
                              } catch (e) {
                                setState(() {
                                  amount = 0;
                                });
                                _amountController.text = amount.toString();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please provide a valid amount")));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      color: ThemedColorDark,
                      onPressed: () {
                        //  TODO : Open paystack payment gateway
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Continue with Payment".toUpperCase(),
                              style: WhiteText.copyWith(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "N${formatAmount(getTotalPaymentAmount())}".toUpperCase(),
                              style: WhiteText.copyWith(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }

  double getTotalPaymentAmount() => ((amount / 100) * _gateWayPercent + amount);

  Column panelDescription({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
              .copyWith(bottom: 4),
          child: Text(
            label,
            style:
                WhiteText.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            value,
            style:
                WhiteText.copyWith(fontSize: 42, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
