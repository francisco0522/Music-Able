import 'package:flutter/material.dart';
import 'package:app/Data/songList.dart';

var songsData = SongsData.getData;

class BuyOrVote extends StatelessWidget {
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
              searchBar(),
              list(context),
            ],
          ),
        ],
      ),
    );
  }
}

 Widget searchBar() {
    final _formKey = GlobalKey<FormState>();
    return Container(
      color: Color.fromRGBO(255, 255, 255, 0.8),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              
            ),
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