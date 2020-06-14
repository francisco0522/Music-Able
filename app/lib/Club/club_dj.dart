import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

String link;

class ClubDj extends StatelessWidget {
  String nameClub;
  String img;
  List songs;
  String street;
  String djname;

  ClubDj ({Key key,
   this.nameClub,
   this.img, 
   this.songs, 
   this.street, 
   this.djname}): super(key: key);

  Future<String> search() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http
        .get('http://34.229.218.28:5000/home?code=%22' + songs[0]["songname"] + '%22');
    List data = jsonDecode(response.body);
    link = data[0]['external_urls']['spotify'];
  }


  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget card(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color.fromRGBO(51, 54, 117, 0.3),
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
                            children: <Widget>[songName()],
                          ),
                          Row(
                            children: <Widget>[listen()],
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

  Widget genre() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 20.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: "Genre: ",
          children: <TextSpan>[
            TextSpan(
                text: songs[0]["songgenre"],
                style: TextStyle(fontWeight: FontWeight.normal)),
          ],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 15),
        ),
      ),
    );
  }

  Widget dj() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: "Dj: ",
          children: <TextSpan>[
            TextSpan(
                text: djname,
                style: TextStyle(fontWeight: FontWeight.normal)),
          ],
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 15),
        ),
      ),
    );
  }

  Widget image(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Image.network(img, fit: BoxFit.fill));
  }

  Widget adress() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: street,
          style:
              TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20),
        ),
      ),
    );
  }

  Widget song() {
    return Container(
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
          child: RichText(
            text: TextSpan(
              text: "Now playing",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 20),
            ),
          ),
        ),
      ]),
    );
  }

  Widget songName() {
    return Container(
        padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
        child: Center(
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: songs[0]["songname"] + ' \n' + songs[0]["songartists"],
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1), fontSize: 12),
            ),
          ),
        ));
  }

  Widget listen() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
      child: RaisedButton(
        onPressed: () {
          launch(songs[0]["songnamelink"]);
        },
        child: Text('Listen in Spotify'),
      ),
    );
  }

   Widget list(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 60,
            width: double.maxFinite,
            child: new InkWell(
              onTap: () {               
              launch(songs[index]['songnamelink']);
              },
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
                                    children: <Widget>[
                                      songList(songs[index])
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  
Widget songList(data) {
  return Container(
    padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
    child: Row(
      children: <Widget>[        
      RichText(
          text: TextSpan(
            text: "${data['songname']} - ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          ),
        ),
        RichText(
          text: TextSpan(
            text: "${data['songartists']} / ",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
}
