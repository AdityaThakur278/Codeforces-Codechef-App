import 'package:flutter/material.dart';
import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/main.dart';
import 'CCfriends.dart';
import 'CFfriends.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

bool loading = false;

class _FriendsState extends State<Friends> {
  TextEditingController myController = TextEditingController();

  Future<String> addFriend(BuildContext context) async {
    String teamName = '';
    return showDialog(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Friend'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(hintText: 'Enter handle'),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: [
            FlatButton(
              child: Text('ADD'),
              onPressed: () {
                setState(() {
                  loading = true;
                });
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : retWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String handle = await addFriend(context);

          // Add Friend to Codeforces List
          if (codeforcesPage == true) {
            String url =
                "https://codeforces.com/api/user.info?handles=" + handle;
            myController.clear();

            bool valid;
            bool found = false;
            final response = await http.get(url);
            try {
              if (response.statusCode == 200) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> ls = prefs.getStringList("codeforces_friend");
                if (ls == null) {
                  prefs.setStringList('codeforces_friend', [handle]);
                } else {
                  for (var i in ls) {
                    if (i == handle) {
                      found = true;
                      break;
                    }
                  }
                  if (!found) ls.add(handle);
                  prefs.setStringList('codeforces_friend', ls);
                }
                valid = true;
              } else {
                valid = false;
                throw ("Exception");
              }
            } catch (e) {
              valid = false;
              print("Exception");
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
            setState(() {
              loading = false;
            });
            if (found == true) {
              Alert(
                image: Image.asset(
                  'images/codeforces1.png',
                  height: 150.0,
                  color: color3,
                ),
                context: context,
                title: "Friend Already Exists",
                buttons: [],
              ).show();
            } else if (valid == true) {
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
            } else {
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
            }
          }

          // Add Friend to Codechef List
          else {
            String url =
                "https://competitive-coding-api.herokuapp.com/api/codechef/" +
                    handle;
            myController.clear();

            bool valid;
            bool found = false; // Check repeatition
            final response = await http.get(url);

            try {
              if (response.statusCode == 200) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> ls = prefs.getStringList("codechef_friend");

                if (ls == null) {
                  prefs.setStringList('codechef_friend', [handle]);
                } else {
                  for (var i in ls) {
                    if (i == handle) {
                      found = true;
                      break;
                    }
                  }
                  if (!found) ls.add(handle);
                  prefs.setStringList('codechef_friend', ls);
                }
                valid = true;
              } else {
                valid = false;
                throw ("Exception");
              }
            }
            //
            catch (e) {
              valid = false;
              print("Exception");
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
            );
            setState(() {
              loading = false;
            });
            if (found == true) {
              Alert(
                image: Image.asset(
                  'images/codechef1.png',
                  height: 150.0,
                  color: color3,
                ),
                context: context,
                title: "Friend Already Exists",
                buttons: [],
              ).show();
            } else if (valid == true) {
              Alert(
                image: Image.asset(
                  'images/codechef1.png',
                  height: 150.0,
                  color: color3,
                ),
                context: context,
                title: "Friend Added Successfully",
                buttons: [],
              ).show();
            } else {
              Alert(
                image: Image.asset(
                  'images/codechef1.png',
                  height: 150.0,
                  color: color3,
                ),
                context: context,
                title: "Invalid handle!!",
                desc: "Enter Valid Handle",
                buttons: [],
              ).show();
            }
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
