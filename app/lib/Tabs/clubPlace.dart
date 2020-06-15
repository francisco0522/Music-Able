import 'package:app/Club/club.dart';
import 'package:app/Club/club_dj.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

List songInfo, djInfo;

class Place {
  final String id;
  final String pname;
  final String pstreet;
  final String img;

  Place(
    this.id,
    this.pname,
    this.pstreet,
    this.img,
  );
}

class ClubPlace extends StatelessWidget {
  String userId;
  String userName = "";
  String rol = "";
  ClubPlace({Key key, this.userId, this.userName, this.rol}) : super(key: key);

  Future<List<Place>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http.get('http://34.229.218.28:5002/api/v1/places');
    List data = jsonDecode(response.body);
    return List.generate(data.length, (int index) {
      return Place("${data[index]['id']}", "${data[index]['pname']}",
          "${data[index]['pstreet']}", "${data[index]['club_img']}");
    });
  }

   Future<List> songsData(id) async{
 final response =
      await http.get('http://34.229.218.28:5002/api/v1/places/' + id + '/songs');
 List data = jsonDecode(response.body);
 songInfo = data;
    return data;
  }

    Future<List> djData(id) async{
 final response =
      await http.get('http://34.229.218.28:5002/api/v1/places/' + id + '/djs');
 List data = jsonDecode(response.body);
 djInfo = data;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(
                left: 10.0, top: 20.0, bottom: 10.0, right: 10.0),
                child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Write and Select the club to know more information",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20),
              ),
            ))),
        clubsWidget(context),
      ],
    )));
  }

  Widget clubsWidget(BuildContext context){
    return Expanded(
          child: SearchBar<Place>(
              onSearch: search,
              onItemFound: (Place place, int index) {
                return Card(
                  color: Color.fromRGBO(51, 54, 117, 0.3),
                  elevation: 3,
                  child: new InkWell(
                    onTap: () {
                      openClub(place, context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[name(place, index)],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          image(context, place, index)
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
                );
            }
              ),
        );
  }

  openClub(place, context){

    if (rol == "user") {
                        songsData(place.id).then((songInfo){
                          djData(place.id).then((djInfo){                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Club(
                                  nameClub: place.pname,
                                  idPlace: place.id,
                                   img: place.img,
                                    songs: songInfo,
                                    djname: djInfo[0]["full_name"],)),
                        );                       
                        });
                        });
                      }
                      if (rol == "dj") {
                        songsData(place.id).then((songInfo){
                          djData(place.id).then((djInfo){                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClubDj(
                                  nameClub: place.pname,
                                   img: place.img,
                                    songs: songInfo,
                                    djname: djInfo[0]["full_name"],)),
                        );                       
                        });
                        });
                    }
                     songInfo = [];

  }

  Widget name(post, index) {
    return Container(
        padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
        child: RichText(
          text: TextSpan(
            text: post.pname,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                text: '\n' + post.pstreet,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ));
  }

  Widget image(BuildContext context, post, index) {
    return Container(
        margin: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Image.network(post.img, fit: BoxFit.fill));
  }

}
