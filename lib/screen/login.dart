import 'package:validator/validator.dart';
import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../shared/btn.dart';

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

  void _login(BuildContext context) {
    // test version
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/tab_home',
      ModalRoute.withName('/intro'),
    );

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
      appBar: AppBar(
        title: Text(localization.trans('LOGIN'), style: TextStyle(color: Colors.black87)),
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
      body: Container(child:
        Form(
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
                        margin: const EdgeInsets.only(top: 30.0),
                      ),
                      Container(child:
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: localization.trans('PASSWORD'),
                            hintText: localization.trans('PASSWORD_HINT'),
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return localization.trans('NOT_VALID_PASSWORD');
                            }
                          },
                          autocorrect: false,
                          onSaved: (val) => _password = val,
                          obscureText: true,
                        ),
                        margin: const EdgeInsets.only(top: 10.0),
                      ),
                      Container(child:
                        Row(children: <Widget>[
                          Expanded(child:
                            Btn(
                              txt: localization.trans('SIGN_UP'),
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  '/sign_up',
                                );
                              },
                              height: 48.0,
                              color: Color.fromRGBO(13, 156, 197, 1.0),
                              margin: const EdgeInsets.only(left: 0.0, right: 6.0),
                            ),
                          ),
                          Expanded(child:
                            Btn(
                              txt: Localization.of(context).trans('LOGIN'),
                              onPress: () {
                                _submit(context);
                              },
                              height: 48.0,
                              color: Color.fromRGBO(13, 156, 197, 1.0),
                              margin: const EdgeInsets.only(left: 6.0, right: 0.0),
                            ),
                          ),
                        ]),
                        margin: const EdgeInsets.only(top: 40.0),
                      ),
                      Container(child:
                        FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/find_pw',
                            );
                          },
                          child: Text(
                            localization.trans('FORGOT_PASSWORD'),
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 13.0,
                              decoration: TextDecoration.combine([
                                TextDecoration.underline
                              ]),
                            ),
                          ),
                        ),
                        margin: const EdgeInsets.only(top: 10.0),
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
    );
  }
}
