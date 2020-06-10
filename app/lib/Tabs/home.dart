import 'package:flutter/material.dart';
import 'package:app/Tabs/place.dart';
import 'package:app/Tabs/profile.dart';


class HomeTabs extends StatelessWidget {
  @override
  String userId = "";
  String userName = "";
  HomeTabs ({Key key, this.userId, this.userName}): super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
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
      child: RichText(
        text: TextSpan(
          text: "Welcome " + userName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 20),
        ),
      ),
    );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlaceTabs()),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileTabs()),
                      );
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
}
