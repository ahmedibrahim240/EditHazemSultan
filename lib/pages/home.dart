import '../drawers/main-drawer.dart';
import '../localization/localization_constants.dart';
import '../routes/route_names.dart';
import 'package:flutter/material.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<dynamic> homeData;

  Future getJsonData() async {
    try {
      var response = await http.post(Utils.HOME_DATA_URL, body: {'lang': 'ar'});
      setState(() {
        homeData = json.decode(response.body);
        print('this is response: $homeData');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  _getTeamWork() async {
    try {
      var response = await http.post(Utils.HOME_DATA_URL, body: {'lang': 'ar'});
      var thisTeam = json.decode(response.body);
      return thisTeam[1];
    } catch (e) {
      print(e.toString());
    }
  }

  _displayTeamWork() {
    return FutureBuilder(
        future: _getTeamWork(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<dynamic> teamMembers = snapshot.data;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width * .45,
                      height: 150,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .015,
                          right: MediaQuery.of(context).size.width * .015),
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        Image(
                            loadingBuilder: (context, image,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) {
                                return image;
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            height: 100,
                            fit: BoxFit.fill,
                            image: (homeData != null)
                                ? NetworkImage(teamMembers[index]['file'])
                                : AssetImage('lib/assets/images/faq.png')),
                        Text(
                          teamMembers[index]['name_' +
                              getTranslated(context, 'this_lang_code')],
                          style: TextStyle(fontSize: 14),
                        ),
                      ]));
                });
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
        child: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _drawerKey.currentState.openDrawer(),
              ),
              Expanded(
                child: Center(
                  child: Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: CircleAvatar(
                        backgroundImage: (homeData != null)
                            ? NetworkImage(homeData[0]['HomeMainImage'])
                            : AssetImage('lib/assets/images/hazem.png'),
                      )),
                ),
              ),
              Container(width: 50)
            ],
          ),
          Text(
            (homeData != null)
                ? homeData[0]
                    ['HomeTitle_' + getTranslated(context, 'this_lang_code')]
                : '...',
            // getTranslated(context, 'dr-hazem-sultan'),
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 5,
          ),
          Text(
            (homeData != null)
                ? homeData[0]
                    ['HomeTxt_' + getTranslated(context, 'this_lang_code')]
                : '...',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Center(
              child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 10,
                      ),
                      Text(
                        getTranslated(context, 'read_more'),
                        style: TextStyle(
                            color: Colors.gold, fontFamily: 'Jf-Flat'),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.gold,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, aboutusRoute);
                  })),
          Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .45,
              child: InkWell(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image(
                        loadingBuilder:
                            (context, image, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return image;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: (homeData != null)
                            ? NetworkImage(homeData[0]['HomeFAQsImage'])
                            : AssetImage('lib/assets/images/faq.png')),
                    Text(
                      getTranslated(context, 'faqs'),
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
                  onTap: () {
                    Navigator.pushNamed(context, faqRoute);
                  }),
            ),
            Container(width: MediaQuery.of(context).size.width * .03),
            Container(
              width: MediaQuery.of(context).size.width * .45,
              child: InkWell(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    Image(
                        loadingBuilder:
                            (context, image, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return image;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: (homeData != null)
                            ? NetworkImage(homeData[0]['HomeGalleryImage'])
                            : AssetImage('lib/assets/images/gallery.png')),
                    Text(
                      getTranslated(context, 'gallery'),
                      style: TextStyle(fontSize: 24),
                    ),
                  ]),
                  onTap: () {
                    Navigator.pushNamed(context, galleryRoute);
                  }),
            )
          ]),
          Container(height: 10),
          Text(
            getTranslated(context, 'teamwork'),
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          Flexible(fit: FlexFit.tight, child: _displayTeamWork()),
          Container(
              width: 130,
              padding: EdgeInsets.all(5),
              child: FlatButton(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 10,
                      ),
                      Text(
                        getTranslated(context, 'read_more'),
                        style: TextStyle(
                            color: Colors.gold, fontFamily: 'Jf-Flat'),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.gold,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, teamWorkRoute);
                  })),
        ]),
      ),
    );
  }
}
