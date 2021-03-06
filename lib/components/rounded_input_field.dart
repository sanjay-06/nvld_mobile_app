import 'package:flutter/material.dart';
import 'package:nvld_app/components/text_field_container.dart';
import 'package:nvld_app/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  IconData? icon;
  final ValueChanged<String> onChanged;
  TextEditingController? controller;
  RoundedInputField(
      {required this.hintText,
      this.icon,
      required this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
