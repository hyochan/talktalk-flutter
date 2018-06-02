import 'package:flutter/material.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import './utils/localization.dart';

import './screen/loading.dart';
import './screen/login.dart';
import './screen/sign_up.dart';
import './screen/find_pw.dart';
import './screen/home.dart';
import './screen/search_user.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/loading': (BuildContext context) => Loading(),
      '/login': (BuildContext context) => Login(),
      '/sign_up': (BuildContext context) => SignUp(),
      '/find_pw': (BuildContext context) => FindPw(),
      '/tab_home': (BuildContext context) => Home(),
      '/search_user': (BuildContext context) => SearchUser(),
    },
    supportedLocales: [
      const Locale('en', 'US'),
      const Locale('ko', 'KR')
    ],
    localizationsDelegates: [
      const LocalizationDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },
    title: 'TalkTalk',
    home: Home(),
//    home: Home(),
  ));
}
