import 'package:flutter/material.dart';
import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/main.dart';
import 'CCfriends.dart';
import 'CFfriends.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController myController = TextEditingController();

  Future<bool> addFriend() async {
    Alert(
        context: context,
        title: "Add Friend",
        content: Column(
          children: <Widget>[
            TextField(
              controller: myController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              String handle = myController.text;
              String url =
                  "https://codeforces.com/api/user.info?handles=" + handle;
              myController.clear();

              final response = await http.get(url);
              try {
                if (response.statusCode == 200) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String> ls = prefs.getStringList("codeforces_friend");
                  if (ls == null) {
                    prefs.setStringList('codeforces_friend', [handle]);
                  } else {
                    ls.add(handle);
                    prefs.setStringList('codeforces_friend', ls);
                  }
                  Navigator.pop(context);
                  return true;
                } else {
                  Navigator.pop(context);
                  return true;
                }
              } catch (e) {
                Navigator.pop(context);
                print("Exception");
                return true;
              }
            },
            child: Text(
              "ADD",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget retWidget() {
    if (codeforcesPage == true) {
      return CFfriends();
    } else {
      return CCfriends();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        title: Text("Friends"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: IconButton(
              icon: Image.asset(
                'images/codeforces1.png',
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  codeforcesPage = true;
                  selected_index = 2;
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyApp(),
                  //   ),
                  // );
                });
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
                setState(() {
                  codeforcesPage = false;
                  selected_index = 2;
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyApp(),
                  //   ),
                  // );
                });
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: retWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Future<bool> vari = ;

          FutureBuilder<bool>(
              future: addFriend(),
              builder: (context, snapshot) {
                print("Hello");
                if (snapshot.hasData) {
                  print("Gaan mara");
                  Alert(
                    image: Image.asset(
                      'images/codeforces1.png',
                      height: 150.0,
                      color: color3,
                    ),
                    context: context,
                    title: "Friend Added Successfully",
                    buttons: [],
                  ).show();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print("Aji L mera");
                  Alert(
                    image: Image.asset(
                      'images/codeforces1.png',
                      height: 150.0,
                      color: color3,
                    ),
                    context: context,
                    title: "Invalid handle!!",
                    desc: "Enter Valid Handle",
                    buttons: [],
                  ).show();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
