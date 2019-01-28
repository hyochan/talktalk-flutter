import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({
    this.txt = '',
    this.image,
    this.width,
    this.height = 52.0,
    this.onPress,
    this.color = Colors.white,
    this.fontSize = 14.0,
    this.margin = const EdgeInsets.only(left: 28.0, right: 28.0),
    this.txtMargin = const EdgeInsets.only(left: 50.0),
    this.alignment = Alignment.center,
    this.center = true,
    this.border = true,
  });

  final String txt;
  final Image image;
  final double width;
  final double height;
  final VoidCallback onPress;
  final color;
  final double fontSize;
  final margin;
  final txtMargin;
  final alignment;
  final bool center;
  final bool border;

  @override
  Widget build(BuildContext context) {
    var text;
    var boxDecoration;
    if (this.center == true) {
      text = Center(
        child: Text(
          this.txt,
          style: TextStyle(
            color: this.color,
            fontSize: this.fontSize,
          ),
        ),
      );
    } else {
      text = Row(children: <Widget>[
        Text(
          this.txt,
          style: TextStyle(
            color: this.color,
            fontSize: this.fontSize,
          ),
        ),
      ]);
    }
    if (this.border) {
      boxDecoration = BoxDecoration(
        border: Border.all(width: 1.5, color: this.color),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      );
    } else {
      boxDecoration = BoxDecoration(
        border: Border.all(width: 0.0, color: Colors.transparent),
      );
    }
    return Container(
      child: FlatButton(
        child: Column(children: <Widget>[
          Expanded(
            child: Stack(
              alignment: this.alignment,
              children: <Widget>[
                Positioned(
                  child: Container(
                    child: this.image,
                  ),
                  left: 2.0,
                ),
                Container(
                  child: text,
                  margin:
                      this.center ? const EdgeInsets.all(0.0) : this.txtMargin,
                ),
              ],
            ),
          ),
        ]),
        onPressed: () {
          this.onPress();
        },
      ),
      decoration: boxDecoration,
      margin: this.margin,
      height: this.height,
      width:
          this.width != null ? this.width : MediaQuery.of(context).size.width,
    );
  }
}
