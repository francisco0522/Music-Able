import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:app/Data/songList.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

//import 'package:image_picker/image_picker.dart';

var songsData = SongsData.getData;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Future<void> send(emailRecipients) async {
    final Email email = Email(
      body: "Change Password",
      subject: "I want to Change my Password for Music-Able",
      recipients: [emailRecipients],
      isHTML: false,
    );
String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

class ProfileTabs extends StatefulWidget {
  String userEmail;
  ProfileTabs ({Key key, this.userEmail}): super(key: key);
  @override
  _ProfileTabs createState() => _ProfileTabs();
}

class _ProfileTabs extends State<ProfileTabs> {
  List songs;
  Future<File> imageFile;

  /* getImage(ImageSource source) {
     setState(() {
       imageFile = ImagePicker.pickImage(source: source);
     });
   }*/

   playSong(songname) async {
  final response = await http
        .get('http://34.229.218.28:5000/home?code=%22' + songname + '%22');

  List data = jsonDecode(response.body);
  songs = data;
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              image(context),
              options(),
              list(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected for ',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  Widget image(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 65.0, top: 10.0, right: 65.0),
              height: 50.0,
            ),
            showImage(),
          ],
        ),
      ),
    );
  }

  Widget options() {
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
            right: 10.0, left: 10.0, top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ), //       <--- BoxDecoration here
        child: new InkWell(
          onTap: () {
            // getImage(ImageSource.gallery);
          },
          child: Text(
            "Change profile image",
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(
            right: 22.0, left: 22.0, top: 5.0, bottom: 5.0),
        margin: const EdgeInsets.only(bottom: 15.0, top: 15.0, left: 1.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ), //       <--- BoxDecoration here
        child: new InkWell(
          onTap: () {
            send(widget.userEmail);
          },
          child: Text(
            "Change password",
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      ),
    ]);
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
              playSong(songsData[index]['song']).then((data){
                 print(songs[index]['external_urls']['spotify']);
                launch(songs[index]['external_urls']['spotify']);
                });
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
                                    children: <Widget>[
                                      buyList(songsData[index])
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
            ),
          );
        },
      ),
    );
  }
}

Widget buyList(data) {
  var status;
  if (data['state'] == 'Buyed'){
   status ='Buyed';
  }
  else{
     status ='Voted';
  }
  print(status);
  return Container(
    padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
    child: Row(
      children: <Widget>[        
        Icon(
        status=='Buyed'? Icons.monetization_on : Icons.favorite),
        RichText(
          text: TextSpan(
            text: "${data['song']} - ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          ),
        ),
        RichText(
          text: TextSpan(
            text: "${data['artist']} / ",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          ),
        ),
        RichText(
          text: TextSpan(
            text: "${data['date']}",
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
