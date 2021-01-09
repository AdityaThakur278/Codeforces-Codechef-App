import 'package:flutter/material.dart';
import 'UserInfoCF.dart';
import 'GraphInfoCF.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codeforces_codechef/main.dart';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class CFfriendProfile extends StatefulWidget {
  String handle;
  CFfriendProfile(this.handle);

  @override
  _CFfriendProfileState createState() => _CFfriendProfileState();
}

class _CFfriendProfileState extends State<CFfriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        title: Text('Codeforces Friend'),
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
                List<String> ls = prefs.getStringList('codeforces_friend');

                print(handle);
                for (var i in ls) {
                  print(i);
                  if (i.toLowerCase() != handle.toLowerCase()) {
                    duplicate.add(i);
                  }
                }
                if (duplicate.length == 0) {
                  prefs.setStringList('codeforces_friend', null);
                } else {
                  prefs.setStringList('codeforces_friend', duplicate);
                }

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
            UserInfoCF(widget.handle),
            graph(widget.handle),
          ],
        ),
      ),
    );
  }
}
