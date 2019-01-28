import 'package:flutter/material.dart';

import '../utils/localization.dart';
import '../shared/btn.dart';
import '../utils/theme.dart' as Theme;

class FindPw extends StatefulWidget {
  FindPw({Key key}) : super(key: key);

  @override
  FindPwState createState() => FindPwState();
}

class FindPwState extends State<FindPw> {
  final formKey = GlobalKey<FormState>();
  String _email;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _findPw();
    }
  }

  void _findPw() {
    print('signup');
  }

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.trans('FIND_PASSWORD'),
            style: TextStyle(color: Colors.black87)),
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
//                            if (!isEmail(val)) {
//                              return localization.trans('NOT_VALID_EMAIL');
//                            }
                          },
                          autocorrect: false,
                          onSaved: (val) => _email = val,
                        ),
                        margin: const EdgeInsets.only(top: 40.0),
                      ),
                      Container(
                        child: RaisedButton(
                          child: Text(
                            localization.trans('SEND'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _submit,
                          color: Theme.Colors.dodgerBlue,
                        ),
                        height: 60.0,
                        margin: const EdgeInsets.only(top: 20.0, bottom: 80.0),
                      ),
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
