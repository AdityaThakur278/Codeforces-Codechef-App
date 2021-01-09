import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class Info {
  String handle;
  String rank;
  int rating;
  String titlePhoto;

  Info(this.handle, this.rank, this.rating, this.titlePhoto);
}

Future<List<Info>> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.remove('codeforces_friend');
  List<String> ls = prefs.getStringList('codeforces_friend');

  String url = "https://codeforces.com/api/user.info?handles=";

  for (var x in ls) {
    url += (x + ";");
  }
  final response = await http.get(url);

  try {
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)['result'];
      List<Info> ls = [];
      for (var mp in json) {
        Info obj = Info(
          mp["handle"],
          mp["rank"],
          mp["rating"],
          mp["titlePhoto"],
        );
        ls.add(obj);
      }
      return ls;
    } else {
      throw Exception('Failed to load album');
    }
  } catch (e) {
    print("Exception");
  }
}

class CFfriends extends StatefulWidget {
  @override
  _CFfriendsState createState() => _CFfriendsState();
}

class _CFfriendsState extends State<CFfriends> {
  Future<List<Info>> future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Info>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color3,
                    radius: 27.0,
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          "https:" + snapshot.data[index].titlePhoto),
                    ),
                  ),
                  title: Text(snapshot.data[index].handle),
                  subtitle: Text("Rating : " +
                      snapshot.data[index].rating.toString() +
                      "  Rank : " +
                      snapshot.data[index].rank),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error occur');
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
