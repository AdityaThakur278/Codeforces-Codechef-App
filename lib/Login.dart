import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginChild(),
    );
  }
}

bool circularIndicator = false;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LoginChild extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginChild> {
  TextEditingController myController = TextEditingController();

  void validate() async {
    //     // SharedPreferences prefs = await SharedPreferences.getInstance();
    // print('print ' + myController.text);
    // prefs.setString('handle', myController.text);
    //
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => MyApp()));
    setState(() {
      circularIndicator = true;
    });

    String handle = myController.text;
    myController.clear();
    String url = 'https://codeforces.com/api/user.info?handles=' + handle;

    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        // Valid Handle
        circularIndicator = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('handle', handle);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        );
      } else {
        throw Exception('error occur');
      }
    } catch (e) {
      print('Invalid Handle');
      Alert(
        context: _scaffoldKey.currentContext,
        title: "Invalid Handle!!",
        desc: "Enter Proper Handle",
      ).show();

      setState(() {
        circularIndicator = false;
      });

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Login(),
      //   ),
      // );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: color3,
      ),
      body: circularIndicator == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextField(
                    controller: myController,
                    obscureText: false,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Enter Codeforces Handle",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                      onPressed: validate,
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
            ),
    );
  }
}
