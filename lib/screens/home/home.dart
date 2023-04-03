import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/change_notifiers/home_change_notifier.dart';
import 'package:untitled1/screens/airtime_purchase_screen.dart';
import 'package:untitled1/screens/cable_tv_payment_screen.dart';
import 'package:untitled1/screens/data_purchase_screen.dart';
import 'package:untitled1/screens/fund.dart';
import 'package:untitled1/screens/theme_utils.dart';
import 'package:untitled1/screens/transaction_history_screen.dart';
import 'package:untitled1/uis/link.dart';
import 'package:untitled1/uis/service_provider_picker.dart';

import '../../models/data_models.dart';
import '../../uis/cable_table_provider_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeChangeNotifier changeNotifier = HomeChangeNotifier();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeNotifier.loadingBalance = true;

    //TODO : Load the users account
    Future.delayed(const Duration(seconds: 1), () {
      changeNotifier.loadingBalance = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemedDarkBg,
      body: SafeArea(child: Builder(builder: (context) {
        return ChangeNotifierProvider<HomeChangeNotifier>(
          create: (context) => changeNotifier,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16).copyWith(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: ThemedColorDark,
                            child: Icon(Icons.person_outline_rounded),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Hello Innocent",
                            style: WhiteText.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                              color: Colors.black38,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  LinkText(
                                    text: "View Transaction history",
                                    icon: Icons.history,
                                    onPressed: () {
                                      //  TODO: View transaction history
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TransactionHistoryScreen()));
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Consumer<HomeChangeNotifier>(
                                      builder: (context, model, child) {
                                        return InkWell(
                                          onTap: () {
                                            //  TODO : Show or hide account balance
                                            model.showAccount =
                                            !model.showAccount;
                                          },
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Stack(
                                              children: [
                                                const Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: ThemedColor,
                                                ),
                                                if (!model.showAccount)
                                                  const Icon(
                                                    Icons.clear,
                                                    color: ThemedColor,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Your balance",
                                    style: WhiteText.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                              Consumer<HomeChangeNotifier>(
                                  builder: (context, model, child) {
                                    return Stack(
                                      children: [
                                        if (!model.loadingBalance)
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                getBalanceDisplayText(model),
                                                style: WhiteText.copyWith(
                                                    fontSize:
                                                    getBalanceFontSize(model),
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.2),
                                              ),
                                              IconButton(
                                                  onPressed:
                                                  determineRefreshButtonAction(
                                                      model),
                                                  icon: const Icon(
                                                    Icons.refresh,
                                                    color: ThemedColor,
                                                  ))
                                            ],
                                          ),
                                        if (model.loadingBalance)
                                          const CircularProgressIndicator(
                                            valueColor:
                                            AlwaysStoppedAnimation(ThemedColor),
                                          )
                                      ],
                                    );
                                  }),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: TileButton(
                                        text: "Fund Wallet",
                                        description:
                                        "Add money to your data account",
                                        icon: Icons.add_rounded,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const FundPage()));
                                        },
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: SquaredTileButton(
                                text: "Purchase Data",
                                description:
                                "Buy a data plan for any of the supported networks",
                                icon: Icons.network_cell_rounded,
                                onPressed: () {
                                  //      TODO : Goto data purchase screen
                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return ServiceProviderSelector(
                                          items:
                                          NigerianNetworkServiceProviders,
                                          onPressed: (provider) async {
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DataPurchaseScreen(
                                                          networkProvider:
                                                          provider,
                                                        )));

                                            Navigator.of(context).pop();
                                          },
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: SquaredTileButton(
                                color: Colors.teal,
                                text: "Purchase Airtime",
                                description:
                                "Send airtel of the supported supported networks",
                                icon: Icons.phone,
                                onPressed: () {
                                  //      TODO : Goto airtime purchase

                                  showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return ServiceProviderSelector(
                                          items:
                                          NigerianNetworkServiceProviders,
                                          onPressed: (provider) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AirtimePurchaseScreen(
                                                            provider:
                                                            provider)));
                                          },
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const AspectRatio(
                        aspectRatio: 4,
                        child: TileButton(
                            color: Colors.blue,
                            text: "Pay Bills",
                            description: "Pay for electric bill and others",
                            icon: Icons.electric_bolt_rounded),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AspectRatio(
                        aspectRatio: 4,
                        child: TileButton(
                          color: Colors.purple,
                          text: "Cable Television",
                          description:
                          "Pay for your DSTV, StarTimes, and GoTV subscriptions",
                          icon: Icons.tv_rounded,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return CableTVProviderSelector(
                                    items: NigerianCableTVProviders,
                                    onPressed: (provider) async {
                                      await Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CableTvPaymentScreen(
                                                    provider: provider,
                                                  )));

                                      Navigator.of(context).pop();
                                    },
                                  );
                                });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16).copyWith(top: 1, bottom: 8),
                  decoration: const BoxDecoration(
                    color: ThemedDarkBg,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF313130),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BottomNavigationBar(
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home_rounded), label: "Wallet"),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.report),
                            label: "Issues",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.settings),
                            label: "Settings",
                          ),
                        ],
                        backgroundColor: Colors.transparent,
                        selectedItemColor: ThemedColor,
                        unselectedItemColor: Colors.white54,
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      })),
    );
  }

  Function()? determineRefreshButtonAction(HomeChangeNotifier model) {
    if (model.loadingBalance) {
      return null;
    }
    return () {
      //  Todo : Refresh the users account balance
      model.refreshBalance();
    };
  }

  String getBalanceDisplayText(HomeChangeNotifier model) {
    return (model.showAccount ? "N${model.balance}" : "***");
  }

  double getBalanceFontSize(HomeChangeNotifier model) =>
      model.balance > 10000 ? 42 : 52;
}

class TileButton extends StatelessWidget {
  const TileButton({Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.color,
    required this.description})
      : super(key: key);
  final IconData icon;
  final String text, description;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color != null
            ? color!.withOpacity(0.25)
            : ThemedColorDark.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        splashColor: color != null ? color! : ThemedColorDark,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: WhiteText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      description,
                      softWrap: true,
                      style: WhiteText.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SquaredTileButton extends StatelessWidget {
  const SquaredTileButton({Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
    this.color,
    required this.description})
      : super(key: key);
  final IconData icon;
  final String text, description;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color != null
            ? color!.withOpacity(0.25)
            : ThemedColorDark.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        splashColor: color != null ? color! : ThemedColorDark,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: WhiteText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                description,
                softWrap: true,
                style: WhiteText.copyWith(fontSize: 14, wordSpacing: 1.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
