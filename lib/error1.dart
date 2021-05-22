import 'package:flutter/material.dart';
import 'colors.dart';
import 'main.dart';

Widget error_to_show1 = Container(
  height: 200.0,
  child: Center(
    child: Card(
      elevation: 8.0,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Error Occured!!\n Please Re-Login/Refresh",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ),
);
