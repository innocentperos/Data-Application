import 'package:flutter/material.dart';
import 'package:untitled1/screens/fund_with_card.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';

class FundPage extends StatefulWidget {
  const FundPage({Key? key}) : super(key: key);

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
    {"bank": "Wema Bank", "name": "St-Epicx Innocent", "number": "7645386479"},
    {"bank": "Monnie Bank", "name": "St-Epicx Innocent", "number": "1225699864"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      appBar: AppBar(
        title: const Text("Fund your account"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 4,
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
                              fontSize: 16, letterSpacing: 1.3, ),
                        ),
                      );
                    }

                    Map account = accounts[index - 1];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
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
                  })),
          const Text("OR", style: WhiteText,),
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
      )),
    );
  }
}
