import 'package:flutter/material.dart';
import 'main.dart';
import 'package:codeforces_codechef/colors.dart';

// bool codeforcesPage = true;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

AppBar retAppBar() {
  if (selected_index == 0) {
    return AppBar(
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
            onPressed: () {},
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
                  MyApp();
                })),
      ],
    );
  } else if (selected_index == 1) {
    return AppBar(
      backgroundColor: color5,
      title: Text('Upcoming Contest'),
    );
  } else if (selected_index == 2) {
    return AppBar(
      backgroundColor: color5,
      title: Text('Friends'),
    );
  } else if (selected_index == 3) {
    return AppBar(
      backgroundColor: color5,
      title: Text('Upsolve'),
    );
  } else if (selected_index == 4) {
    return AppBar(
      backgroundColor: color5,
      title: Text('Problemset'),
    );
  }
}
