import 'package:flutter/material.dart';
import 'package:untitled1/models/transaction_model.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/link.dart';

class PinAuthenticationPage extends StatefulWidget {
  const PinAuthenticationPage({Key? key, required this.transaction})
      : super(key: key);

  final TransactionModel transaction;

  @override
  State<PinAuthenticationPage> createState() => _PinAuthenticationPageState();
}


class _PinAuthenticationPageState extends State<PinAuthenticationPage> {
  // List<KeyMap> keyArrangements = const [
  //   KeyMap(value: "1", label: "1"),
  //   KeyMap(value: "2", label: "2"),
  //   KeyMap(value: "3", label: "3"),
  //   KeyMap(value: "4", label: "4"),
  //   KeyMap(value: "5", label: "5"),
  //   KeyMap(value: "6", label: "6"),
  //   KeyMap(value: "7", label: "7"),
  //   KeyMap(value: "8", label: "8"),
  //   KeyMap(value: "9", label: "9"),
  //   KeyMap(value: "F", label: "FingerPrint", isFunction: true),
  //   KeyMap(value: "0", label: "0"),
  //   KeyMap(value: "C", label: "Clear", isFunction: true),
  // ];

  bool useFingerPrint = false;
  List<String> pin = [];
  bool authenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(child: SizedBox()),
                Text(
                  "N${widget.transaction.formatAmount()}",
                  style: WhiteText.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 42,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  useFingerPrint
                      ? "Use your fingerprint to confirm payment "
                      : "Enter pin to confirm payment",
                  style: WhiteText.copyWith(fontWeight: FontWeight.w500),
                ),
                if (!useFingerPrint)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [1, 2, 3, 4]
                          .map((e) => Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: pin.length >= e
                                        ? ThemedColor
                                        : Colors.white10,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50))),
                              ))
                          .toList(),
                    ),
                  ),
                if (useFingerPrint) const Expanded(child: SizedBox()),
                if (useFingerPrint)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(
                      Icons.fingerprint_outlined,
                      size: 64,
                      color: ThemedColorDark,
                    ),
                  ),
                if (useFingerPrint)
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LinkText(
                          text: "Use pin instead",
                          onPressed: () {
                            setState(() {
                              useFingerPrint = false;
                            });
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                if (!useFingerPrint)
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LinkText(
                          text: "Reset your pin?",
                          onPressed: () {
                            // TODO : Go to transaction pin resetting page
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                if (!useFingerPrint)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            KeyMap(value: "1", label: "1"),
                            KeyMap(value: "2", label: "2"),
                            KeyMap(value: "3", label: "3")
                          ].map((e) => keyPad(e)).toList(),
                        ),
                        Row(
                          children: const [
                            KeyMap(value: "4", label: "4"),
                            KeyMap(value: "5", label: "5"),
                            KeyMap(value: "6", label: "6"),
                          ].map((e) => keyPad(e)).toList(),
                        ),
                        Row(
                          children: const [
                            KeyMap(value: "7", label: "7"),
                            KeyMap(value: "8", label: "8"),
                            KeyMap(value: "9", label: "9")
                          ].map((e) => keyPad(e)).toList(),
                        ),
                        Row(
                          children: const [
                            KeyMap(
                                value: "F",
                                label: "Forgot?",
                                isFunction: true,
                                icon: Icon(
                                  Icons.fingerprint_outlined,
                                  color: ThemedColor,
                                )),
                            KeyMap(value: "0", label: "0"),
                            KeyMap(
                                value: "C",
                                label: "Clear",
                                isFunction: true,
                                icon: Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.white,
                                )),
                          ].map((e) => keyPad(e)).toList(),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (authenticating)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black87,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ThemedColor),
                ),
              ),
            )
        ],
      )),
    );
  }

  Widget keyPad(KeyMap key) {
    return InkWell(
        onTap: () {
          if (key.value == "F") {
            setState(() {
              pin.clear();
              useFingerPrint = true;
            });
          } else if (key.value == "C") {
            clearPin();
          } else {
            if (pin.length < 4) {
              setState(() {
                pin.add(key.value);
              });
            }

            if (pin.length == 4) {
              //  TODO : Authenticated the users transaction pin

              setState(() {
                authenticating = true;
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  authenticating = false;
                  clearPin();
                });
              });
            }
          }
        },
        borderRadius: BorderRadius.circular(46),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width - 32) / 3,
          height: 70,
          child: Center(
            child: key.icon != null
                ? key.icon!
                : Text(
                    key.label,
                    style: WhiteText.copyWith(
                        fontSize: 18,
                        fontWeight: key.isFunction
                            ? FontWeight.normal
                            : FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
          ),
        ));
  }

  void clearPin() {
    int count = pin.length;
    for (int i = 0; i < count; i++) {
      Future.delayed(Duration(microseconds: 10000 * i), () {
        setState(() {
          pin.removeLast();
        });
      });
    }
  }
}

class KeyMap {
  const KeyMap(
      {required this.value,
        required this.label,
        this.isFunction = false,
        this.icon});

  final String value, label;
  final bool isFunction;
  final Icon? icon;
}
