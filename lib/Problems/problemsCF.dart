import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'ViewUrlCf.dart';
import 'package:codeforces_codechef/colors.dart';
import 'package:codeforces_codechef/main.dart';

class ProblemInfo {
  int contestId;
  String index;
  String name;
  int rating;
  int solvedCount;

  ProblemInfo(
    this.contestId,
    this.index,
    this.name,
    this.rating,
    this.solvedCount,
  );
}

Future<List<ProblemInfo>> getData() async {
  final response =
      await http.get('https://codeforces.com/api/problemset.problems');
  try {
    if (response.statusCode == 200) {
      var json1 = jsonDecode(response.body)['result']['problems'];
      var json2 = jsonDecode(response.body)['result']['problemStatistics'];
      List<ProblemInfo> ls = [];
      // print(json1.length);
      for (int i = 0; i < json1.length; i++) {
        // print(json1[i]['contestId']);
        // print(json1[i]['index']);
        // print(json1[i]['name']);
        // print(json1[i]['rating']);
        // print(json2[i]['solvedCount']);
        ProblemInfo obj = ProblemInfo(
          json1[i]['contestId'],
          json1[i]['index'],
          json1[i]['name'],
          json1[i]['rating'],
          json2[i]['solvedCount'],
        );
        ls.add(obj);
      }
      return ls;
    } else {
      throw Exception("Error occur");
    }
  } catch (e) {
    print("Exception");
  }
}

class ProblemsCF extends StatefulWidget {
  @override
  _ProblemsCFState createState() => _ProblemsCFState();
}

class _ProblemsCFState extends State<ProblemsCF> {
  Future<List<ProblemInfo>> future;

  @override
  void initState() {
    super.initState();
    future = getData();
  }

  Widget retWidget() {
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
      child: Center(
        child: FutureBuilder<List<ProblemInfo>>(
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
                      title: Text(snapshot.data[index].index +
                          ". " +
                          snapshot.data[index].name),
                      subtitle: Text("Rating : " +
                          (snapshot.data[index].rating.toString() ?? "NA") +
                          "     Solved-by : " +
                          snapshot.data[index].solvedCount.toString()),
                      onTap: () {
                        String url =
                            "https://codeforces.com/problemset/problem/" +
                                snapshot.data[index].contestId.toString() +
                                "/" +
                                snapshot.data[index].index;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewUrlCf(url),
                          ),
                        );
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5,
        title: Text("Codeforces Problemset"),
      ),
      drawer: AppDrawer(),
      body: retWidget(),
    );
  }
}
