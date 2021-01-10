import 'package:codeforces_codechef/Friends/CFfriendProfile.dart';
import 'package:codeforces_codechef/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'CCfriendProfile.dart';
import 'package:codeforces_codechef/colors.dart';

bool nofriend;

class CCfriends extends StatefulWidget {
  @override
  _CCfriendsState createState() => _CCfriendsState();
}

class _CCfriendsState extends State<CCfriends> {
  Future<List<String>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('codechef_friend');
    List<String> ls = prefs.getStringList('codechef_friend');

    if (ls == null) {
      setState(() {
        nofriend = true;
      });
    } else {
      setState(() {
        nofriend = false;
      });
    }
    print(nofriend);
    return ls;
  }

  Future<List<String>> future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    if (nofriend == true) {
      return Card(
        elevation: 8.0,
        child: ListTile(
          title: Text(
            "No Friends",
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return FutureBuilder<List<String>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8.0,
                  child: ListTile(
                    title: Text(snapshot.data[index]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CCfriendProfile(snapshot.data[index]),
                          ));
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: error_to_show,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  }
}
