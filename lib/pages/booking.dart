import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:HazemSultan/http_services/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class BookingPage extends StatefulWidget {
  BookingPage({Key key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class Item {
  const Item(this.name, this.value);
  final String name;
  final String value;
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _age = TextEditingController();
  // ignore: unused_field
  TextEditingController _date = TextEditingController();
  String chossenDate = DateTime.now().toString();

  List<Item> users = <Item>[
    const Item('Male', 'male'),
    const Item('Female', 'female')
  ];
  Item selectedUser;

  String userID, userName, userEmail;
  Future<void> getLoggeInUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString('hazem_sultan_user_id');
      userName = sharedPreferences.getString('hazem_sultan_user_name');
      userEmail = sharedPreferences.getString('hazem_sultan_user_email');
    });
  }

  _uploadData() async {
    try {
      var response = await http.post(Utils.BOOKNOW_URL, body: {
        'name': _name.text,
        'gender': _gender.text,
        'age': _age.text,
        'date': chossenDate,
        'user_id': userID
      });
      print('this is the responseثثثثثثثثثثثثث :${response.body}');
      Map<String, dynamic> map = json.decode(response.body);
      setState(() async {
        // print('this is the userData data ${userData}');
        if (map['status'] == 'failed') {
          _handleClickMe(map['error']);
        }
        if (map['status'] == 'success') {
          _handleClickMe(getTranslated(context, 'booked-successfuly-message'));
        }
      });
      // Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getLoggeInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: MainAppBar(getTranslated(context, 'book_now'))),
      body: Material(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose Your Prefered Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 4),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Colors.gold,
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              },
                              onConfirm: (date) {
                                setState(() {
                                  chossenDate = date.toString();
                                });
                                print('confirm $date');
                              },
                              currentTime: DateTime.now(),
                            );
                          },
                          child: Text(
                            chossenDate,
                            style: TextStyle(
                              color: Colors.gold,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _name,
                        decoration: new InputDecoration(
                          hintText: 'Your Name',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey[200], width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (val) =>
                            val.isEmpty ? "enter your name" : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _age,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: 'age',
                          contentPadding: EdgeInsets.all(15.0),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey[200], width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (val) =>
                            val.isEmpty ? "enter your age" : null,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButton<Item>(
                        hint: Text("Select Your Gender"),
                        value: selectedUser,
                        // ignore: non_constant_identifier_names
                        onChanged: (Item Value) {
                          setState(() {
                            selectedUser = Value;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  user.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _uploadData();
                        }
                      },
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
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
