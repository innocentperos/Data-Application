import 'package:flutter/material.dart';

import '../screens/theme_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.loading = false,
      this.text,
      this.onPressed,
      this.color = ThemedColorDark,
      this.onDisabledPressed,
      this.child})
      : super(key: key);

  final String? text;
  final bool loading;
  final Color color;
  final Function()? onPressed, onDisabledPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
            minimumSize: const Size(128, 46),
            backgroundColor: color,
            disabledBackgroundColor: color.withOpacity(0.25)),
        onPressed: loading ? null : (onPressed ?? onDisabledPressed),
        child: determineChild(),
      ),
    );
  }

  Widget determineChild() {
    if (loading) {
      return Center(
        child: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(color),
            strokeWidth: 4,
          ),
        ),
      );
    }
    if (child != null) return child!;

    return Text(
      text!.toUpperCase(),
      style: WhiteText.copyWith(
          letterSpacing: 1.5, color: Colors.white, fontWeight: FontWeight.w600),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {Key? key,
      required this.text,
      this.color = ThemedColorDark,
      this.loading = false,
      this.onPressed})
      : super(key: key);
  final String text;
  final Color color;
  final bool loading;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            side: BorderSide(color: color)),
        onPressed: loading ? null : onPressed,
        child: loading
            ? Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(color),
                  strokeWidth: 4,
                ),
              )
            : Text(
                text!.toUpperCase(),
                style: WhiteText.copyWith(letterSpacing: 1.5, color: color),
              ),
      ),
    );
  }
}
