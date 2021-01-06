import 'package:codeforces_codechef/Submissions/CF_submissions.dart';
import 'package:codeforces_codechef/Submissions/CC_submissions.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_codechef/main.dart';
import 'package:codeforces_codechef/AppDrawer.dart';

class Submissions extends StatefulWidget {
  @override
  _SubmissionsState createState() => _SubmissionsState();
}

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class _SubmissionsState extends State<Submissions> {
  Widget retWidget() {
    if (codeforcesPage == true) {
      if (codeforces_login == true) {
        return CF_submissions();
      } else {
        codeforcesPage = true;
        return Center(
          child: FlatButton(
            color: color3,
            onPressed: () {
              selected_index = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Login to see\nCodeforces submissions\n\nClick Here!!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        );
      }
    } else {
      if (codechef_login == true) {
        return CC_submissions();
      } else {
        codeforcesPage = false;
        return Center(
          child: FlatButton(
            color: color3,
            onPressed: () {
              selected_index = 0;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Login to see\nCodechef submissions\n\nClick Here!!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        // you can put Icon as well, it accepts any widget.
        title: Text("Submissions"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: IconButton(
              icon: Image.asset(
                'images/codeforces1.png',
                color: Colors.white,
              ),
              onPressed: () {
                // setState(() {
                codeforcesPage = true;
                // })
                selected_index = 3;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 5.0, right: 10.0),
              child: IconButton(
                  icon: Image.asset(
                    'images/codechef1.png',
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // setState(() {
                    codeforcesPage = false;
                    // });
                    selected_index = 3;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  })),
        ],
      ),
      drawer: AppDrawer(),
      body: retWidget(),
    );
  }
}
