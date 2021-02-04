import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import '../drawers/main-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';
import 'single_video.dart';

class VideosPage extends StatefulWidget {
  VideosPage({Key key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  bool loading;
  List<dynamic> videosData;

  getJsonData() async {
    try {
      var response = await http.post(Utils.VIDEOS_URL,
                                  body: {
                                      'lang' : 'ar'
                                  });
        videosData = json.decode(response.body);
        return videosData[0];
    } catch (e) {
      print('${e}');
    }
  }

  _displayVideos() {
    return FutureBuilder(
            future: getJsonData(),
            builder: (context , snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> videosList = snapshot.data ;
                return ListView.builder(
                  itemCount: videosList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleVideo(
                      videoPlayerController: VideoPlayerController.network(
                        videosList[index]['VideoFile'],
                      ),
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
                child: MainAppBar(getTranslated(context, 'Videos'))
              ),
      body: _displayVideos(),
    
    );
  }
}