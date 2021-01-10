import 'package:flutter/material.dart';

Widget error_to_show = Center(
  child: Card(
    elevation: 8.0,
    child: ListTile(
      title: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "Some Error Occured!!\n Please Re-load/Refresh",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
);
