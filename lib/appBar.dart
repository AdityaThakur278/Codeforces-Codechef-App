import 'package:flutter/material.dart';
import 'main.dart';

AppBar retAppBar() {
  if (selected_index == 0) {
    return AppBar(
      backgroundColor: color3,
      title: Text('User Profile'),
    );
  } else if (selected_index == 1) {
    return AppBar(
      backgroundColor: color3,
      title: Text('Upcoming Contest'),
    );
  } else if (selected_index == 2) {
    return AppBar(
      backgroundColor: color3,
      title: Text('Friends'),
    );
  } else if (selected_index == 3) {
    return AppBar(
      backgroundColor: color3,
      title: Text('Upsolve'),
    );
  } else if (selected_index == 4) {
    return AppBar(
      backgroundColor: color3,
      title: Text('Problemset'),
    );
  }
}
