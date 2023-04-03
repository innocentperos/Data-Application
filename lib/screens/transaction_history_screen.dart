import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions History"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: ThemedDarkBg,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: Row(
              children: [
                const Chip(label: Text("Top Up")),
                const SizedBox(width: 8,),
                const Chip(label: Text("Bills")),
                const Expanded(child: SizedBox()),
                IconButton(onPressed: (){

                }, color: ThemedColor, icon: const Icon(Icons.calendar_month))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
                itemBuilder: (context, index){

              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.outbond_outlined, color: Colors.white,size: 32,),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("2 GB (MTN) ", style: WhiteText.copyWith(fontSize: 18, color: Colors.white70),),
                          Text("0916537647", style: WhiteText.copyWith(fontSize: 16, color: Colors.white70),),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Column(
                      children: [
                        Text("- N 2,000", style: WhiteText.copyWith(fontSize: 18, color: Colors.redAccent.shade200, fontWeight: FontWeight.bold),),
                        Text("Yesterday ", style: WhiteText.copyWith(fontSize: 14, color: Colors.white70, ),),
                      ],
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
