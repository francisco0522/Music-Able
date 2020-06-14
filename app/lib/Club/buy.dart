import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Post {
  final String title;
  final String description;
  final String link;

  Post(this.title, this.description, this.link);
}

enum Pages { FIRST, SECOND }

class Buy extends StatelessWidget {
  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http
        .get('http://34.229.218.28:5000/home?code=%22' + search + '%22');
    List data = jsonDecode(response.body);
    return List.generate(data.length, (int index) {
      return Post(
        "${data[index]['name']}",
        "${data[index]['artists'][0]['name']}",
        "${data[index]['external_urls']['spotify']}"
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(50, 50, 50, 1),
        title: new Text(
          "Search a song",
          style: new TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBar<Post>(
              onSearch: search,
              onItemFound: (Post post, int index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, top: 10.0, bottom: 10.0),
                  child: new InkWell(
                    onTap: () {
                      _selectPage(context, post);
                      //launch(post.link);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: post.title,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: "\n" + post.description,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

   Future _selectPage(BuildContext context, post) async {
    switch (await showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('Select a option'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Listen'),
              onPressed: () {
                launch(post.link);
              },
            ),
            SimpleDialogOption(
              child: Text('Buy'),
              onPressed: () {
                showToastBuy(post.title);
              },
            ),
            SimpleDialogOption(
              child: Text('Vote'),
              onPressed: () {
                showToastVoted(post.title);
              },
            ),
          ],
        ))) {
      case Pages.FIRST:
        break;
      case Pages.SECOND:
        break;
    }
}

  void showToastBuy(title) {
        Fluttertoast.showToast(
        msg: "You bought " + title + ", it's already on the dj's list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void showToastVoted(title) {
        Fluttertoast.showToast(
        msg: "You voted for " + title + ", it's already on the dj's list",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 20,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}