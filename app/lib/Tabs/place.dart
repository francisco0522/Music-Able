import 'package:flutter/material.dart';
import 'package:app/Club/club.dart';
import 'package:app/Data/clubList.dart';

var clubData = ClubData.getData;

class PlaceTabs extends StatelessWidget {
  int userId;
  String userName = "";
  PlaceTabs ({Key key, this.userId, this.userName}): super(key: key);
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
                header(context),
                text(),
                searchBar(),
                card(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
     return Container(
          margin: const EdgeInsets.only(
          left: 100.0, top: 50.0, bottom: 30.0, right: 100.0),
      width: MediaQuery.of(context).size.width,
      height: 120.0,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill)
              ),
    );
  }

  Widget searchBar() {
    final _formKey = GlobalKey<FormState>();
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.8),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search a Club or Genre',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Container(
              child: RaisedButton(
                color: Color.fromRGBO(0, 0, 0, 1),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
                  }
                },
                child: RichText(
                  text: TextSpan(
                    text: "Search",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text() {
    return Container(
      height: 50.0,
      child: RichText(
        text: TextSpan(
          text: "Select the club to know more information",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }

  Widget card() {
    return Expanded(
      child: ListView.builder(
        itemCount: clubData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 320,
            width: double.maxFinite,
            child: new InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Club(clubInfo: clubData[index])),
                  );
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
                                    children: <Widget>[name(clubData[index])],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      image(context, clubData[index])
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[song(clubData[index])],
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

  Widget name(data) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: "${data['name']}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: '\n${data['genre']}',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget image(BuildContext context, data) {
    return Container(
        margin: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("${data['image']}"), fit: BoxFit.fill)));
  }

  Widget song(data) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: RichText(
        text: TextSpan(
          text: "${data['song']}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20),
        ),
      ),
    );
  }
}
