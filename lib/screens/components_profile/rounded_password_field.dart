import 'package:flutter/material.dart';
import './text_field_container.dart';
import '/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  // ignore: use_key_in_widget_constructors
  const RoundedPasswordField({
    required this.onChanged,
  });

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _flag,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _flag ? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                _flag = !_flag;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
