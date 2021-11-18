import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String? time;
  String? flag;
  String? url;
  dynamic isDayTime;

  WorldTime({required this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make request
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = (now.hour > 6 && now.hour < 19) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (error) {
      print(error);
      time = 'could not get time data';
    }
  }
}

WorldTime instance =
    WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/berlin');
