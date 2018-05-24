import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    this.controller,
    this.txtLabel,
    this.txtHint,
    this.onChanged,
    this.secure = false,
  });

  final TextEditingController controller;
  final txtLabel;
  final txtHint;
  final ValueChanged<String> onChanged;
  final secure;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(child:
        TextField(
          controller: this.controller,
          style: TextStyle(
            color: Color.fromRGBO(74, 74, 74, 1.0),
            fontSize: 14.0,
          ),
          onChanged: this.onChanged,
          decoration: InputDecoration(
            hintText: this.txtHint,
            labelText: this.txtLabel,
          ),
          obscureText: this.secure,
          autocorrect: false,
        ),
        margin: const EdgeInsets.only(top: 8.0),
      ),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }
}
