import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/change_notifiers/airtime_purchase_change_notifier.dart';
import 'package:untitled1/models/data_models.dart';
import 'package:untitled1/models/transaction_model.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/confirmation_sheet.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/text_input_field.dart';

class AirtimePurchaseScreen extends StatelessWidget {
  const AirtimePurchaseScreen({Key? key, required this.provider})
      : super(key: key);

  final NetworkProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      appBar: AppBar(
        title: const Text("Purchase Airtime"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Builder(
          builder: (context) => SafeArea(
                  child: ChangeNotifierProvider(
                create: (context) => AirtimePurchaseChangeNotifier(),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [1, 2, 3, 4]
                                    .map((e) =>
                                        Consumer<AirtimePurchaseChangeNotifier>(
                                            builder: (context, model, child) {
                                          int amount = e * 100;
                                          return buildQuickTile(
                                              context, amount, model);
                                        }))
                                    .toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(8.0).copyWith(top: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [5, 6, 8, 10]
                                    .map((e) =>
                                        Consumer<AirtimePurchaseChangeNotifier>(
                                            builder: (context, model, child) {
                                          int amount = e * 100;
                                          return buildQuickTile(
                                              context, amount, model);
                                        }))
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "Enter Amount ",
                                style: WhiteText.copyWith(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Consumer<AirtimePurchaseChangeNotifier>(
                                  builder: (context, model, child) {
                                return TextInputField(
                                  hint: "Amount",
                                  controller: model.amountController,
                                  color: provider.color,
                                  inputType: TextInputType.number,
                                  onChanged: (value) {
                                    try {
                                      int v = int.parse(value);
                                      model.changeAmount(v);
                                    } catch (e) {
                                      model.amount = 0;
                                    }
                                  },
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Enter Receiver`s Number ",
                                    style: WhiteText.copyWith(fontSize: 14),
                                  ),
                                  Consumer<AirtimePurchaseChangeNotifier>(
                                      builder: (context, model, child) {
                                    return LinkText(
                                      text: "IT FOR ME",
                                      onPressed: () {
                                        model.useUsersPhoneNumber();
                                      },
                                    );
                                  })
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Consumer<AirtimePurchaseChangeNotifier>(
                                  builder: (context, model, child) {
                                return TextInputField(
                                  hint: "Receiver`s Phone Number",
                                  color: provider.color,
                                  inputType: TextInputType.number,
                                  controller: model.phoneNumberController,
                                  onChanged: (value) {
                                    model.phoneNumber = value;
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<AirtimePurchaseChangeNotifier>(
                          builder: (context, model, child) {
                        return CustomButton(
                          text: "BUY N${model.amount}",
                          color: provider.color,
                          onPressed:
                              determinePaymentButtonAction(model, context),
                          // onDisabledPressed: () {
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     padding: const EdgeInsets.all(16),
                          //       content: Text(model.amount < 50
                          //           ? "Please enter amount N50 and above"
                          //           : "Please, provide receiver`s phone number")));
                          // },
                        );
                      }),
                    )
                  ],
                ),
              ))),
    );
  }

  Function()? determinePaymentButtonAction(
      AirtimePurchaseChangeNotifier model, BuildContext context) {
    if (model.amount < 1 || model.phoneNumber.length != 11) return null;

    return () {
      //  TODO : Proceed with payment
      TransactionModel transaction = TransactionModel(
          amount: double.parse(model.amount.toString()),
          fields: [
            TransactionDescriptionField("Purchase Type", "Airtime",
                keyId: "service", valueId: "airtime"),
            TransactionDescriptionField("Network Provider", provider.title,
                keyId: "network_provider", valueId: provider.id),
            TransactionDescriptionField(
                "Airtime Amount", "N${model.amount.toString()}",
                keyId: "amount", valueId: model.amount.toString()),
            TransactionDescriptionField("Receiver`s Number", model.phoneNumber,
                keyId: "phone_number", valueId: model.phoneNumber),
          ],
          disclaimer: TransactionDisclaimer(
              color: Colors.redAccent,
              title: "Disclaimer",
              description: "Make sure the receiver`s "
                  "phone number and network provider is correct, "
                  "as successful transaction can not be reverted."));

      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => ConfirmPurchaseSheet(transaction: transaction));
    };
  }

  Padding buildQuickTile(
      BuildContext context, int amount, AirtimePurchaseChangeNotifier model) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          model.amount = amount;
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: ((MediaQuery.of(context).size.width - 16) / 4) - 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: amount == model.amount
                      ? provider.color.withOpacity(0.35)
                      : Colors.white10,
                  width: 2),
              color: amount == model.amount
                  ? provider.color.withOpacity(0.5)
                  : provider.color.withOpacity(0.05)),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: Text(
              "N$amount",
              style:
                  WhiteText.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
