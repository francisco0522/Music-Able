import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

String link;

deleteSong(String id) async {
  final http.Response response = await http.delete(
    'http://34.229.218.28:5002/api/v1/songs/$id',
  );
  
  return response;
}

class ClubDj extends StatefulWidget {
  String nameClub;
  String img;
  List songs;
  String djname;
  ClubDj(
      {Key key, this.nameClub, this.img, this.songs, this.djname})
      : super(key: key);
  @override
  _ClubDj createState() => _ClubDj();
}

class _ClubDj extends State<ClubDj> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: new Text(
          widget.nameClub,
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
                text: widget.djname, style: TextStyle(fontWeight: FontWeight.normal)),
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
                text: widget.songs[0]["songgenre"],
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
        child: Image.network(widget.img, fit: BoxFit.fill));
  }

  Widget songsListTittleWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 5.0, top: 15.0),
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
                      width: 2, color: Color.fromRGBO(255, 255, 255, 1.0))),
            ),
            child: ListView.builder(
                itemCount: widget.songs.length,
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
                              text: widget.songs[index]["songname"] +
                                  ' \n' +
                                  widget.songs[index]["songartists"],
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 15),
                            ),
                          ),
                          Row(children: <Widget>[
                            SizedBox(
                                width: 50, // specific value
                                child: RaisedButton(
                                  color: Color.fromRGBO(0, 212, 90, 1),
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  onPressed: () {
                                    launch(widget.songs[index]["songnamelink"]);
                                  },
                                  child: Icon(Icons.play_arrow),
                                )),
                            SizedBox(
                                width: 50, // specific value
                                child: RaisedButton(
                                  color: Color.fromRGBO(252, 61, 61, 1),
                                  onPressed: () {
                                    showToastBuy(widget.songs[index]["songname"]);
                                deleteSong(widget.songs[index]["id"].toString());
                                  },
                                  child: Icon(Icons.delete),
                                )),
                          ]),
                        ],
                      ));
                })));
  }

  
  void showToastBuy(title) {
        Fluttertoast.showToast(
        msg: "You just removed " + title + " from the playlist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
