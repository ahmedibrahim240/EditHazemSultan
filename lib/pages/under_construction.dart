import 'package:flutter/material.dart';

class UnderConstructionPage extends StatefulWidget {
  UnderConstructionPage({Key key}) : super(key: key);

  @override
  _UnderConstructionPageState createState() => _UnderConstructionPageState();
}

class _UnderConstructionPageState extends State<UnderConstructionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sorry!")
      ),
    );
  }
}
