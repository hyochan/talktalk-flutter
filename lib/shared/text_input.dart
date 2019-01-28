import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    this.controller,
    this.txtLabel,
    this.txtHint,
    this.txtHintStyle,
    this.onChanged,
    this.secure = false,
    this.txtStyle = const TextStyle(
      color: Color.fromRGBO(74, 74, 74, 1.0),
      fontSize: 14.0,
    ),
    this.borderColor = const Color.fromRGBO(74, 74, 74, 1.0),
    this.margin = const EdgeInsets.only(top: 8.0),
    this.padding = const EdgeInsets.all(0.0),
    this.underline = true,
    this.background = Colors.white,
  });

  final TextEditingController controller;
  final txtLabel;
  final txtHint;
  final txtHintStyle;
  final ValueChanged<String> onChanged;
  final secure;
  final txtStyle;
  final borderColor;
  final margin;
  final padding;
  final underline;
  final background;

  @override
  Widget build(BuildContext context) {
    var inputDecoration;
    if (this.underline) {
      inputDecoration = InputDecoration(
        hintText: this.txtHint,
        labelText: this.txtLabel,
        hintStyle: this.txtHintStyle,
      );
    } else {
      inputDecoration = InputDecoration(
        hintText: this.txtHint,
        labelText: this.txtLabel,
        hintStyle: this.txtHintStyle,
        border: InputBorder.none,
      );
    }
    return Column(children: <Widget>[
      Container(
        child: TextField(
          controller: this.controller,
          style: this.txtStyle,
          onChanged: this.onChanged,
          decoration: inputDecoration,
          obscureText: this.secure,
          autocorrect: false,
        ),
        margin: this.margin,
        padding: this.padding,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: this.borderColor),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: this.background,
        ),
      ),
    ], crossAxisAlignment: CrossAxisAlignment.start);
  }
}
