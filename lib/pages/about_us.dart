import '../app_bars/main_app_bar.dart';
import '../routes/route_names.dart';

import '../localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  List<dynamic> homeData;

  getJsonData() async {
    try {
      var response = await http.post(Utils.HOME_DATA_URL,
                                  body: {
                                      'lang' : 'ar'
                                  });
      setState(() {
        homeData = json.decode(response.body);
        // print(homeData[0]['HomeTitle_'+getTranslated(context, 'this_lang_code')]);
      });
    } catch (e) {
      print('${e}');
    }
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  _getTheSlider() {
    
    final List<String> imgList = [
      'http://drhazemsultan.com/storage/app/public/PhotoAlbums/6/15932641041-6.jpeg',
      'http://drhazemsultan.com/storage/app/public/PhotoAlbums/6/15932641042-6.jpeg',
      'http://drhazemsultan.com/storage/app/public/PhotoAlbums/6/15932641043-6.jpeg',
      'http://drhazemsultan.com/storage/app/public/PhotoAlbums/6/15932642541-6.jpeg',
      'http://drhazemsultan.com/storage/app/public/PhotoAlbums/6/15932642542-6.jpeg'
    ];

    final List<Widget> imageSliders = imgList.map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    )).toList();

    if (imageSliders != null) {
      return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 2,
                  autoPlay: true,
                ),
                items: imageSliders,
              );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(105.0),
                child: MainAppBar(getTranslated(context, 'aboutus'))
              ),
      body: 
        ListView(
          children: <Widget>[
            _getTheSlider(),
            Center(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: CircleAvatar(
                  backgroundImage: (homeData != null) ?
                                      NetworkImage(homeData[0]['HomeMainImage'])
                                    :
                                      AssetImage('lib/assets/images/hazem.png'),
                )
              ),
            ),
            Text(
              (homeData != null) ? homeData[0]['HomeTitle_'+getTranslated(context, 'this_lang_code')] : '...',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Text(
                (homeData != null) ? homeData[0]['HomeTxt_'+getTranslated(context, 'this_lang_code')] : '...',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Color(0xff363a3d),
                borderRadius: BorderRadius.circular(20.0)
              ),
              child:Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                  Text(
                    getTranslated(context, 'now_open'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                  Expanded(
                    child: Container()
                  ),
                  FlatButton(
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
                  ),
                  Container(
                    width:5
                  )
                ],
              ),
            ),
          ]
        ),
    );
  }
}
