import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/main.dart';
import 'package:codeforces_codechef/profile/GraphInfoCF.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codeforces_codechef/profile/UserInfoCC.dart';
import 'GraphInfoCC.dart';
import 'package:codeforces_codechef/colors.dart';

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

Future<UserInfo> fetchAlbum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String handle = prefs.getString('codechef_handle');
  print('handle ' + handle);
  final response =
      await http.get('https://codeforces.com/api/user.info?handles=' + handle);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CodechefData extends StatefulWidget {
  @override
  _CodechefDataState createState() => _CodechefDataState();
}

class _CodechefDataState extends State<CodechefData> {
  @override
  void initState() {
    error1 = false;
    super.initState();
  }
  // Future<UserInfo> _futureAlbum;
  //
  // Future<UserInfo> getFutureUserInfo() {
  //   return _futureAlbum;
  // }
  //
  // void setFutureUserInfo(Future<UserInfo> _futureAlbum) {
  //   print(_futureAlbum);
  //   this._futureAlbum = _futureAlbum;
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   setFutureUserInfo(fetchAlbum());
  // }
  //
  // Widget func1() {
  //   // print('Data');
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         FutureBuilder<UserInfo>(
  //           future: getFutureUserInfo(),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               print('Data');
  //               return Column(
  //                 children: <Widget>[
  //                   Text(
  //                     'Handle : ' + snapshot.data.handle,
  //                     style: style(),
  //                   ),
  //                   Text(
  //                     'First Name : ' + snapshot.data.f_name,
  //                     style: style(),
  //                   ),
  //                   Text(
  //                     'Last Name : ' + snapshot.data.l_name,
  //                     style: style(),
  //                   ),
  //                   Text(
  //                     'Email : ' + snapshot.data.email,
  //                     style: style(),
  //                   ),
  //                   Text(
  //                     'Country : ' + snapshot.data.country,
  //                     style: style(),
  //                   ),
  //                 ],
  //               );
  //             } else if (snapshot.hasError) {
  //               return Text("${snapshot.error}");
  //             }
  //
  //             // By default, show a loading spinner.
  //             else {
  //               return CircularProgressIndicator();
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget retwid() {
    return Column(
      children: [
        UserInfoCC(),
        graph1(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: color5,
        strokeWidth: 2.5,
        onRefresh: () async {
          error1 = false;
          e1 = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          );
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: retwid(),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
