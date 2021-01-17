import 'package:codeforces_codechef/error.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:codeforces_codechef/colors.dart';

bool error1 = false;

class Info {
  String username;
  String name;
  int rating;
  String stars;
  String highest_rating;
  String global_rank;
  String country_rank;
  String country;
  String state;
  String city;
  String student_professional;
  String institution;

  Info(
    this.username,
    this.name,
    this.rating,
    this.stars,
    this.highest_rating,
    this.global_rank,
    this.country_rank,
    this.country,
    this.state,
    this.city,
    this.student_professional,
    this.institution,
  );
}

Future<Info> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String handle = prefs.getString('codechef_handle');
  print(handle);
  final response = await http.get(
      'https://competitive-coding-api.herokuapp.com/api/codechef/' + handle);
  try {
    if (response.statusCode == 200) {
      error1 = false;
      // throw Exception('Failed to load album');
      var json1 = jsonDecode(response.body);
      var json2 = jsonDecode(response.body)['user_details'];
      // print(json2['username']);
      // print(json2['name']);
      // print(json1['rating']);
      // print(json1['stars'].toString());
      // print(json1['highest_rating'].toString());
      // print(json1['global_rank']);
      // print(json1['country_rank']);
      // print(json2['country']);
      // print(json2['state']);
      // print(json2['city']);
      // print(json2['student/professional']);
      // print(json2['institution']);
      return (Info(
        json2['username'], //
        json2['name'], //
        json1['rating'],
        json1['stars'] == null ? "Null" : json1['stars'], //
        json1['highest_rating'].toString(), //
        json1['global_rank'].toString(), //
        json1['country_rank'].toString(), //
        json2['country'],
        json2['state'],
        json2['city'],
        json2['student/professional'],
        json2['institution'],
      ));
    } else {
      print("problem1");
      throw Exception('Failed to load album');
    }
  } catch (e) {
    error1 = true;
    print("problem2");
  }
}

class UserInfoCC extends StatefulWidget {
  @override
  _UserInfoCCState createState() => _UserInfoCCState();
}

class _UserInfoCCState extends State<UserInfoCC> {
  Future<Info> future;
  @override
  void initState() {
    super.initState();
    // setState(() {
    future = getData();
    // });
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
                      Text("Name",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Stars",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Highest Rating",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Global Rank",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Country Rank",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Country",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("State",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("City",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Status",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Institution",
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
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data.name ?? "Null"),
                      Text(snapshot.data.stars ?? "Null"),
                      Text(snapshot.data.highest_rating.toString() ?? "Null"),
                      Text(snapshot.data.global_rank.toString() ?? "Null"),
                      Text(snapshot.data.country_rank.toString() ?? "Null"),
                      Text(snapshot.data.country ?? "Null"),
                      Text(snapshot.data.state ?? "Null"),
                      Text(snapshot.data.city ?? "Null"),
                      Text(snapshot.data.student_professional ?? "Null"),
                      Text(snapshot.data.institution ?? "Null"),
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
                if (error1) {
                  return Center(
                    child: Card(
                      elevation: 8.0,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Error Occured!!\n Please Re-Login/Refresh",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 8.0,
                        // margin: EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.person,
                            color: color5,
                          ),
                          title: Text(
                            "ID : " + snapshot.data.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      // Card(
                      //   elevation: 8.0,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: CircleAvatar(
                      //       backgroundColor: Colors.grey,
                      //       radius: 100.0,
                      //       child: CircleAvatar(
                      //         backgroundImage: NetworkImage(
                      //             'https:' + snapshot.data.titlePhoto),
                      //         radius: 98.0,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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
                  return Center(child: error_to_show);
                }
                return Center(
                  child: Card(
                    elevation: 8.0,
                    child: ListTile(
                      title: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
