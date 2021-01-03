import 'package:codeforces_codechef/appBar.dart';
import 'package:codeforces_codechef/func1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'func1.dart';
import 'func2.dart';
import 'func3.dart';
import 'func4.dart';
import 'func5.dart';
import 'appBar.dart';
import 'Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('handle');
  var handle = prefs.getString('handle');
  print(handle);
  runApp(handle == null ? Login() : MyApp());
}

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Application());
  }
}

class Application extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Func1 func1_obj = Func1();
Func2 func2_obj = Func2();
Func3 func3_obj = Func3();
Func4 func4_obj = Func4();
Func5 func5_obj = Func5();

List<Widget> _widgetOptions = <Widget>[
  func1_obj.func1(),
  func2_obj.func2(),
  func3_obj.func3(),
  func4_obj.func4(),
  func5_obj.func5(),
];
int selected_index = 0;

class _MyAppState extends State<Application> {
  void onTapped(int val) {
    setState(() {
      selected_index = val;
    });
  }

  @override
  void initState() {
    super.initState();
    func1_obj.setFutureUserInfo(fetchAlbum());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: retAppBar(),
      body: SafeArea(
        child: _widgetOptions[selected_index],
      ),
      drawer: Drawer(
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
            ), //drawer stuffs
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            title: Text('Upcoming'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
            ),
            title: Text('Friends'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
            ),
            title: Text('Upsolve'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.code,
            ),
            title: Text('Problems'),
          ),
        ],
        currentIndex: selected_index,
        selectedItemColor: color3,
        onTap: onTapped,
      ),
    );
  }
}
