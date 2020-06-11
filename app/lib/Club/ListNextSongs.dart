import 'package:flutter/material.dart';
import 'package:app/Data/songList.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List songs;
int leng;

var songsData = SongsData.getData;
final _songController = TextEditingController();

class ListSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              list(context),
            ],
          ),
        ],
      ),
    );
  }
}

musicList() async {
  final response =
      await http.get('http://34.229.218.28:5000/home?code=%22song%22');

  List data = jsonDecode(response.body);
  songs = data;
  print(songs[0]['artists'][0]['name']);
}

Widget list(BuildContext context) {
  musicList().then((data){
    leng = songs.length;
    });
  return Expanded(
    child: ListView.builder(   
      itemCount: leng,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 60,
          width: double.maxFinite,
          child: new InkWell(
            onTap: () {
              print(songsData[index]);
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
                                  children: <Widget>[buy(songs[index])],
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

Widget buy(data) {
  return Container(
    padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
    child: Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: "${data['name']} - ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20),
          ),
        ),
        RichText(
          text: TextSpan(
            text: "${data['artists'][0]['name']}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20),
          ),
        ),
      ],
    ),
  );
}
