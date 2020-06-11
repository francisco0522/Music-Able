import 'package:flutter/material.dart';
import 'package:app/Data/songList.dart';

var songsData = SongsData.getData;

class ProfileTabs extends StatelessWidget {
  int userId;
  String userName = "";
  String rol = "";
  ProfileTabs ({Key key, this.userId, this.userName, this.rol}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              image(context, userName, userId),
              list(context),
            ],
          ),
        ],
      ),
    );
  }
}

Widget image(BuildContext context, idName, id) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(
                left: 65.0, top: 20.0, right: 65.0),
            height: 50.0,
            child: RichText(
              text: TextSpan(
                text: idName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 65.0, bottom: 20.0, right: 65.0),
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/pp.jpg"),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 65.0, right: 65.0),
            height: 50.0,
            child: RichText(
              text: TextSpan(
                text: "Change profile image",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                left: 65.0, right: 65.0),
            height: 50.0,
            child: RichText(
              text: TextSpan(
                text: "Change password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget list(BuildContext context) {
  return Expanded(
    child: ListView.builder(
      itemCount: songsData.length,
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
                                  children: <Widget>[buy(songsData[index])],
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
            text: "${data['song']} - ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 20),
          ),
        ),
        RichText(
          text: TextSpan(
            text: "${data['date']}",
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