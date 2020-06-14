import 'package:app/Tabs/clubPlace.dart';
import 'package:flutter/material.dart';
import 'package:app/Tabs/profile.dart';


  enum Pages { FIRST, SECOND, }


class HomeTabs extends StatelessWidget {
  @override
  String userId;
  String userName = "";
  String rol = "";
  HomeTabs ({Key key, this.userId, this.userName, this.rol}): super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                header(context),
                text(),
                buttons(),
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
              fit: BoxFit.fill)),
    );
  }

  Widget text() {
    return Container(
      height: 50.0,
     child: Center(
            child: RichText(
              textAlign: TextAlign.center,
        text: TextSpan(
          text: "Welcome " + userName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20),
        ),
      ),
      )  );
  }

  Widget buttons() {
    return Expanded(
      child: ListView.builder(itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 320,
          width: double.maxFinite,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment:
                  CrossAxisAlignment.center, //Center Row contents vertically,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 10.0, bottom: 10.0),
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ), //       <--- BoxDecoration here
                  child: new InkWell(
                    onTap: () {
                      _selectClubs(context);
                    },
                    child: Text(
                      "Clubs",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ), //       <--- BoxDecoration here
                  child: new InkWell(
                    onTap: () {
                      _selectProfile(context);
                    },
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ],
            ),
          );
      },
      ),
    );
  }

  Future _selectClubs(BuildContext context) async {
     return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What is the Club section?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('In this section you can find the clubs in Cali, know what song is playing and buy or vote for a new song'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future _selectProfile(BuildContext context) async {
      return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What is the Profile section?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('In this section you can find your information and a list of songs that you bought or voted for'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}
