import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/profile/codeforcesData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_codechef/main.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:codeforces_codechef/colors.dart';
import 'dart:async';
import 'dart:convert';

bool circularIndicator = false;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void check1() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var handle = prefs.getString('codeforces_handle');

  if (handle == null)
    codeforces_login = false;
  else
    codeforces_login = true;
  print('Codeforces_handle : ');
  print(handle);
}

class codeforcesLogin extends StatefulWidget {
  @override
  _codeforcesLoginState createState() => _codeforcesLoginState();
}

class _codeforcesLoginState extends State<codeforcesLogin> {
  CodeforcesData codeforcesDataobj = CodeforcesData();
  void initState() {
    super.initState();
    check1();
  }

  TextEditingController myController = TextEditingController();

  void validate() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('print ' + myController.text);
    // prefs.setString('handle', myController.text);
    //
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => MyApp()));

    String handle = myController.text;
    myController.clear();
    String url = 'https://codeforces.com/api/user.info?handles=' + handle;

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Valid Handle
        circularIndicator = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('codeforces_handle', handle);
        setState(() {
          codeforces_login = true;
        });
      } else {
        throw Exception('error occur');
      }
    } catch (e) {
      print('Invalid Handle');
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MyApp(),
      //   ),
      // );

      setState(() {
        circularIndicator = false;
        Alert(
          image: Image.asset(
            'images/codeforces1.png',
            height: 150.0,
            color: color5,
          ),
          context: context,
          title: "Some Error Occured!!",
          desc: "Enter Valid Handle",
          buttons: [],
        ).show();
      });
    }
  }

  Widget retWidget() {
    if (codeforces_login) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => CodeforcesData()),
      // );
      return codeforcesDataobj;
    } else {
      if (circularIndicator == true)
        return Center(child: CircularProgressIndicator());
      else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextField(
                controller: myController,
                obscureText: false,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter Codeforces Handle",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: color5,
                child: MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    // Navigator.of(context).pop();
                    setState(() {
                      circularIndicator = true;
                      validate();
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: color5,
        // you can put Icon as well, it accepts any widget.
        title: Text("Profile"),
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
                // });

                Navigator.push(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                }),
          ),
        ],
      ),
      body: retWidget(),
      drawer: AppDrawer(),
    );
  }
}
