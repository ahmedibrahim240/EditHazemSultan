import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import 'package:flutter/material.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<dynamic> homeData;

  Future getJsonData() async {
    try {
      var response = await http.post(Utils.HOME_DATA_URL, body: {'lang': 'ar'});
      homeData = json.decode(response.body);
      return homeData[0];
      // print(homeData[0]['HomeTitle_'+getTranslated(context, 'this_lang_code')]);
    } catch (e) {
      print(e.toString());
    }
  }

  _openLink(type, url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  _displayData() {
    return FutureBuilder(
        future: getJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // List<dynamic> thisPageData = snapshot.data ;
            return ListView(children: <Widget>[
              (homeData[0]['LandLine'] != "" && homeData[0]['LandLine'] != null)
                  ? Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                            )),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () async {
                                      var _phoneURL =
                                          "tel:${homeData[0]['LandLine']}";
                                      if (await canLaunch(_phoneURL)) {
                                        launch(_phoneURL);
                                      }
                                    },
                                    child: Text(homeData[0]['LandLine'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18))))),
                      ],
                    )
                  : Container(),
              (homeData[0]['email'] != null && homeData[0]['email'] != "")
                  ? Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                            )),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () async {
                                      var _whatsAppURL =
                                          "mailto:${homeData[0]['email']}";
                                      if (await canLaunch(_whatsAppURL)) {
                                        launch(_whatsAppURL);
                                      }
                                    },
                                    child: Text(homeData[0]['email'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18))))),
                      ],
                    )
                  : Container(),
              (homeData[0]['CellPhone'] != null &&
                      homeData[0]['CellPhone'] != "")
                  ? Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.phone_iphone,
                              color: Colors.white,
                            )),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () async {
                                      var _phoneURL =
                                          "tel:${homeData[0]['CellPhone']}";
                                      if (await canLaunch(_phoneURL)) {
                                        launch(_phoneURL);
                                      }
                                    },
                                    child: Text(homeData[0]['CellPhone'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18))))),
                      ],
                    )
                  : Container(),
              (homeData[0]['whatsApp'] != null && homeData[0]['whatsApp'] != "")
                  ? Row(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.textsms,
                              color: Colors.white,
                            )),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(6),
                                margin: EdgeInsets.all(5),
                                child: GestureDetector(
                                    onTap: () async {
                                      var _whatsAppURL =
                                          "https://wa.me/${homeData[0]['whatsApp']}";
                                      if (await canLaunch(_whatsAppURL)) {
                                        launch(_whatsAppURL);
                                      }
                                    },
                                    child: Text(homeData[0]['whatsApp'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 18))))),
                      ],
                    )
                  : Container(),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    getTranslated(context, 'Follow_Us'),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (homeData[0]['facebook'] != null &&
                          homeData[0]['facebook'] != "")
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xff1877f2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.facebookF,
                                  color: Colors.white),
                              onPressed: () {
                                _openLink('link', homeData[0]['facebook']);
                              }))
                      : Container(),
                  (homeData[0]['twitter'] != null &&
                          homeData[0]['twitter'] != "")
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xff1da1f2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.twitter,
                                  color: Colors.white),
                              onPressed: () {
                                _openLink('link', homeData[0]['twitter']);
                              }))
                      : Container(),
                  (homeData[0]['youtube'] != null &&
                          homeData[0]['youtube'] != "")
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffff0000),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.youtube,
                                  color: Colors.white),
                              onPressed: () {
                                _openLink('link', homeData[0]['youtube']);
                              }))
                      : Container(),
                  (homeData[0]['linkedin'] != null &&
                          homeData[0]['linkedin'] != "")
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xff007bb5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.linkedin,
                                  color: Colors.white),
                              onPressed: () {
                                _openLink('link', homeData[0]['linkedin']);
                              }))
                      : Container(),
                  (homeData[0]['instagram'] != null &&
                          homeData[0]['instagram'] != "")
                      ? Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xffc32aa3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              icon: FaIcon(FontAwesomeIcons.instagram,
                                  color: Colors.white),
                              onPressed: () {
                                _openLink('link', homeData[0]['instagram']);
                              }))
                      : Container(),
                ],
              ),
              (homeData[0]['map'] != null && homeData[0]['map'] != "")
                  ? Container(
                      margin: EdgeInsets.all(5),
                      child: HtmlWidget(
                        homeData[0]['map'],
                        webView: true,
                      ),
                    )
                  : Container(),
            ]);
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(105.0),
          child: MainAppBar(getTranslated(context, 'contact_us'))),
      body: _displayData(),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
