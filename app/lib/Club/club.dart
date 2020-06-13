import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'buy.dart';
import 'package:url_launcher/url_launcher.dart';

class Club extends StatelessWidget {
  String nameClub;
  String img;
  String songname;
  String street;
  String songartists;
  String songgenre;
  String songnamelink;

  Club ({Key key, this.nameClub, this.img, this.songname, this.street, this.songartists, this.songgenre, this.songnamelink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
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
                            children: <Widget>[next(context)],
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
          text: nameClub,
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
          text: songgenre,
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
          text: nameClub,
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
      child: Image.network(
          img,
              fit: BoxFit.fill));
  }

   Widget adress() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: street,
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
          text: "Now playing",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: '\n' + songname + ' - ' + songartists ,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ),
     RaisedButton(
            onPressed: () {
              launch(songnamelink);
            },
            child: Text('Listen in Spotify'),
          ),
        ],
      ),
    );
  }


Widget next(BuildContext context) {
       return Container(
      child: Column(
        children: <Widget>[
          Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: "Vote or buy next song",
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
                    MaterialPageRoute(builder: (context) => Buy()),
                  );
            },
            child: Text('buy or vote for song'),
          ),
        ],
      ),
    );
  }
}
