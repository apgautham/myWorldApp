import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WebView extends StatefulWidget {
  final String countryName;
  WebView({this.countryName});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String displayTime ="Loading...";
  getData() async{
    String api = "https://worldtimeapi.org/api/timezone/${widget.countryName}";
    Response response = await get(api);
    Map res = jsonDecode(response.body);
    String fullDate = res['datetime'];
    setState(() {
      displayTime = fullDate.substring(11,16);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(1726.0, 2444.0),
            child: Text(
              widget.countryName,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 150,
                color: const Color(0xff3865f9),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1487.0, 443.0),
            child: SizedBox(
              width: 1369.0,
              height: 1413.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1369.0, 1413.0),
                    size: Size(1369.0, 1413.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff0018ff)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(523.0, 583.0, 323.0, 200.0),
                    size: Size(1369.0, 1413.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      displayTime,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 150,
                        color: const Color(0xff3865f9),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
