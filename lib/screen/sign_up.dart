import 'package:validator/validator.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../shared/btn.dart';

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

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
    _signUp();
    }
  }

  void _signUp() {
    print('signUp');
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
                        ),
                        validator: (val) {
                          if (!isEmail(val)) {
                            return localization.trans('NOT_VALID_EMAIL');
                          }
                        },
                        autocorrect: false,
                        onSaved: (val) => _email = val,
                      ),
                      margin: const EdgeInsets.only(top: 20.0),
                    ),
                    Container(child:
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.trans('PASSWORD'),
                          hintText: localization.trans('PASSWORD_HINT'),
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
                      margin: const EdgeInsets.only(top: 10.0),
                    ),
                    Container(child:
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: localization.trans('PASSWORD_OK'),
                          hintText: localization.trans('PASSWORD_OK_HINT'),
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
                      margin: const EdgeInsets.only(top: 10.0),
                    ),
                    Container(child:
                      Btn(
                        txt: localization.trans('SIGN_UP'),
                        onPress: _submit,
                        height: 48.0,
                        color: Color.fromRGBO(13, 156, 197, 1.0),
                        margin: const EdgeInsets.only(left: 0.0, right: 6.0),
                      ),
                      margin: const EdgeInsets.only(top: 40.0),
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
