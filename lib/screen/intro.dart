import 'package:flutter/material.dart';
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart';
import '../shared/btn.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    var icApp = AssetImage("assets/icons/app-icon.png");

    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 168.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Image(image: icApp, width: 48.0, height: 48.0),
                    Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        'Talk Talk',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ], 
                ),
              ),
            ),
          ],
        ),
        constraints: BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.Colors.darkGray, Theme.Colors.darkGrayTwo],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
    );
  }
}
