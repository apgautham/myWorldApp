import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MobileView extends StatefulWidget {

  final String countryName;
  MobileView({this.countryName});

  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
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
      appBar: AppBar(
      ),
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(67.0, 129.0),
            child: Container(
              width: 278.0,
              height: 295.0,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                border: Border.all(width: 1.0, color: const Color(0xff2680eb)),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(69.2, 577.0),
            child: SizedBox(
              width: 274.0,
              child: Text(
                widget.countryName,
                style: TextStyle(
                  fontFamily: 'Lucida Sans',
                  fontSize: 26,
                  color: const Color(0xff2680eb),
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(134.0, 262.0),
            child: SizedBox(
              width: 144.0,
              child: Text(
                displayTime,
                style: TextStyle(
                  fontFamily: 'Lucida Sans',
                  fontSize: 40,
                  color: const Color(0xff2680eb),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
