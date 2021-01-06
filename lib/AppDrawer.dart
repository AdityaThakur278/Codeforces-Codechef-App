import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 150.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: color3,
              ),
              child: Center(
                child: Text(
                  'App Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.assignment_return),
            title: Text('Codeforces Logout'),
            onTap: () async {
              // selected_index = 0;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var handle = prefs.getString('codeforces_handle');
              prefs.remove('codeforces_handle');
              codeforces_login = false;
              codeforcesPage = true;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MyApp()));
            },
          ), //d
          ListTile(
            leading: Icon(Icons.assignment_return),
            title: Text('Codechef Logout'),
            onTap: () async {
              // selected_index = 0;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var handle = prefs.getString('codechef_handle');
              prefs.remove('codechef_handle');
              codechef_login = false;
              codeforcesPage = false;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MyApp()));
            },
          ), // rawer stuffs
        ],
      ),
    );
  }
}
