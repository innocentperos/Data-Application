import 'package:flutter/material.dart';
import 'package:untitled1/screens/fund_with_card.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';

import '../utils.dart';

class FundPage extends StatefulWidget {
  const FundPage({Key? key, required this.amount}) : super(key: key);

  final double amount;

  @override
  State<FundPage> createState() => _FundPageState();
}

class _FundPageState extends State<FundPage> {
  List<Map> accounts = [
    {
      "bank": "Sterling Bank",
      "name": "St-Epicx Innocent",
      "number": "2389645783"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "N ${formatAmount(widget.amount)}",
              style: WhiteText.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListView.builder(
            itemCount: accounts.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "You can make payment to "
                    "any of the listed accounts,"
                    " and your wallet balance will be"
                    " credited within 5 minute",
                    textAlign: TextAlign.center,
                    style: WhiteText.copyWith(
                      fontSize: 16,
                      letterSpacing: 1.3,
                    ),
                  ),
                );
              }

              Map account = accounts[index - 1];
              return Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: ThemedColorDark,
                      child: Icon(
                        Icons.wallet,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${account["bank"]}",
                          style: WhiteText,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "${account["name"]}",
                          style: WhiteText.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${account["number"]}",
                          style: WhiteText.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
        Expanded(
          child: SizedBox(),
        ),
        const Text(
          "OR",
          style: WhiteText,
        ),
        Expanded(
          child: SizedBox(),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: CustomButton(
            text: "Fund with ATM Card",
            color: ThemedColorDark,
            onPressed: () {
              //  TODO : Open pay stack payment gateway
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FundWithCardScreen()));
            },
          ),
        )
      ],
    );
  }
}
