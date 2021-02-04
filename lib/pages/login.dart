import 'package:HazemSultan/http_services/utils.dart';
import 'package:flutter/cupertino.dart';
import '../localization/localization_constants.dart';
import '../routes/route_names.dart';
import '../models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginModel loginModel = LoginModel();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // ignore: unused_field
  TextEditingController _registerName = TextEditingController();
  // ignore: unused_field
  TextEditingController _registeremail = TextEditingController();

  _uploadData() async {
    try {
      var response = await http.post(Utils.LOGIN_URL,
          body: {'email': _email.text, 'password': _password.text});
      print('this is the response ${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      setState(() async {
        // print('this is the userData data ${userData}');
        if (map['status'] == 'failed') {
          _handleClickMe(map['error']);
        }
        if (map['status'] == 'success') {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString(
              'hazem_sultan_user_id', map['data']['id'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_name', map['data']['name'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_email', map['data']['email'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_phone', map['data']['phone'].toString());
          Navigator.pop(context);
          Navigator.pushNamed(context, homeRoute);
          _handleClickMe(
              getTranslated(context, 'loggedin-successfuly-message'));
        }
      });
      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  _loginWithFB(fbID, name, email) async {
    try {
      var response = await http.post(Utils.REGISTERWITHFACEBOOK_URL, body: {
        'fb_id': fbID,
        'name': name,
        'email': email,
        'mobile': 'null',
        'password': 'null',
      });

      Map<String, dynamic> map = json.decode(response.body);
      _handleClickMe(map);
      setState(() async {
        // print('this is the userData data ${userData}');
        if (map['status'] == 'failed') {
          _handleClickMe(map['error']);
        }
        if (map['status'] == 'success') {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString(
              'hazem_sultan_user_id', map['data']['id'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_name', map['data']['name'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_email', map['data']['email'].toString());
          await sharedPreferences.setString(
              'hazem_sultan_user_phone', map['data']['phone'].toString());
          Navigator.pop(context);
          Navigator.pushNamed(context, homeRoute);
          _handleClickMe(
              getTranslated(context, 'registered-successfuly-message'));
        }
      });
      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  Future<Null> _fbLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,email&access_token=$token');
        final profile = json.decode(graphResponse.body);
        _loginWithFB(accessToken.userId, profile['name'], profile['email']);
        break;
      case FacebookLoginStatus.cancelledByUser:
        _handleClickMe('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _handleClickMe('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                // The containers in the background
                new Column(
                  children: <Widget>[
                    new Container(
                      height: MediaQuery.of(context).size.height * .5,
                      decoration: BoxDecoration(
                          color: Colors.gold,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                    )
                  ],
                ),
                // The card widget with top padding,
                // incase if you wanted bottom padding to work,
                // set the `alignment` of container to Alignment.bottomCenter
                new Container(
                  height: 130,
                  padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .1,
                      right: 20.0,
                      left: 20.0),
                  alignment: Alignment.topCenter,
                  child: Image.asset('lib/assets/images/logo.png'),
                ),
                new Container(
                  padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .21,
                      right: 20.0,
                      left: 20.0),
                  alignment: Alignment.topCenter,
                  child: Text(
                    getTranslated(context, 'dr-hazem-sultan'),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Container(
                  alignment: Alignment.topCenter,
                  padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .3,
                      right: 20.0,
                      left: 20.0),
                  child: new Container(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          new Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.white,
                            elevation: 4.0,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: new InputDecoration(
                                        hintText:
                                            getTranslated(context, 'email'),
                                        contentPadding: EdgeInsets.all(15.0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[200],
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (val) =>
                                          val.isEmpty || !val.contains("@")
                                              ? "enter a valid email"
                                              : null,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                          controller: _password,
                                          obscureText: true,
                                          decoration: new InputDecoration(
                                            hintText: getTranslated(
                                                context, 'password'),
                                            contentPadding:
                                                EdgeInsets.all(15.0),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[200],
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                          validator: (value) {
                                            if (value.length < 8) {
                                              return 'Password should be minimum 8 characters';
                                            }
                                            return null;
                                          })),
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _uploadData();
                                      }
                                    },
                                    child: Text(
                                      getTranslated(context, 'login'),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 5,
                              left: 5,
                              child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, resetPasswordRoute);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        getTranslated(context,
                                            'can-not-remember-passord'),
                                        style: TextStyle(color: Colors.gold),
                                      ),
                                      Text(
                                        getTranslated(
                                            context, 'reset-password'),
                                        style: TextStyle(color: Colors.gold),
                                      )
                                    ],
                                  )))
                        ],
                      )),
                ),
                Positioned(
                    bottom: 65,
                    right: 5,
                    left: 5,
                    child: FlatButton(
                        onPressed: () {
                          _fbLogin();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              getTranslated(context, 'login-with-facebook'),
                              style: TextStyle(color: Colors.gold),
                            )
                          ],
                        ))),
                Positioned(
                    bottom: 25,
                    right: 5,
                    left: 5,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, registerRoute);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              getTranslated(context, 'not-a-member'),
                              style: TextStyle(color: Colors.gold),
                            ),
                            Text(
                              getTranslated(context, 'create-new-account'),
                              style: TextStyle(color: Colors.gold),
                            )
                          ],
                        )))
              ],
            )));
  }

  Future<void> _handleClickMe(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(getTranslated(context, 'system-message')),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(getTranslated(context, 'dismiss')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
