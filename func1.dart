import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<UserInfo> fetchAlbum() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String handle = prefs.getString('handle');
//   print('handle ' + handle);
//   final response =
//       await http.get('https://codeforces.com/api/user.info?handles=' + handle);
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return UserInfo.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

class UserInfo {
  String handle;
  String f_name;
  String l_name;
  String country;
  String email;

  UserInfo({this.f_name, this.l_name, this.country, this.email, this.handle});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> result = json['result'];
    return UserInfo(
      f_name: result[0]['firstName'],
      l_name: result[0]['lastName'],
      handle: result[0]['handle'],
      country: result[0]['country'],
      email: result[0]['email'],
    );
  }
}

TextStyle style() {
  return TextStyle(
    fontSize: 20.0,
  );
}

class Func1 {
  Future<UserInfo> _futureAlbum;
  Future<UserInfo> getFutureUserInfo() {
    return _futureAlbum;
  }

  void setFutureUserInfo(Future<UserInfo> _futureAlbum) {
    this._futureAlbum = _futureAlbum;
  }

  Widget func1() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<UserInfo>(
            future: getFutureUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Text(
                      'Handle : ' + snapshot.data.handle,
                      style: style(),
                    ),
                    Text(
                      'First Name : ' + snapshot.data.f_name,
                      style: style(),
                    ),
                    Text(
                      'Last Name : ' + snapshot.data.l_name,
                      style: style(),
                    ),
                    Text(
                      'Email : ' + snapshot.data.email,
                      style: style(),
                    ),
                    Text(
                      'Country : ' + snapshot.data.country,
                      style: style(),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
