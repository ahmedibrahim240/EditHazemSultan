import '../localization/localization_constants.dart';
import '../routes/route_names.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget {
  final String title;
  MainAppBar(this.title);
  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.white),
          actions: <Widget>[
            Container(
              width: 130,
              height: 5,
              padding: EdgeInsets.all(5),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.white)
                ),
                color: Color(0xFFd9ac51),
                child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                            child: Image(image: AssetImage('lib/assets/images/booking.png'),height: 17),
                          ),
                          Text(
                            getTranslated(context, 'book_now'),
                            style: TextStyle(color:Colors.white, fontFamily: 'Jf-Flat'),
                          ),
                        ],
                      ),
                onPressed: () {
                  Navigator.pushNamed(context, bookingRoute);
                }
              )
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          decoration: BoxDecoration(
            color: Colors.gold,
            borderRadius: BorderRadius.only(bottomRight:  Radius.circular(25),bottomLeft: Radius.circular(25)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Center(
              child: Text(
                        widget.title,
                        style: TextStyle(
                          color:Colors.white,
                          fontSize: 20
                        )
                      )
            ),
          ),
        ),
        
      ],
    );
  }
}