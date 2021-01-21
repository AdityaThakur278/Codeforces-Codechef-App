import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:codeforces_codechef/colors.dart';
import 'AboutUs.dart';

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
                color: color5,
              ),
              child: Center(
                child: Text(
                  'CF/CC Visualizer',
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
          ), //
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('About Developers'),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Aboutus(),
                  ));
            },
          ), // rawer stuffs
        ],
      ),
    );
  }
}
