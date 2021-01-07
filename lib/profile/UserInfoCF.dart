import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class Info {
  String firstname;
  String lastname;
  String email;
  String country;
  int rating;
  int maxRating;
  String organisation;
  int contribution;
  String rank;
  String maxRank;
  int friendOfCount;
  String titlePhoto;
  String handle;

  Info(
    this.firstname,
    this.lastname,
    this.email,
    this.country,
    this.rating,
    this.maxRating,
    this.organisation,
    this.contribution,
    this.rank,
    this.maxRank,
    this.friendOfCount,
    this.titlePhoto,
    this.handle,
  );
}

Future<Info> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String handle = prefs.getString('codeforces_handle');

  final response =
      await http.get('https://codeforces.com/api/user.info?handles=' + handle);
  try {
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)['result'][0];
      return (Info(
        json['firstName'],
        json['lastName'],
        json['email'],
        json['country'],
        json['rating'],
        json['maxRating'],
        json['organization'],
        json['contribution'],
        json['rank'],
        json['maxRank'],
        json['friendOfCount'],
        json['titlePhoto'],
        handle,
      ));
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {
    print("Exception");
  }
}

class UserInfoCF extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoCF> {
  Future<Info> future;
  @override
  void initState() {
    super.initState();
    future = getData();
  }

  Widget wid() {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Firstname",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Lastname",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Email",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Country",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Rating",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("MaxRating",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Organisation",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Contribution",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Rank",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("MaxRank",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("FriendOf",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                      Text(" - "),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data.firstname ?? "Null"),
                      Text(snapshot.data.lastname ?? "Null"),
                      Text(snapshot.data.email ?? "Null"),
                      Text(snapshot.data.country ?? "Null"),
                      Text(snapshot.data.rating.toString() ?? "Null"),
                      Text(snapshot.data.maxRating.toString() ?? "Null"),
                      Text(snapshot.data.organisation ?? "Null"),
                      Text(snapshot.data.contribution.toString() ?? "Null"),
                      Text(snapshot.data.rank ?? "Null"),
                      Text(snapshot.data.maxRank ?? "Null"),
                      Text(snapshot.data.friendOfCount.toString() ?? "Null"),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          return CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Column(
        children: [
          FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 8.0,
                        // margin: EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            "ID : " + snapshot.data.handle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: color3,
                            radius: 100.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https:' + snapshot.data.titlePhoto),
                              radius: 98.0,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8.0,
                        // margin:
                        //     EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                        child: Center(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            scrollDirection: Axis.horizontal,
                            child: wid(), // Function is implemented above
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error'));
                }
                return Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    CircularProgressIndicator(),
                  ],
                ));
              }),
        ],
      ),
    );
  }
}
