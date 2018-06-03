import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/theme.dart' as Theme;

class UserListItem extends StatefulWidget {
  final User user;
  final onTap;
  UserListItem(
    this.user,
    this.onTap,
  );

  @override
  UserListItemState createState() => UserListItemState(user, onTap);
}

class UserListItemState extends State<UserListItem> {
  final User user;
  final onTap;
  UserListItemState(this.user, this.onTap);

  @override
  Widget build(BuildContext context) {
    var img = user.img != ''
        ? Image.network(this.user.img)
        : AssetImage('assets/icons/icNullProfile.png');

    return RawMaterialButton(
      onPressed: this.onTap,
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image(
                image: Theme.Icons.icNullProfile,
                width: 40.0,
                height: 40.0,
              ),
              margin: const EdgeInsets.only(right: 20.0),
            ),
            Expanded(
              child: Text(
                this.user.displayName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.Colors.dusk,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text(
                this.user.statusMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.Colors.dusk,
                ),
              ),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.Colors.paleGray),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        padding: const EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
