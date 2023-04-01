import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/uis/button.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/text_input_field.dart';

import '../models/data_models.dart';
import '../models/transaction_model.dart';
import '../uis/confirmation_sheet.dart';

class DataPurchaseScreen extends StatefulWidget {
  const DataPurchaseScreen({Key? key, required this.networkProvider})
      : super(key: key);

  final NetworkProviderModel networkProvider;

  @override
  State<DataPurchaseScreen> createState() => _DataPurchaseScreenState();
}

class _DataPurchaseScreenState extends State<DataPurchaseScreen> {

  List<NetworkProviderDataPlan> plans = [];
  String phoneNumber = "";
  bool loadingPlans = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPlans();
  }

  void loadPlans() {
    for (var element in [1, 2, 5, 10]) {

      // TODO : Load the network plans from the internet
      plans.add(NetworkProviderDataPlan(
          provider: widget.networkProvider,
          price: (260 * element).toDouble(), amount: element));
    }
    //TODO : After loading disable the loading spinner
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        loadingPlans = false;
      });
    });

    plans.insert(0, NetworkProviderDataPlan(price: 260 / 2,
        amount: 500,
        provider: widget.networkProvider,
        unit: DataUnit.MB));
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
            if(!loadingPlans)Expanded(
              child: buildNetworkDataPlans(),
            ),
            if(loadingPlans) const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ThemedColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Text(
                    "Enter the receivers phone number here ",
                    style: WhiteText.copyWith(fontSize: 12),
                  ),
                  const Expanded(child: SizedBox(width: 40,)),
                  LinkText(
                    text: "it for me".toUpperCase(),
                    onPressed: () {
                      //  TODO : Paste user`s phone number into phone number input field
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 0),
              child: TextInputField(
                hint: "Phone Number",
                onChanged: (phone) {
                  setState(() {
                    phoneNumber = phone;
                  });
                },
                color: widget.networkProvider.color,
              ),
            ),
            if (selected > -1)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  text: "Buy (${plans[selected].price})",
                  color: widget.networkProvider.color,
                  onPressed: (phoneNumber.trim().isEmpty || phoneNumber.trim().length != 11 ) ? null:  () {
                    //TODO : Continue with data plan purchase

                    NetworkProviderDataPlan plan = plans[selected];

                    TransactionModel transaction = TransactionModel(
                        amount: plan.price,
                        fields: [
                          TransactionDescriptionField(
                              "Provider", plan.provider.title),
                          TransactionDescriptionField(
                              "Plan", "${plan.amount}${plan.unit.name}"),
                          TransactionDescriptionField(
                              "Phone Number", phoneNumber),
                        ], disclaimer: TransactionDisclaimer(
                        title: "Disclaimer",
                        description: "Make sure that the receiver`s "
                            "phone number and network provider is correct,"
                            " as successful transaction can not be reverted.",
                      color: Colors.redAccent
                    ));
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            ConfirmPurchaseSheet(
                              transaction: transaction,
                            ));
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  ListView buildNetworkDataPlans() {
    Color color = widget.networkProvider.color;
    String provider = widget.networkProvider.title;

    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          bool active = index == selected;
          NetworkProviderDataPlan plan = plans[index];
          return Transform.scale(
            scale: active ? 1.05 : 1,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: active ? 8 : 4, horizontal: 16),
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
                                "${plan.amount} ${plan.unit.name}",
                                style: WhiteText.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${plan.duration} days",
                                style: WhiteText.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 8,),
                            ],
                          ),

                          Text(
                            widget.networkProvider.title,
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

