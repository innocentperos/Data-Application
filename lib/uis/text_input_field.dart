import 'package:flutter/material.dart';
import 'package:untitled1/screens/theme_utils.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({Key? key, this.onChanged, this.hint, this.prependIcon, this.appendIcon , this.inputType, this.color = ThemedColor}) : super(key: key);

  final String? hint;
  final TextInputType? inputType;
  final IconData? prependIcon;
  final IconData? appendIcon;
  final Color color;
  final Function(String)? onChanged ;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.05),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: TextField(
            keyboardType: widget.inputType,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              // prefixIcon: Icon(widget.prependIcon, ),
              //   suffixIcon: Icon(widget.appendIcon),
                isDense: true,
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none),
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ),
        Container(
          color: widget.color.withOpacity(0.7),
          height: 2,
        )
      ],
    );
  }
}
