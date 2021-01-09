import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/Upcoming/upcoming.dart';
import 'package:codeforces_codechef/appBar.dart';
import 'package:codeforces_codechef/login/codechefLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codeforces_codechef/Submissions/submissions.dart';
import 'package:codeforces_codechef/Problems/problemsCF.dart';
import 'package:codeforces_codechef/Upcoming/upcoming.dart';
import 'func3.dart';
import 'appBar.dart';
import 'package:codeforces_codechef/login/codeforcesLogin.dart';
import 'package:codeforces_codechef/Friends/friends.dart';

bool codeforces_login;
bool codechef_login;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.remove('codeforces_handle');
  // prefs.remove('codechef_handle');

  var codeforces_handle = prefs.getString('codeforces_handle');
  var codechef_handle = prefs.getString('codechef_handle');
  if (codeforces_handle == null)
    codeforces_login = false;
  else
    codeforces_login = true;
  if (codechef_handle == null)
    codechef_login = false;
  else
    codechef_login = true;

  print('codeforces_handle : ');
  print(codeforces_handle);

  runApp(MyApp());
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

codeforcesLogin func1_obj = codeforcesLogin();
CodechefLogin func11_obj = CodechefLogin();
Upcoming func2_obj = Upcoming();
Friends func3_obj = Friends();
Submissions func4_obj = Submissions();
ProblemsCF func5_obj = ProblemsCF();

bool codeforcesPage = true;

Widget codeforcesPageState() {
  if (codeforcesPage == true)
    return func1_obj;
  else
    return func11_obj;
}

class Application extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

int selected_index = 0;

class MyAppState extends State<Application> {
  void onTapped(int val) {
    setState(() {
      selected_index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      codeforcesPageState(),
      func2_obj,
      func3_obj,
      func4_obj,
      func5_obj,
    ];

    return WillPopScope(
      onWillPop: () async {
        if (selected_index == 0) {
          return true;
        }
        setState(() {
          selected_index = 0;
        });
        return false;
      },
      child: Scaffold(
        body: _widgetOptions[selected_index],
        drawer: AppDrawer(),
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
              title: Text('Solved'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.code,
              ),
              title: Text('Problems'),
            ),
          ],
          currentIndex: selected_index,
          selectedItemColor: color1,
          onTap: onTapped,
        ),
      ),
    );
  }
}
