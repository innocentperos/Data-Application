import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';

class ProviderPicker extends StatefulWidget {
  const ProviderPicker({Key? key}) : super(key: key);

  @override
  State<ProviderPicker> createState() => _ProviderPickerState();
}

class _ProviderPickerState extends State<ProviderPicker> {
  int count = 4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          itemCount: count,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const ProviderPickerItem();
          }),
    );
  }
}

class ProviderPickerItem extends StatelessWidget {
  const ProviderPickerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Container(

        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [

            Icon(Icons.phone_android_outlined, color: Colors.white,size: 32,),
            Text(
              "Title",
              style: WhiteText,
            ),
          ],
        ),
      ),
    );
  }
}
