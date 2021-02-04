import '../app_bars/main_app_bar.dart';
import '../localization/localization_constants.dart';

import '../drawers/main-drawer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../http_services/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FAQPage extends StatefulWidget {
  FAQPage({Key key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<dynamic> faqsData;

  getJsonData() async {
    try {
      var response = await http.post(Utils.FAQS_URL, body: {'lang': 'ar'});
      faqsData = json.decode(response.body);
      print(faqsData);
      return faqsData;
    } catch (e) {
      print('${e}');
    }
  }

  _displayFAQs() {
    return FutureBuilder(
        future: getJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<dynamic> faqsList = snapshot.data;
            return ListView.builder(
                itemCount: faqsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.gold),
                        borderRadius: BorderRadius.circular(20)),
                    child: GFAccordion(
                        collapsedTitlebackgroundColor: Colors.white,
                        expandedTitlebackgroundColor: Colors.white,
                        contentBorder: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor)),
                        title: faqsList[index]['Question_' +
                            getTranslated(context, 'this_lang_code')],
                        content: faqsList[index]['Answer_' +
                            getTranslated(context, 'this_lang_code')]),
                  );
                });
          }
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(105.0),
            child: MainAppBar(getTranslated(context, 'faqs'))),
        body: _displayFAQs());
  }
}
