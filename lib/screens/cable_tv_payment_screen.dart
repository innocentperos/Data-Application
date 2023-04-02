import 'package:flutter/material.dart';
import 'package:untitled1/models/cable_tv_model.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/text_input_field.dart';

import '../models/data_models.dart';
import '../models/transaction_model.dart';
import '../uis/confirmation_sheet.dart';

class CableTvPaymentScreen extends StatefulWidget {
  const CableTvPaymentScreen({Key? key, required this.provider})
      : super(key: key);

  final CableTVProviderModel provider;

  @override
  State<CableTvPaymentScreen> createState() => _CableTvPaymentScreenState();
}

class _CableTvPaymentScreenState extends State<CableTvPaymentScreen> {
  List<CableTvPlanModel> plans = [];
  String phoneNumber = "";
  bool loadingPlans = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPlans();
  }

  void loadPlans() {
    for (var element in ["Yanga", "Family", "Compact", "Premium"]) {
      // TODO : Load the network plans from the internet
      plans.add(CableTvPlanModel(
          provider: widget.provider,
          price: (40000).toDouble(),
          title: element));
    }
    //TODO : After loading disable the loading spinner
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loadingPlans = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Purchase"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: ThemedDarkBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!loadingPlans)
              Expanded(
                child: buildNetworkDataPlans(),
              ),
            if (loadingPlans)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ThemedColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ListView buildNetworkDataPlans() {
    Color color = widget.provider.color;
    String provider = widget.provider.title;

    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          bool active = index == selected;
          CableTvPlanModel plan = plans[index];
          return Transform.scale(
            scale: active ? 1.05 : 1,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: active ? 8 : 4, horizontal: 16),
              decoration: BoxDecoration(
                  color: active ? color.withOpacity(0.5) : Colors.black38,
                  border: Border.all(
                      color: active ? color : Colors.transparent, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
              child: InkWell(
                onTap: () {
                  if (!active) {
                    setState(() {
                      selected = index;
                    });
                  }

                  showBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                          CableTVInformationCapturingSheet(plan: plan));
                },
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan.title,
                                style: WhiteText.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${plan.description}",
                                style: WhiteText.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          Text(
                            widget.provider.title,
                            style: WhiteText.copyWith(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "N${plan.price}",
                        style: WhiteText.copyWith(
                            fontSize: 26, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  int selected = -1;
}

class CableTVInformationCapturingSheet extends StatefulWidget {
  const CableTVInformationCapturingSheet({Key? key, required this.plan})
      : super(key: key);

  final CableTvPlanModel plan;

  @override
  State<CableTVInformationCapturingSheet> createState() =>
      _CableTVInformationCapturingSheetState();
}

class _CableTVInformationCapturingSheetState
    extends State<CableTVInformationCapturingSheet> {
  String phoneNumber = "", smartCardNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ThemedDarkBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  selectedPlanWidget(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
                            .copyWith(bottom: 8),
                    child: Text(
                      "Enter the Decoder/Smart-Card Number ",
                      style: WhiteText.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                    child: TextInputField(
                      hint: "Decoder/Smart Card Number",
                      inputType: TextInputType.number,
                      onChanged: (number) {
                        setState(() {
                          smartCardNumber = number;
                        });
                      },
                      color: widget.plan.provider.color,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0)
                            .copyWith(bottom: 8, top: 10),
                    child: Text(
                      "Enter Phone Number",
                      style: WhiteText.copyWith(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                    child: TextInputField(
                      hint: "Phone Number",
                      inputType: TextInputType.number,
                      onChanged: (phone) {
                        setState(() {
                          phoneNumber = phone;
                        });
                      },
                      color: widget.plan.provider.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              text: "Buy (${widget.plan.price})",
              color: widget.plan.provider.color,
              onPressed: determinePayButtonAction(context),
            ),
          )
        ],
      ),
    );
  }

  Container selectedPlanWidget() {
    CableTvPlanModel plan = widget.plan;
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(32),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
              color: plan.provider.color.withOpacity(0.25), width: 4),
          gradient: LinearGradient(colors: [
            plan.provider.color.withAlpha(50),
            plan.provider.color.withAlpha(100)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.plan.title,
            style: WhiteText.copyWith(
                fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          Text(
            "N${widget.plan.price}",
            style: WhiteText.copyWith(
                fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "${widget.plan.description}",
            style: WhiteText.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          )
        ],
      ),
    );
  }

  Function()? determinePayButtonAction(BuildContext context) {
    if (phoneNumber.trim().isEmpty || phoneNumber.trim().length != 11)
      return null;
    if (smartCardNumber.trim().isEmpty ||
        smartCardNumber.trim().length !=
            widget.plan.provider.identificationLength) return null;

    return () {
      //TODO : Continue with data plan purchase

      CableTvPlanModel plan = widget.plan;

      TransactionModel transaction = TransactionModel(
          amount: plan.price,
          fields: [
            TransactionDescriptionField("Provider", plan.provider.title),
            TransactionDescriptionField("Plan", plan.title),
            TransactionDescriptionField("Price", "N${plan.price}"),
            TransactionDescriptionField("SmartCard Number", smartCardNumber),
            TransactionDescriptionField("Phone Number", phoneNumber),
          ],
          disclaimer: TransactionDisclaimer(
              title: "Disclaimer",
              description: "Make sure that the receiver`s "
                  "phone number and network provider is correct,"
                  " as successful transaction can not be reverted.",
              color: Colors.redAccent));
      showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => ConfirmPurchaseSheet(
                transaction: transaction,
              ));
    };
  }
}
