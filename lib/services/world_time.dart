import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // lcoation url for api end points
  bool isDayTime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // making the request
      Uri finalUrl = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
      Response response = await get(finalUrl);
      Map data = jsonDecode(response.body);

      //get properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create DataTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

    
        isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      // set the time propertby

      time = DateFormat.jm().format(now);
    } catch (err) {
      time = 'could not get time data';
    }
  }
}
