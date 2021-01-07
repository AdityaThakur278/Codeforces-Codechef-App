import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'ViewUrlCC.dart';

class Info {
  String name;
  String url;
  String contestName;
  String status;
  Info(
    this.name,
    this.url,
    this.contestName,
    this.status,
  );
}

Future<List<Info>> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String handle = prefs.getString('codechef_handle');

  final response = await http.get(
      'https://competitive-coding-api.herokuapp.com/api/codechef/' + handle);

  try {
    if (response.statusCode == 200) {
      var json1 = jsonDecode(response.body)['fully_solved'];
      var json2 = jsonDecode(response.body)['partially_solved'];

      List<Info> ls = [];
      json1.forEach((contestname, contest_list) {
        if (contestname != 'count') {
          for (var x in contest_list) {
            Info variable =
                Info(x['name'], x['link'], contestname, "Fully - Solved");
            ls.add(variable);
          }
        }
      });

      json1.forEach((contestname, contest_list) {
        if (contestname != 'count') {
          for (var x in contest_list) {
            Info variable =
                Info(x['name'], x['link'], contestname, "Partially - Solved");
            ls.add(variable);
          }
        }
      });
      // List<Future<ListInfo>> temp = [obj1,obj2];
      // return (Future.value([ls1, ls2]));
      return ls;
    } else {
      throw ("Exception");
    }
  } catch (e) {
    print("Error occur");
  }
}

List<Info> getfromFuture(List<Info> obj) {
  return obj;
}

class CC_submissions extends StatefulWidget {
  @override
  _CC_submissionsState createState() => _CC_submissionsState();
}

class _CC_submissionsState extends State<CC_submissions> {
  Future<List<Info>> future;

  @override
  void initState() {
    super.initState();
    future = getData();
    // Future<List<List<Info>>> temp = getData();
    // List<List<Info>> temp1 = await temp;
    // List<Info> obj1 = temp1[0];
    // List<Info> obj2 = temp1[1];
    // future1 = getfromFuture(obj1);
    // future2 = getfromFuture(obj2);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      title:
                          Text("Problem Code - " + snapshot.data[index].name),
                      subtitle: Text("Contest Code - " +
                          snapshot.data[index].contestName +
                          '\n' +
                          'Status - ' +
                          snapshot.data[index].status),
                      onTap: () {
                        String url = snapshot.data[index].url;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewUrlCC(url),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error occur');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
