import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'buy.dart';
import 'package:url_launcher/url_launcher.dart';

class Club extends StatelessWidget {
  String nameClub;
  String idPlace;
  String img;
  List songs;
  String street;
  String djname;

  Club({Key key, this.nameClub, this.idPlace, this.img, this.songs, this.street, this.djname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: new Text(
          nameClub,
          style: new TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            djWidget(context),
            genreWidget(context),
            imageWidget(context),
            buyNextSongWidget(context),
            songsListTittleWidget(),
            songsListWidget(),
          ],
        ),
      ),
    );
  }

  //header hace the genre, djnam, image and adress
  Widget djWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: "Dj: ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: djname, style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget genreWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, top: 0.0, bottom: 20.0),
      child: RichText(
        text: TextSpan(
          text: "Genre: ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: songs[0]["songgenre"],
                style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget imageWidget(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Image.network(img, fit: BoxFit.fill));
  }

  Widget buyNextSongWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.only(
            right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
            border:
                Border.all(width: 2, color: Color.fromRGBO(200, 200, 200, 1.0)),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
        child: new InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Buy(idPlace: idPlace)),
            );
          },
          child: Text(
            "Buy or vote for song",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(200, 200, 200, 1.0)),
          ),
        ),
      ),
    );
  }

  Widget songsListTittleWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 5.0),
      child: RichText(
        text: TextSpan(
          text: "Club Playlist: ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

  Widget songsListWidget() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 2,
                            color: Color.fromRGBO(255, 255, 255, 1.0))),
                  ),
        child: ListView.builder(
            itemCount: songs.length,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(                  
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: songs[index]["songname"] +
                              ' \n' +
                              songs[index]["songartists"],
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                                width: 50, // specific value
                                child: RaisedButton(
                                  color: Color.fromRGBO(0, 212, 90, 1),
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  onPressed: () {
                                    launch(songs[index]["songnamelink"]);
                                  },
                                  child: Icon(Icons.play_arrow),
                                )),
                    ],
                  ));
            })));
  }
}
