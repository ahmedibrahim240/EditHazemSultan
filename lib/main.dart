import 'localization/app_localization.dart';
import 'localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/custome_router.dart';
import 'routes/route_names.dart';

void main() {
  runApp(HazemSultanApp());
}

class HazemSultanApp extends StatefulWidget {
  // This widget is the root of your application.

  static void setLocale(BuildContext context, Locale locale) {
    _HazemSultanAppState state =
        context.findAncestorStateOfType<_HazemSultanAppState>();
    state.setLocale(locale);
  }

  @override
  _HazemSultanAppState createState() => _HazemSultanAppState();
}

class _HazemSultanAppState extends State<HazemSultanApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void didChangeDependancies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.gold, fontFamily: 'Jf-Flat'),
        supportedLocales: [
          const Locale('ar', 'EG'),
          const Locale('en', 'US'),
        ],
        locale: _locale,
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }

          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter.allRoutes,
        initialRoute: homeRoute,
        debugShowCheckedModeBanner: false);
  }
}
