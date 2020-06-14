import 'package:flutter/material.dart';
import 'Club/buy.dart';
import 'Tabs/profile.dart';
import 'Tabs/home.dart';
import 'Tabs/clubPlace.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//var userData = UserData.getData;
final _usernameController = TextEditingController();
final _passwordController = TextEditingController();
List users, djs;

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(50, 50, 50, 1),
            title: Text("Music-Able"),
          ),
          body: SafeArea(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: logo(context)),
                  Expanded(child: name(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget logo(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(
          left: 70.0, top: 75.0, bottom: 75.0, right: 70.0),
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/logo.png"),
              fit: BoxFit.fill)));
}

userData() async{
 final response =
      await http.get('http://34.229.218.28:5002/api/v1/users');

     List data = jsonDecode(response.body);
     users = data;
}

djData() async{
 final response =
      await http.get('http://34.229.218.28:5002/api/v1/djs');

     List data = jsonDecode(response.body);
     djs = data;
}

Widget name(BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              hintText: 'Username',
            ),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              userData().then((data){
              String username = _usernameController.text;
              String password = _passwordController.text;
              for (var x = 0; x < users.length; x++) {
                String userValidator = users[x]["full_name"];                
                String passValidator = users[x]["passwd"];
                if (username == userValidator &&
                    password == passValidator) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Menu(userName: users[x]["full_name"], userId: users[x]["id"], rol: "user",  userEmail:users[x]["email"])),
                  );
                }
              }
              });
              djData().then((data){         
              String username = _usernameController.text;
              String password = _passwordController.text;
              for (var x = 0; x < djs.length; x++) {
                String userValidator = djs[x]["full_name"];                
                String passValidator = djs[x]["passwd"];
                if (username == userValidator &&
                    password == passValidator) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Menu(userName: djs[x]["full_name"], userId: djs[x]["id"], rol: "dj", userEmail:djs[x]["email"] )),
                  );
                }
              }
              });
            },
            child: Text('Login'),
          )
        ],
      ),
    ),
  );
}

class Menu extends StatelessWidget {
  @override
  String userName = "";
  String userId;
  String rol = "";
  String userEmail;
  Menu ({Key key, this.userName, this.userId, this.rol, this.userEmail}): super(key: key);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(50, 50, 50, 1),
            title: Text(userName),
          ),
          bottomNavigationBar: menu(),
          body: new TabBarView(
            children: <Widget>[
              new HomeTabs(userId: userId, userName: userName, rol: rol),
              new ClubPlace(userId: userId, userName: userName, rol: rol),
              new ProfileTabs(userEmail: userEmail)
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Color.fromRGBO(50, 50, 50, 1),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(50, 50, 50, 1),
        ),
        tabs: [
          Tab(
            text: "Home",
            icon: Icon(Icons.home),
          ),
          Tab(
            text: "Clubs",
            icon: Icon(Icons.place),
          ),
          Tab(
            text: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
