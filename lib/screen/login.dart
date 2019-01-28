import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../shared/btn.dart';
import '../utils/theme.dart' as Theme;

import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  void _submit(BuildContext context) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _login(context);
    }
  }

  Future<void> _login(BuildContext context) async {
    print('email: $_email, password: $_password');
    // test version
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(user);

      if (user == null) {
        throw new Exception('no user found');
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/tab_home',
        ModalRoute.withName('/intro'),
      );
    } on Exception {
      var dialog = AlertDialog(
        title: Text('No user found'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Check email and password.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // pop alert
            },
          ),
        ],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }

    // production version
    /*Map lMap = {"email": emailController.text, "pw": pwController.text};
    String lData = JSON.encode(lMap);
    Map lHeaders = {"Content-type": "application/json", "Accept": "application/json"};
    http.Response lResp = await http.post(lUrl, body: lData, headers: lHeaders);*/
    // when failed login from server
    /* AlertDialog dialog = AlertDialog(
      title: Text(warningTxt),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(pwHintTxt),
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);*/
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Form(
            key: formKey,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Image(
                                image: Theme.Icons.icApp,
                                width: 60.0,
                                height: 48.0,
                              ),
                              padding: const EdgeInsets.only(top: 110.0),
                              margin: const EdgeInsets.only(bottom: 16.0),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Hello',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: localization.trans('EMAIL_ADDRESS'),
                              hintText: localization.trans('EMAIL_HINT'),
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                            ),
                            validator: (val) {
//                          if (!isEmail(val)) {
//                            return localization.trans('NOT_VALID_EMAIL');
//                          }
                            },
                            autocorrect: false,
                            onSaved: (val) => _email = val,
                          ),
                          margin: const EdgeInsets.only(top: 110.0),
                        ),
                        Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: localization.trans('PASSWORD'),
                              hintText: localization.trans('PASSWORD_HINT'),
                              border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(4.0),
                              ),
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return localization.trans('TYPE_PASSWORD');
                              }
                            },
                            autocorrect: false,
                            onSaved: (val) => _password = val,
                            obscureText: true,
                          ),
                          margin: const EdgeInsets.only(top: 10.0),
                        ),
                        Container(
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Btn(
                                txt: localization.trans('SIGN_UP'),
                                onPress: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/sign_up',
                                  );
                                },
                                height: 60.0,
                                fontSize: 16.0,
                                color: Color.fromRGBO(13, 156, 197, 1.0),
                                margin: const EdgeInsets.only(
                                    left: 0.0, right: 6.0),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: RaisedButton(
                                  child: Text(
                                    localization.trans('LOGIN'),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _submit(context);
                                  },
                                  color: Theme.Colors.dodgerBlue,
                                ),
                                height: 60.0,
                              ),
                            ),
                          ]),
                          margin: const EdgeInsets.only(top: 20.0),
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/find_pw',
                              );
                            },
                            child: Text(
                              localization.trans('FORGOT_PASSWORD') + '?',
                              style: TextStyle(
                                color: Theme.Colors.dodgerBlue,
                                fontSize: 12.0,
                                decoration: TextDecoration.combine(
                                    [TextDecoration.underline]),
                              ),
                            ),
                          ),
                          margin:
                              const EdgeInsets.only(top: 10.0, bottom: 112.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          constraints: BoxConstraints.expand(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
