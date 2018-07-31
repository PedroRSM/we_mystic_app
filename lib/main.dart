import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: WeMysticNewsData(),
  ));
}

class WeMysticNewsData extends StatefulWidget {
  @override
  WeMysticNewsState createState() => WeMysticNewsState();
}

class WeMysticNewsState extends State<WeMysticNewsData> {
  final String url =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.wemystic.com/feed";
  List data;




  Future<String> getWMNews() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["items"];
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("We Mystic News"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body:ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                          children: <Widget>[
                            new Column(
                                children: <Widget>[
                                  new Image.network(data[index]["thumbnail"],
                                    width: 100.0,
                                    height: 100.0,
                                  )
                                ]

                            ),

                            new Column(
                                children: <Widget>[
                                  new SizedBox(height: 8.0),
                                    new Text(data[index]["title"],
                                    maxLines: 3,

                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.black,
                                    ),
                                  ),


                                  new Text(
                                      "Text",
                                      style: new TextStyle(fontSize:12.0,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Roboto")
                                  ),

                                  new Text(
                                      "Text",
                                      style: new TextStyle(fontSize:12.0,
                                          color: const Color(0xFF000000),
                                          fontWeight: FontWeight.w200,
                                          fontFamily: "Roboto")
                                  )
                                ]

                            )
                          ]

                      ),
                    )
                  ],
                ),
              ),

            );

          },
        ),
        bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Color.fromRGBO(72, 67, 103, 1.0),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            ),
            child: new BottomNavigationBar(items: [
              new BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                title: new Text('Home'),
              ),
              new BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                title: new Text('Astrology'),
              ),
            ])));
  }

  @override
  void initState() {
    super.initState();
    this.getWMNews();
  }
}
