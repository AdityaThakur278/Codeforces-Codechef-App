import 'package:codeforces_codechef/Friends/CFfriendProfile.dart';
import 'package:codeforces_codechef/error.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:codeforces_codechef/colors.dart';

bool nofriend;

class Info {
  String handle;
  String rank;
  String rating;
  String titlePhoto;

  Info(this.handle, this.rank, this.rating, this.titlePhoto);
}

class CFfriends extends StatefulWidget {
  @override
  _CFfriendsState createState() => _CFfriendsState();
}

class _CFfriendsState extends State<CFfriends> {
  Future<List<Info>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('codeforces_friend');
    List<String> ls = prefs.getStringList('codeforces_friend');

    if (ls != null) {
      setState(() {
        nofriend = false;
      });
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
              mp["rank"] == null ? "Null" : mp["rank"],
              mp["rating"] == null ? "Null" : mp["rating"].toString(),
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
    } else {
      setState(() {
        nofriend = true;
      });
      return [];
    }
  }

  Future<List<Info>> future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    if (nofriend == true) {
      return Card(
        elevation: 8.0,
        child: ListTile(
          title: Text(
            "No Friends",
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
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
                      backgroundColor: color5,
                      radius: 27.0,
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            "https:" + snapshot.data[index].titlePhoto),
                      ),
                    ),
                    title: Text(snapshot.data[index].handle),
                    subtitle: Text("Rating : " +
                        snapshot.data[index].rating +
                        "  Rank : " +
                        snapshot.data[index].rank),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CFfriendProfile(snapshot.data[index].handle),
                          ));
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: error_to_show,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  }
}
