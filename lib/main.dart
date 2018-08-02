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
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Column(children: <Widget>[
                      new Image.network(
                        data[index]["enclosure"]["link"],
                      ),
                      new Padding(
                        padding: EdgeInsets.all(5.0),
                        child: new Text(
                          data[index]["title"],
                          maxLines: 3,
                          style: TextStyle(
                            fontFamily: 'Dosis-ExtraBold',
                            fontSize: 18.0,
                            color: Color.fromRGBO(127, 108, 157, 1.0),
                          ),
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
                        child: new Text(data[index]["description"],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Roboto-Light',
                              fontSize: 14.0,
                              color: Colors.black,
                            )),
                      ),
                      new ButtonTheme.bar(
                        child: new ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new FlatButton(
                              child: const Text('SHARE'),
                              textColor: Colors.amber.shade500,
                              onPressed: () { /* do nothing */ },
                            ),
                            new FlatButton(
                              child: const Text('EXPLORE'),
                              textColor: Colors.amber.shade500,
                              onPressed: () { /* do nothing */ },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
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
