import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import '../drawers/main-drawer.dart';
import 'package:flutter/material.dart';

class Consultations extends StatefulWidget {
  Consultations({Key key}) : super(key: key);

  @override
  _ConsultationsState createState() => _ConsultationsState();
}

class _ConsultationsState extends State<Consultations> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(105.0),
                child: MainAppBar(getTranslated(context, 'consultations'))
              ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  getTranslated(context, 'dr-hazem-sultan'),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey
                  ),
                ),
                Text(
                  '16-08-2020',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                  ),
                ),
                Container(
                  width: 100,
                  color: Colors.gold,
                  height: 1,
                  margin: EdgeInsets.only(top:3),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'small text for this data small text for this data small text for this data ...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
