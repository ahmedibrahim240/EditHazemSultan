import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  final String apiURL = 'http://drhazemsultan.com/PhoneApp/api';

  Future getSettingsData() async{
    try {
        var response = await http.get(apiURL+'/GeneralData');
        Map<String, dynamic> map = json.decode(response.body);
        var responseData = map['data'];
        return responseData;
    } catch (e) {
      // print('${e}');
    }
  }


}