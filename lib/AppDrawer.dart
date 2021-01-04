import 'package:codeforces_codechef/codeforcesLogin.dart';
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
  void temp() {
    MyApp myAppObj = new MyApp();
    Navigator.pushReplacement(
      _scaffoldKey.currentContext,
      MaterialPageRoute(builder: (context) => myAppObj),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _scaffoldKey,
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
            leading: Icon(Icons.change_history),
            title: Text('Submissions'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_return),
            title: Text('Log Out'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('codeforces_handle');
              prefs.remove('codechef_handle');
              codeforces_login = false;
              codechef_login = false;
              Navigator.pop(context);
              // Get.off(MyApp());
              Alert(
                image: Image.asset(
                  'images/logout.jpg',
                  height: 150.0,
                ),
                context: scaffoldKey.currentContext,
                title: "Logged Out Successfully",
                desc: "Reload pages to see changes",
                buttons: [],
              ).show();
            },
          ), //drawer stuffs
        ],
      ),
    );
  }
}
