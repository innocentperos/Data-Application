import 'package:flutter/material.dart';

import '../screens/theme_utils.dart';

class LinkText extends StatelessWidget {
  const LinkText({Key? key,required this.text, this.onPressed, this.icon}) : super(key: key);
  final String text;
  final Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap:  onPressed,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              text,
              style: WhiteText.copyWith(color: ThemedColor),

            ),
            if(icon != null ) const SizedBox(width: 8,),
            if(icon != null ) Icon(icon, color: ThemedColor,size: 18,)
          ],
        ),
      ),
    );
  }
}
