import 'package:validator/validator.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import '../utils/localization.dart';
import '../shared/btn.dart';
import '../utils/theme.dart' as Theme;
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _passwordOk;

  void _submit(BuildContext context) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
    _signUp(context);
    }
  }

  void _signUp (BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);

    if (user != null) {
      var dialog = AlertDialog(
        title: Text('Sign Up Completed'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Completed signup'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // pop alert
              Navigator.of(context).pop(); // pop screen
            },
          ),
        ],
      );
      showDialog(context: context, builder: (BuildContext context) {
        return dialog;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.trans('SIGN_UP'), style: TextStyle(color: Colors.black87)),
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
      body: Container(
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Container(child:
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.trans('EMAIL_ADDRESS'),
                          hintText: localization.trans('EMAIL_HINT'),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                        ),
                        validator: (val) {
                          if (!isEmail(val)) {
                            return localization.trans('NOT_VALID_EMAIL');
                          }
                        },
                        autocorrect: false,
                        onSaved: (val) => _email = val,
                      ),
                      margin: const EdgeInsets.only(top: 60.0),
                    ),
                    Container(child:
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.trans('PASSWORD'),
                          hintText: localization.trans('PASSWORD_HINT'),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                        ),
                        validator: (val) {
                          if (val.length < 6 || isAlpha(val) || isNumeric(val)) {
                            return localization.trans('NOT_VALID_PASSWORD');
                          }
                          _password = val;
                        },
                        autocorrect: false,
                        onSaved: (val) => _password = val,
                        obscureText: true,
                      ),
                      margin: const EdgeInsets.only(top: 32.0),
                    ),
                    Container(child:
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.trans('PASSWORD_OK'),
                          hintText: localization.trans('PASSWORD_OK_HINT'),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                        ),
                        validator: (val) {
                          if (val != _password) {
                            return localization.trans('NOT_VALID_PASSWORD_OK');
                          }
                        },
                        autocorrect: false,
                        onSaved: (val) => _passwordOk = val,
                        obscureText: true,
                      ),
                      margin: const EdgeInsets.only(top: 32.0),
                    ),
                    Container(child:
                      RaisedButton(
                        child: Text(
                          localization.trans('SIGN_UP'),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () { _submit(context); },
                        color: Theme.Colors.dodgerBlue,
                      ),
                      height: 60.0,
                      margin: const EdgeInsets.only(top: 40.0, bottom: 80.0),
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
      ),
    );
  }
}
