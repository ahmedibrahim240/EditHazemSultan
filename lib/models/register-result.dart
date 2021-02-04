
import 'package:flutter/material.dart';
import 'register_model.dart';

class Result extends StatelessWidget {
  RegisterModel registerModel;

  Result({this.registerModel});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Successful')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(registerModel.email, style: TextStyle(fontSize: 22)),
            Text(registerModel.password, style: TextStyle(fontSize: 22)),
          ],
        ),
      ),
    ));
  }
}