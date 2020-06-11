import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListNextSongs.dart';

class ClubDj extends StatelessWidget {
  var clubInfo;
  ClubDj ({Key key, this.clubInfo}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Container(
            color: Color.fromRGBO(93, 93, 93, 1),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                card(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card(BuildContext context) {
    return Expanded(
      child: Card(
        color: Color.fromRGBO(51, 54, 117, 0.3),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[name()],
                          ),
                          Row(
                            children: <Widget>[genre()],
                          ),
                          Row(
                            children: <Widget>[dj()],
                          ),
                          Row(
                            children: <Widget>[image(context)],
                          ),
                          Row(
                            children: <Widget>[adress()],
                          ),
                          Row(
                            children: <Widget>[song()],
                          ),
                          Row(
                            children: <Widget>[songsList(context)],
                          ),
                        ],
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget name() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: clubInfo["name"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

   Widget genre() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top:5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: clubInfo["genre"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

   Widget dj() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: clubInfo["Dj"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

  Widget image(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage(clubInfo["image"]),
            fit: BoxFit.fill),
      ),
    );
  }

   Widget adress() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: clubInfo["location"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

  Widget song() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: clubInfo["song"],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    ),
     RaisedButton(
            onPressed: () {
              
            },
            child: Text('Listen in Spotify'),
          ),
        ],
      ),
    );
  }

  Widget songsList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: "See the next songs",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    ),
     RaisedButton(
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListSongs()),
                  );
            },
            child: Text('List of songs'),
          ),
        ],
      ),
    );
  }
}
