import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class SubmissionInfo {
  int id;
  int contestId;
  String index;
  String name;
  String verdict;
  int rating;

  SubmissionInfo(
    this.id,
    this.contestId,
    this.index,
    this.name,
    this.verdict,
    this.rating,
  );
}

Future<List<SubmissionInfo>> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String handle = prefs.getString('codeforces_handle');
  print(handle);
  final response =
      await http.get('https://codeforces.com/api/user.status?handle=' + handle);

  try {
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)['result'];
      List<SubmissionInfo> ls = [];
      for (var mp in json) {
        SubmissionInfo obj = SubmissionInfo(
          mp['id'],
          mp['contestId'],
          mp['problem']['index'],
          mp['problem']['name'],
          mp['verdict'].toString(),
          mp['problem']['rating'],
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

class CF_submissions extends StatefulWidget {
  @override
  _CF_submissionsState createState() => _CF_submissionsState();
}

class _CF_submissionsState extends State<CF_submissions> {
  Future<List<SubmissionInfo>> future;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<SubmissionInfo>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[index].index +
                        ". " +
                        snapshot.data[index].name),
                    subtitle: Text("Verdict : " +
                        (snapshot.data[index].verdict ?? "NA") +
                        "   Rating : " +
                        (snapshot.data[index].rating.toString() ?? "NA")),
                    onTap: () {
                      _launchURL('https://codeforces.com/contest/' +
                          snapshot.data[index].contestId.toString() +
                          "/submission/" +
                          snapshot.data[index].id.toString() +
                          "?mobile=true");
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error occur');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
