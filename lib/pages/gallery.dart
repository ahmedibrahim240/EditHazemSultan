import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import '../drawers/main-drawer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool loading;

  List<dynamic> galleryData;

  getJsonData() async {
    try {
      var response = await http.post(Utils.GALLERY_URL,
                                  body: {
                                      'lang' : 'ar'
                                  });
        galleryData = json.decode(response.body);
        return galleryData[0];
    } catch (e) {
      print('${e}');
    }
  }

  _displayGalleryAlbums() {
    return FutureBuilder(
            future: getJsonData(),
            builder: (context , snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> galleryAlbums = snapshot.data ;
                return GridView.builder(
                  itemCount: galleryAlbums.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      child: new Card(
                        elevation: 5.0,
                        child: new Container(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 150,
                                padding: EdgeInsets.only(top:15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Image( image:
                                          (galleryAlbums[index]['after'] != null) ?
                                            NetworkImage(galleryAlbums[index]['after'])
                                          :
                                            AssetImage('lib/assets/images/hazem.png')
                                        )
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  galleryAlbums[index]['title_'+getTranslated(context, 'this_lang_code')],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black
                                  ),
                                )
                              )
                            ],
                          )
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            child: new CupertinoAlertDialog(
                              title: new Column(
                                children: <Widget>[
                                  new Text(galleryAlbums[index]['title_'+getTranslated(context, 'this_lang_code')]),
                                ],
                              ),
                              content: Container(
                                height: 250,
                                child: CarouselSlider(
                                          options: CarouselOptions(
                                            aspectRatio: 1.0,
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: false,
                                            initialPage: 2,
                                            autoPlay: true,
                                          ),
                                          items: [
                                            Image.network(galleryAlbums[index]['before']),
                                            Image.network(galleryAlbums[index]['after'])],
                                        )
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: new Text(getTranslated(context, 'close')))
                              ],
                            ));
                      },
                    );
                  }
                );

              }
              return Container();
            }
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: PreferredSize(
                preferredSize: Size.fromHeight(105.0),
                child: MainAppBar(getTranslated(context, 'gallery'))
              ),
      body: _displayGalleryAlbums(),
    );
  }
}