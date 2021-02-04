import 'package:flutter/material.dart';
import '../localization/localization_constants.dart';
import '../main.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 130,
                    child: RaisedButton(
                      color: Colors.gold,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(8,2,7,2),
                      splashColor: Colors.grey[300],
                      onPressed: () {
                        _changeLanguage('ar');
                      },
                      child: Text(
                        "اللغة العربية",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: FlatButton(
                      color: Colors.gold,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(8,7,8,8),
                      splashColor: Colors.grey[300],
                      onPressed: () {
                        _changeLanguage('en');
                      },
                      child: Text(
                        "English",
                        style: TextStyle(fontSize: 20.0),
                      )
                    )
                  ),
                ],
              )
        )
      ),
    );
  }

  void _changeLanguage(language) async {
    Locale _temp = await setLocale(language);
    HazemSultanApp.setLocale(context, _temp);
  }
}
