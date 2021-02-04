import 'package:HazemSultan/http_services/utils.dart';
import 'package:flutter/cupertino.dart';

import '../localization/localization_constants.dart';
import '../routes/route_names.dart';
import '../models/register_model.dart';
import 'package:flutter/material.dart';
// import 'package:validators/validators.dart' as validator;
// import '../models/register-result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../drawers/main-drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  RegisterModel registerModel = RegisterModel();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();

  _uploadData() async{
    try {
      var response = await http.post(Utils.REGISTER_URL,
                                  body: {
                                      'name'    : _name.text,
                                      'email'   : _email.text,
                                      'mobile'  : _phone.text,
                                      'password': _password.text,
                                  });
      
      Map<String, dynamic> map = json.decode(response.body);
      setState(() async {
        // print('this is the userData data ${userData}');
        if (map['status'] == 'failed') {
          _handleClickMe(map['error']);
        }
        if (map['status'] == 'success') {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString('hazem_sultan_user_id', map['data']['id'].toString());
          await sharedPreferences.setString('hazem_sultan_user_name', map['data']['name'].toString());
          await sharedPreferences.setString('hazem_sultan_user_email', map['data']['email'].toString());
          await sharedPreferences.setString('hazem_sultan_user_phone', map['data']['phone'].toString());
          Navigator.pop(context);
          Navigator.pushNamed(context, homeRoute);
          _handleClickMe(getTranslated(context, 'registered-successfuly-message'));
        }
      });
      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _drawerKey,
      drawer: MainDrawer(),

      body: new Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context) {
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
                            bottomRight: Radius.circular(20)
                          )
                        ),
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
                      style: TextStyle(fontSize: 18,color: Colors.white),
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
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          new Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            color: Colors.white,
                            elevation: 4.0,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _name,
                                      decoration: new InputDecoration(
                                        hintText: getTranslated(context, 'name'),
                                        contentPadding: EdgeInsets.all(15.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color:Colors.grey[200],width:1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      }
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _phone,
                                      keyboardType: TextInputType.phone,
                                      decoration: new InputDecoration(
                                        hintText: getTranslated(context, 'phone'),
                                        contentPadding: EdgeInsets.all(15.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color:Colors.grey[200],width:1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      }
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: new InputDecoration(
                                        hintText: getTranslated(context, 'email'),
                                        contentPadding: EdgeInsets.all(15.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color:Colors.grey[200],width:1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (val) => val.isEmpty || !val.contains("@")
                                        ? "enter a valid eamil"
                                        : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _password,
                                      obscureText: true,
                                      decoration: new InputDecoration(
                                        hintText: getTranslated(context, 'password'),
                                        contentPadding: EdgeInsets.all(15.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color:Colors.grey[200],width:1),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      validator: (value) {
                                        if (value.length < 8) {
                                          return 'Password should be minimum 8 characters';
                                        }
                                        return null;
                                      }
                                    )
                                  ),
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _uploadData();
                                      }
                                    },
                                    child: Text(
                                      getTranslated(context, 'register'),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, loginRoute);
                                    }, 
                                    child: Text(
                                      getTranslated(context, 'login'),
                                      style: TextStyle(
                                        color: Colors.gold
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),

                          ),
                        ],
                      )
                    ),
                  )

                ],
              )
            )
          );
        },
      ),
    );
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