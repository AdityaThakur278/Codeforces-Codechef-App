import 'package:codeforces_codechef/error.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'ViewUrlCF.dart';
import 'package:codeforces_codechef/colors.dart';
import 'package:codeforces_codechef/main.dart';

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
  InAppWebViewController webView;
  Future<List<SubmissionInfo>> future;

  webview(String Url) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => InAppWebView(
          initialUrl: Url,
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
                preferredContentMode: UserPreferredContentMode.DESKTOP),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {},
          onLoadStop: (InAppWebViewController controller, String url) async {},
        ),
      ),
    );
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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    child: ListTile(
                      title: Text(snapshot.data[index].index +
                          ". " +
                          snapshot.data[index].name),
                      subtitle: Text("Verdict : " +
                          (snapshot.data[index].verdict ?? "NA") +
                          "   Rating : " +
                          (snapshot.data[index].rating.toString() ?? "NA")),
                      onTap: () {
                        String url = 'https://codeforces.com/contest/' +
                            snapshot.data[index].contestId.toString() +
                            "/submission/" +
                            snapshot.data[index].id.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewUrlCF(url),
                          ),
                        );
                        // webview(url);
                      },
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: error_to_show,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
