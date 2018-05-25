import 'package:flutter/material.dart';
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    var icApp = AssetImage("assets/icons/app-icon.png");

    return Scaffold(
      body: Container(
        child: new Column(
          children: <Widget>[
            Image(
              image: icApp,
              width: 100.2,
              height: 61.6,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(top: 6.0),
              child: Text(
                'Talk Talk',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
        ),
        constraints: BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.Colors.dodgerBlue, Theme.Colors.skyBlue],
            begin: FractionalOffset(0.0, 0.4),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}
