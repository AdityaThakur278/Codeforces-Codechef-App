import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/profile/codechefData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:codeforces_codechef/main.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

bool circularIndicator = false;
const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void check2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var handle = prefs.getString('codechef_handle');

  if (handle == null)
    codechef_login = false;
  else
    codechef_login = true;
  print('Codechef_handle : ');
  print(handle);
}

class CodechefLogin extends StatefulWidget {
  @override
  _CodechefLoginState createState() => _CodechefLoginState();
}

class _CodechefLoginState extends State<CodechefLogin> {
  CodechefData codechefDataobj = CodechefData();
  void initState() {
    super.initState();
    check2();
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

    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        // Valid Handle
        circularIndicator = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('codechef_handle', handle);
        setState(() {
          codechef_login = true;
        });
      } else {
        throw Exception('error occur');
      }
    } catch (e) {
      print('Invalid Handle');
      // Navigator.pushReplacement(
      //   _scaffoldKey.currentContext,
      //   MaterialPageRoute(
      //     builder: (context) => MyApp(),
      //   ),
      // );

      setState(() {
        circularIndicator = false;
        Alert(
          image: Image.asset(
            'images/codechef1.png',
            height: 150.0,
            color: color3,
          ),
          // context: scaffoldKey.currentContext,
          context: context,
          title: "Invalid handle!!",
          desc: "Enter Valid Handle",
          // desc: "Enter Proper Handle",
          buttons: [],
        ).show();
      });
    }
  }

  Widget retWidget() {
    if (codechef_login) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => CodeforcesData()),
      // );
      return codechefDataobj;
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
                  hintText: "Enter Codechef Handle",
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
                color: color3,
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
        backgroundColor: color3,
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

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  })),
        ],
      ),
      body: retWidget(),
      drawer: AppDrawer(),
    );
  }
}