import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

List songs;

class Post {
  final String title;
  final String description;
  final String link;

  Post(this.title, this.description, this.link);
}

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
                      print(post.link);
                      launch(post.link);
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

}