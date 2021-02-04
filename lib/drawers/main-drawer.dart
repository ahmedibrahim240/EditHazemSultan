import '../localization/localization_constants.dart';
import '../main.dart';
import '../routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatefulWidget {

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String userID, userName, userEmail;
  Future<void>getLoggeInUser()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString('hazem_sultan_user_id');
      userName = sharedPreferences.getString('hazem_sultan_user_name');
      userEmail = sharedPreferences.getString('hazem_sultan_user_email');
    });
  }
  _userHeader() {
    if (userID != null && userID != "null") {
      return Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 120,
            width: 120,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assets/images/logo.png'),
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              userName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20),
            ),
            width: 160,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new GestureDetector(
                    child: new Text(
                      getTranslated(context, 'edit-profile'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, profileRoute);
                    },
                  ),
                  Container(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                    height: 30,
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ),
                  new GestureDetector(
                    child: new Text(
                      getTranslated(context, 'logout'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('hazem_sultan_user_id');
                      prefs.remove('hazem_sultan_user_name');
                      prefs.remove('hazem_sultan_user_email');
                      Navigator.pop(context);
                      Navigator.pushNamed(context, homeRoute);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: 120,
            width: 120,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('lib/assets/images/logo.png'),
            )
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(20),
            ),
            width: 160,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new GestureDetector(
                    child: new Text(
                      getTranslated(context, 'login'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, loginRoute);
                    },
                  ),
                  Container(
                    width: 2,
                    color: Theme.of(context).primaryColor,
                    height: 30,
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ),
                  new GestureDetector(
                    child: new Text(
                      getTranslated(context, 'register'),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, registerRoute);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
  }
  
  @override
  void initState() {
    super.initState();
    this.getLoggeInUser();
  }


  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:25,right:5,left:5,bottom:15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.amber[100]),
              ),
            ),
            child:_userHeader(),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'home_page'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, homeRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'aboutus'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, aboutusRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.photo_library,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'gallery'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, galleryRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.video_library,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'Videos'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, videosRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.group,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'teamwork'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, teamWorkRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.question_answer,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'consultations'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              if (userID != null && userID != "null") {
                Navigator.pushNamed(context, consultationsRoute);
              } else {
                Navigator.pushNamed(context, loginRoute);
              }
            }
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'contact_us'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, contactUsRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.announcement,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'faqs'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, faqRoute);
            }
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'book_now'),
              style: _textStyle
            ),
            onTap: () {
              Navigator.pop(context);
              if (userID != null && userID != "null") {
                Navigator.pushNamed(context, bookingRoute);
              } else {
                Navigator.pushNamed(context, loginRoute);
              }
            }
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              getTranslated(context, 'other_lang'),
              style: _textStyle
            ),
            onTap: () {
              _changeLanguage(getTranslated(context, 'other_lang_code'));
              Navigator.pop(context);
            }
          ),
        ]
      )
    );
  }

  void _changeLanguage(language) async {
    Locale _temp = await setLocale(language);
    HazemSultanApp.setLocale(context, _temp);
  }
}