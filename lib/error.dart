import 'package:flutter/material.dart';
import 'colors.dart';
import 'main.dart';
import 'package:codeforces_codechef/Upcoming/upcoming.dart';

Widget error_to_show(context) {
  error3 = false;
  return RefreshIndicator(
    color: color5,
    strokeWidth: 2.5,
    onRefresh: () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      );
    },
    // "Some Error Occured!! \nPlease Reload/Refresh"
    child: ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Text(
                'Some Error Occured!! \nPlease Reload/Refresh',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        );
      },
      itemCount: 1,
    ),
  );
}
