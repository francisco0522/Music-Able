import 'package:flutter/material.dart';
import 'Tabs/profile.dart';
import 'Tabs/home.dart';
import 'Tabs/place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//var userData = UserData.getData;
final _usernameController = TextEditingController();
final _passwordController = TextEditingController();
List users;

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
            title: Text("Music-able"),
          ),
          body: Container(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: logo(context)),
                  Expanded(child: name(context/*, userData*/)),
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

pedirDatos() async{
 final response =
      await http.get('https://jsonplaceholder.typicode.com/users');

     List data = jsonDecode(response.body);
     users = data;
}


Widget name(BuildContext context, /*data*/) {
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
              
              print(users[1]);
              
              
             /* String username = _usernameController.text;
              String password = _passwordController.text;
              for (var x = 0; x < userData.length; x++) {
                if (username == userData[x]["name"] &&
                    password == userData[x]["password"]) {
                  print('login attempt: $username with $password');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Menu(userName: userData[x]["name"], userId: userData[x]["id"], )),
                  );
                }
              }*/
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
  String userId = "";
  Menu ({Key key, this.userName, this.userId}): super(key: key);
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
              new HomeTabs(userId: userId, userName: userName),
              new PlaceTabs(userId: userId, userName: userName),
              new ProfileTabs(userId: userId, userName: userName)
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
