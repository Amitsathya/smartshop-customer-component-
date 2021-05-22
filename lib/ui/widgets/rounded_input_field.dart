import 'package:flutter/material.dart';
import 'text_field_container.dart';
import 'package:smartshop/global.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController Controler;
  final ValueChanged<String> onChanged;
  final bool readonly;
  const RoundedInputField({
    Key key,
    this.hintText = '',
    this.icon = Icons.person,
    this.onChanged,
    this.readonly = false,
    this.Controler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: Controler,
        cursorColor: kPrimaryColor,
        textAlign: TextAlign.center,
        autofocus: false,
        readOnly: readonly,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
