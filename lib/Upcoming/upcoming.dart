import 'package:codeforces_codechef/AppDrawer.dart';
import 'package:codeforces_codechef/error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:url_launcher/url_launcher.dart';
import 'package:codeforces_codechef/colors.dart';
import 'package:codeforces_codechef/main.dart';

String formatDuration(Duration d) {
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  final List<String> tokens = [];
  if (days != 0) {
    tokens.add('${days}D');
  }
  if (tokens.isNotEmpty || hours != 0) {
    tokens.add('${hours}H');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    tokens.add('${minutes}M');
  }
  tokens.add('${seconds}S');

  return tokens.join(':');
}

class Sites {
  final String name;
  final String url;
  DateTime start_time;
  DateTime end_time;
  String duration;
  final String site;
  final String in_24_hours;
  final String status;

  Sites({
    this.name,
    this.url,
    this.start_time,
    this.end_time,
    this.duration,
    this.site,
    this.in_24_hours,
    this.status,
  });
}

bool error3 = false;

class Upcoming extends StatefulWidget {
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  Future<List<Sites>> fetchSites() async {
    try {
      final response = await http.get('https://kontests.net/api/v1/all');
      if (response.statusCode == 200) {
        List<Sites> contests = [];
        var json = jsonDecode(response.body);
        for (var x in json) {
          Sites contest = Sites(
            name: x['name'],
            url: x['url'],
            start_time: DateTime.parse(x['start_time']),
            end_time: DateTime.parse(x['end_time']),
            duration: x['duration'],
            site: x['site'],
            in_24_hours: x['in_24_hours'],
            status: x['status'],
          );

          // Format duration in HH:MM:SS
          double y = double.parse(contest.duration);
          int z = y.toInt();
          Duration xd = new Duration(seconds: z);
          contest.duration = formatDuration(xd);

          // Adding 5hrs and 30mins in start_time and end_time
          contest.start_time = contest.start_time.add(new Duration(hours: 5));
          contest.start_time =
              contest.start_time.add(new Duration(minutes: 30));
          contest.end_time = contest.end_time.add(new Duration(hours: 5));
          contest.end_time = contest.end_time.add(new Duration(minutes: 30));

          DateTime now = DateTime.now();
          DateTime d1 = contest.start_time;

          if (contest.status == 'BEFORE' && d1.compareTo(now) > 0) {
            contests.add(contest);
          }
        }
        return contests;
      } else {
        print("error");
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Sites');
      }
    } catch (e) {
      setState(() {
        error3 = true;
      });
      print('Exception');
    }
  }

  Future<List<Sites>> futureSites;

  CircleAvatar contestimage(String site) {
    String sitename;
    if (site == 'HackerEarth')
      sitename = 'hackerearth.png';
    else if (site == 'CodeChef')
      sitename = 'codechef.jpg';
    else if (site == 'CodeForces')
      sitename = 'codeforces.jpg';
    else if (site == 'AtCoder')
      sitename = 'atcoder.png';
    else if (site == 'LeetCode')
      sitename = 'leetcode.png';
    else if (site == 'CS Academy')
      sitename = 'csacademy.png';
    else if (site == 'HackerRank')
      sitename = 'hackerrank.png';
    else if (site == 'TopCoder')
      sitename = 'topcoder.jpeg';
    else if (site == 'Kick Start')
      sitename = 'kickstart.jpg';
    else if (site == 'CodeForces::Gym') sitename = 'codeforces.jpg';

    return CircleAvatar(
      radius: 28.0,
      backgroundColor: color5,
      child: CircleAvatar(
        backgroundImage: AssetImage('images/$sitename'),
        radius: 26.0,
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    futureSites = fetchSites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5,
        title: Text("Upcoming Contests"),
      ),
      drawer: AppDrawer(),
      body: error3 == true
          ? Center(child: error_to_show(context))
          : RefreshIndicator(
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
                child: FutureBuilder<List<Sites>>(
                  future: futureSites,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8,
                            child: ListTile(
                              leading: contestimage(snapshot.data[index].site),
                              title: Text(snapshot.data[index].name),
                              subtitle: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Platform"),
                                      Text("Date"),
                                      Text("Start Time"),
                                      Text("Duration"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("  -  "),
                                      Text("  -  "),
                                      Text("  -  "),
                                      Text("  -  "),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[index].site),
                                      Text(snapshot.data[index].start_time
                                          .toString()
                                          .substring(0, 10)),
                                      Text(snapshot.data[index].start_time
                                              .toString()
                                              .substring(11, 19) +
                                          "  UTC+5.5"),
                                      Text(snapshot.data[index].duration),
                                    ],
                                  )
                                ],
                              ),
                              onTap: () {
                                _launchURL(snapshot.data[index].url);
                              },
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
    );
  }
}
