import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction_model.dart';
import '../screens/pin_authentication_page.dart';
import '../screens/theme_utils.dart';
import 'button.dart';

class ConfirmPurchaseSheet extends StatefulWidget {
  const ConfirmPurchaseSheet({Key? key, required this.transaction})
      : super(key: key);
  final TransactionModel transaction;

  @override
  State<ConfirmPurchaseSheet> createState() => _ConfirmPurchaseSheetState();
}

class _ConfirmPurchaseSheetState extends State<ConfirmPurchaseSheet> {
  bool loadingRequest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ThemedDarkBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Confirm Purchase",
              style: WhiteText.copyWith(fontSize: 16),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildDescription(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                .copyWith(top: 16),
            child: CustomButton(
              text: "Pay N${widget.transaction.amount}",
              loading: loadingRequest,
              onPressed: () async {
                setState(() {
                  loadingRequest = true;
                });
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    loadingRequest = false;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PinAuthenticationPage(
                              transaction: widget.transaction,
                            )));
                  });
                });
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildDescription() {
    List<Widget> items = widget.transaction.fields
        .map((e) => confirmPanelItem(e.key, e.value))
        .toList();

    if (widget.transaction.disclaimer != null) {
      items.add(disclaimerMessage(widget.transaction.disclaimer!));
    }
    return items;
  }

  Widget disclaimerMessage(TransactionDisclaimer disclaimer) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: disclaimer.color.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(disclaimer.title,
              style: WhiteText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: disclaimer.color)),
          Text(
            disclaimer.description,
            style: WhiteText.copyWith(
              fontSize: 14,
              wordSpacing: 1.2,
              color: disclaimer.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget confirmPanelItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(title,
              style: WhiteText.copyWith(
                fontSize: 16,
              )),
          const Expanded(child: SizedBox()),
          Text(value,
              style: WhiteText.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
