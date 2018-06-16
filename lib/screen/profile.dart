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

  String _displayName;
  String _statusMsg;

  Future<DocumentSnapshot> getData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();
//    this._displayName = snapshot.data['displayName'];
//    this._statusMsg = snapshot.data['statusMsg'];
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
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Firestore.instance.collection('users').document()
    .setData({
      'displayName': _displayName,
      'photoURL': '',
      'statusMsg': _statusMsg,
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
            case ConnectionState.none: return new Text('Press button to start');
            case ConnectionState.waiting: return new Text('Awaiting result...');
            default:
              return Container(
                child: Form(
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
                                    autocorrect: false,
                                    onSaved: (val) => _displayName = val,
                                    initialValue: snapshot.data['displayName'],
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
                                    autocorrect: false,
                                    onSaved: (val) => _statusMsg = val,
                                    initialValue: snapshot.data['statusMsg'],
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
                constraints: BoxConstraints.expand(
                  height: double.infinity,
                  width: double.infinity,
                ),
              );
          }
        },
      ),
    );
  }
}
