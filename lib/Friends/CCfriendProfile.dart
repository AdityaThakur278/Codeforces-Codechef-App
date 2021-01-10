import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UserInfoCC.dart';
import 'GraphInfoCC.dart';
import 'dart:async';
import 'package:codeforces_codechef/main.dart';
import 'package:codeforces_codechef/colors.dart';

class CCfriendProfile extends StatefulWidget {
  String handle;
  CCfriendProfile(this.handle);
  @override
  _CCfriendProfileState createState() => _CCfriendProfileState();
}

class _CCfriendProfileState extends State<CCfriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5,
        title: Text('Codechef Friend'),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                String handle = widget.handle;
                List<String> duplicate = [];
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> ls = prefs.getStringList('codechef_friend');

                for (var i in ls) {
                  if (i != handle) {
                    duplicate.add(i);
                  }
                }

                if (duplicate.length == 0) {
                  prefs.setStringList('codechef_friend', null);
                } else {
                  prefs.setStringList('codechef_friend', duplicate);
                }

                // prefs.setStringList('codechef_friend', duplicate);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            UserInfoCC(widget.handle),
            graph1(widget.handle),
          ],
        ),
      ),
    );
  }
}
