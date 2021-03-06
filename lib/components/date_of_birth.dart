import 'package:flutter/material.dart';
import 'package:nvld_app/components/text_field_container.dart';
import 'package:nvld_app/constants.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DOBField extends StatelessWidget {
  final String hintText;
  IconData? icon;
  final ValueChanged<String> onChanged;
  DOBField({required this.hintText, this.icon, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DateTimePicker(
        initialValue: '',
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
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
