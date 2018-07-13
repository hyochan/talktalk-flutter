import 'package:validator/validator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/localization.dart';
import '../shared/btn.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/theme.dart' as Theme;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<Profile> {
  final formKey = GlobalKey<FormState>();

  bool _loaded = false;
  final displayController = TextEditingController();
  final statusMsgController = TextEditingController();

  Future<DocumentSnapshot> getData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();
    displayController.text = snapshot.data['displayName'];
    statusMsgController.text= snapshot.data['statusMsg'];
    print('snapshot: ${snapshot.data.toString()}');
    return snapshot;
  }

  void _submit(BuildContext context) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _update(context);
    }
  }

  void _update(BuildContext context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print('user.uid: ${user.uid}');
    print('displayName: ${this.displayController.text}');
    print('displayName: ${this.displayController.text}');

    Firestore.instance.collection('users').document(user.uid)
    .setData({
      'displayName': this.displayController.text,
      'photoURL': '',
      'statusMsg': this.statusMsgController.text,
    });

//    if (user != null) {
//      var dialog = AlertDialog(
//        title: Text('Sign Up Completed'),
//        content: SingleChildScrollView(
//          child: ListBody(
//            children: <Widget>[
//              Text('Completed Profile'),
//            ],
//          ),
//        ),
//        actions: <Widget>[
//          FlatButton(
//            child: Text('OK'),
//            onPressed: () {
//              Navigator.of(context).pop(); // pop alert
//              Navigator.of(context).pop(); // pop screen
//            },
//          ),
//        ],
//      );
//      showDialog(context: context, builder: (BuildContext context) {
//        return dialog;
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.trans('PROFILE'), style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
        // centerTitle: false,
        /*actions: <Widget>[
          // action button
          FlatButton(child:
            Text(findPw),
            onPressed: () {
              print('PASSWORD_FIND');
            },
          ),
        ]*/
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: this.getData(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
//            case ConnectionState.none:
//              return new Text('Press button to start');
//            case ConnectionState.waiting:
//              return new Text('Awaiting result...');
            default:
              return Scaffold(
                body: Form(
                  key: formKey,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            Container(
                              child: FlatButton(
                                child: Image(
                                  image: Theme.Icons.icThumbMan,
                                  width: 120.0,
                                  height: 120.0,
                                ),
                                onPressed: () {
                                  print('onPressed');
                                },
                                color: Colors.transparent,
                              ),
                              margin: const EdgeInsets.only(top: 32.0),
                              width: 88.0,
                              height: 88.0,
                            ),
                            Container(child:
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: localization.trans('NAME'),
                                  hintText: localization.trans('NAME'),
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(4.0),
                                  ),
                                ),
                                controller: displayController,
                                autocorrect: false,
                              ),
                              margin: const EdgeInsets.only(top: 40.0),
                            ),
                            Container(child:
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: localization.trans('STATUS_MSG'),
                                  hintText: localization.trans('STATUS_MSG'),
                                  border: OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(4.0),
                                  ),
                                ),
                                controller: statusMsgController,
                                autocorrect: false,
                              ),
                              margin: const EdgeInsets.only(top: 24.0),
                            ),
                            Container(child:
                              RaisedButton(
                                child: Text(
                                  localization.trans('UPDATE'),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () { _submit(context); },
                                color: Theme.Colors.dodgerBlue,
                              ),
                              height: 60.0,
                              margin: const EdgeInsets.only(top: 32.0, bottom: 80.0),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
                resizeToAvoidBottomPadding: false,
//                constraints: BoxConstraints.expand(
//                  height: double.infinity,
//                  width: double.infinity,
//                ),
              );
          }
        },
      ),
    );
  }
}
