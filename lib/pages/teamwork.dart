import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';
import '../drawers/main-drawer.dart';
import 'package:flutter/material.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamWorkPage extends StatefulWidget {
  TeamWorkPage({Key key}) : super(key: key);

  @override
  _TeamWorkPageState createState() => _TeamWorkPageState();
}

class _TeamWorkPageState extends State<TeamWorkPage> {

  List<dynamic> thisTeam;
  _getTeamWork() async {
    try {
      var response = await http.post(Utils.TEAMWORL_URL,
                                  body: {
                                      'lang' : 'ar'
                                  });
      var thisTeam = json.decode(response.body);
      return thisTeam[0];
    } catch (e) {
      print('${e}');
    }
  }


  _displayTeamWork() {
    return FutureBuilder(
            future: _getTeamWork(),
            builder: (context , snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> teamMembers = snapshot.data ;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: teamMembers.length,
                  itemBuilder:(context , index){
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.gold),
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            width: MediaQuery.of(context).size.width * .55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  teamMembers[index]['name_'+getTranslated(context, 'this_lang_code')],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87
                                  ),
                                ),
                                Text(
                                  teamMembers[index]['title_'+getTranslated(context, 'this_lang_code')],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38
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
                                (teamMembers[index]['info_'+getTranslated(context, 'this_lang_code')] != null) ?
                                  Text(
                                    teamMembers[index]['info_'+getTranslated(context, 'this_lang_code')],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black
                                    ),
                                  )
                                :
                                Container(),
                              ]
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                height: 120,
                                width: 120,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: CircleAvatar(
                                  backgroundImage: (teamMembers[index]['file'] != null) ?
                                            NetworkImage(teamMembers[index]['file'])
                                          :
                                            AssetImage('lib/assets/images/hazem.png')
                                )
                              ),
                            ),
                          )
                        ]
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
                child: MainAppBar(getTranslated(context, 'teamwork'))
              ),
      body: _displayTeamWork(),
    );
  }
}
