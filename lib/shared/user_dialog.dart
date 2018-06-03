import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/theme.dart' as Theme;
import '../utils/localization.dart';

class UserDialog extends StatelessWidget {
  const UserDialog({
    this.user,
    this.index = 0,
    this.handleAdd,
    this.handleChat,
  });

  final User user;
  final int index;
  final handleAdd;
  final handleChat;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image(
                image: Theme.Icons.icNullProfile,
                width: 80.0,
                height: 80.0,
              ),
              margin: const EdgeInsets.only(top: 40.0, bottom: 32.0),
            ),
            Container(
              child: Text(
                this.user.displayName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
            Container(
              child: Text(
                this.user.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 40.0),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: this.handleAdd,
                        child: Container(
                          child: Center(
                            child: Text(
                              Localization.of(context).trans("ADD_FRIEND"),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.Colors.dodgerBlue,
                              ),
                            ),
                          ),
                          height: 80.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 1.0,
                      height: 80.0,
                      color: Theme.Colors.paleGray,
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: this.handleChat,
                        child: Container(
                          child: Center(
                            child: Text(
                              Localization.of(context).trans("CHAT"),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Theme.Colors.dodgerBlue,
                              ),
                            ),
                          ),
                          height: 80.0,
                        ),
                      ),
                    ),
                  ],

                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
        width: 320.0,
        height: 320.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Theme.Colors.dodgerBlue, Theme.Colors.skyBlue],
            begin: FractionalOffset(0.0, 0.4),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.all(0.0),
    );
  }
}