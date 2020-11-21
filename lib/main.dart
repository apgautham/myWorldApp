
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:my_world_time_app/MobileView.dart';
import 'package:my_world_time_app/WebView.dart';
import 'package:my_world_time_app/LoginScreen.dart';

void main() {
  runApp(MaterialApp(
    title: 'World Time APP',
    routes: {
      '/': (context) => LoginScreen(),
    },
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Body(),
    );
  }
}


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String val = "initVal";
  List timeZoneMap = [];
  List dummyMap = [];

  setTimeZones() async{
    String api = "https://worldtimeapi.org/api/timezone/";
    Response response = await get(api);
    setState(() {
      timeZoneMap = jsonDecode(response.body);
      dummyMap = timeZoneMap;
    });

  }

  @override
  void initState() {
    super.initState();
    setTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    print('returning context');
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.search
            ),
            title: TextField(

              onChanged: (text){
                setState(() {
                  timeZoneMap = dummyMap.where((string) => string.toLowerCase().contains(text.toLowerCase())).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Here...'
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 290,
            child: ListView.builder(
              itemCount: timeZoneMap.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){},
                  borderRadius: BorderRadius.circular(10),
                  highlightColor: Colors.red,
                  splashColor: Colors.blue,
                  child: ListTile(
                    title: Text(timeZoneMap[index]),
                    leading: Container(
                      padding: EdgeInsets.all(15),
                        child: Image.network("https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png")
                    ),
                    onTap: (){
                      if(kIsWeb){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => WebView(countryName:timeZoneMap[index]),
                        ));
                      }else{
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MobileView(countryName:timeZoneMap[index]),
                        ));
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

