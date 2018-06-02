import 'package:validator/validator.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../utils/localization.dart';
import '../shared/text_input.dart';
import '../shared/btn.dart';
import '../models/user.dart';
import '../shared/user_list_item.dart';
import '../utils/theme.dart' as Theme;

class SearchUser extends StatefulWidget {
  SearchUser({Key key}) : super(key: key);

  @override
  SearchUserState createState() => SearchUserState();
}

class SearchUserState extends State<SearchUser> {
  final formKey = GlobalKey<FormState>();
  List<User> userList;

  void _SearchUser() {
    print('signup');
  }

  void onSelectUser(User user, int index) {
    print('select user');
  }

  @override
  void initState() {
    userList = List<User>();
    User user = User();
    user.displayName = 'display name 1';
    user.email = 'hello@gmail.com';
    user.img = '';
    user.statusMsg = 'test';
    userList.add(user); // for header
    userList.add(user);
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.trans('FIND_USER'), style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
        // centerTitle: false,
        /*actions: <Widget>[
          // action button
          FlatButton(child:
            Text(SearchUser),
            onPressed: () {
              print('PASSWORD_FIND');
            },
          ),
        ]*/
      ),
      body: Container(
        child: RefreshIndicator(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(child:
                        TextInput(
                          txtHint: 'hint hint',
                          background: const Color.fromRGBO(243, 243, 243, 1.0),
                          underline: false,
                          txtHintStyle: TextStyle(
                            color: Theme.Colors.disabled,
                          ),
                          margin: const EdgeInsets.all(20.0),
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          borderColor: Colors.transparent,
                        ),
                      ),
                      Positioned(child:
                        Container(child:
                          RawMaterialButton(
                            padding: const EdgeInsets.all(0.0),
                            child: Image(image: Theme.Icons.icSearch),
                            onPressed: () {
                              print('search pressed');
                            },
                          ),
                          width: 40.0,
                          height: 40.0,
                        ),
                        right: 20.0,
                      ),
                    ],
                    alignment: Alignment.center,
                  ),
                ]);
              }
              return UserListItem(
                userList[index],
                () => this.onSelectUser(userList[index], index),
              );
            },
          ),
          onRefresh: () {
            Completer<Null> completer = Completer<Null>();
            Timer(Duration(seconds: 3), () {
              print("timer complete");
              completer.complete();
            });
            return completer.future;
          },
        ),
        constraints: BoxConstraints.expand(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
