import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Contest {
  String contestname;
  int rank;
  int orating;
  int nrating;
  DateTime time;
  // String color;
  Contest(
    this.contestname,
    this.rank,
    this.orating,
    this.nrating,
    this.time,
    // this.color,
  );
}

class graph extends StatefulWidget {
  String handle;
  graph(this.handle);

  @override
  _graphState createState() => _graphState();
}

class _graphState extends State<graph> {
  Future<List<Contest>> graphData;
  int minRating = 5000;
  int maxRating = 0;
  @override
  void initState() {
    graphData = _getUserContestInfo();
    super.initState();
  }

  Future<List<Contest>> _getUserContestInfo() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String handle = prefs.getString('codeforces_handle');

    final response = await http
        .get('https://codeforces.com/api/user.rating?handle=' + widget.handle);
    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Contest> tempList = new List<Contest>();
        for (var contests in jsonData['result']) {
          minRating = min(contests['newRating'], minRating);
          maxRating = max(contests['newRating'], maxRating);
          Contest temp = Contest(
            contests['contestName'],
            contests['rank'],
            contests['oldRating'],
            contests['newRating'],
            startTime(contests['ratingUpdateTimeSeconds']),
          );
          tempList.add(temp);
        }
        return tempList;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      print("Exception");
    }
  }

  DateTime startTime(timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date;
  }

  List<LineSeries<Contest, DateTime>> _generateLineSeries(
      List<Contest> graphData) {
    return [
      LineSeries<Contest, DateTime>(
        dataSource: graphData,
        xValueMapper: (Contest contest, _) => contest.time,
        yValueMapper: (Contest contest, _) => contest.nrating,
        // pointColorMapper: ,
        dataLabelSettings: DataLabelSettings(isVisible: false),
        markerSettings: MarkerSettings(
          height: 4,
          width: 4,
          // color: Colors.red,
          isVisible: true,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      child: Card(
        elevation: 8.0,
        child: Container(
          width: double.infinity,
          height: 300,
          child: FutureBuilder(
            future: graphData,
            builder: (context, snapshot) {
              List<Contest> graphData = snapshot.data;
              List<ChartSeries<Contest, DateTime>> lineSeries =
                  _generateLineSeries(graphData);
              double yStart = ((minRating - 100) / 100).floorToDouble() * 100;
              double yEnd = (maxRating / 100).ceilToDouble() * 100;
              if (snapshot.hasData) {
                return SfCartesianChart(
                  title: ChartTitle(
                      text: 'User Performance Chart',
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  // plotAreaBackgroundImage: Image.asset(),
                  // plotAreaBackgroundColor: Colors.red,
                  // backgroundColor: Colors.blue,
                  zoomPanBehavior: ZoomPanBehavior(
                    enableDoubleTapZooming: true,
                    enablePinching: true,
                    enablePanning: true,
                  ),
                  primaryXAxis: DateTimeAxis(
                    desiredIntervals: 3,
                    dateFormat: DateFormat.yMMM(),
                    intervalType: DateTimeIntervalType.months,
                  ),
                  primaryYAxis: CategoryAxis(
                    minimum: yStart,
                    maximum: yEnd,
                    interval: 100,
                  ),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(
                      enable: true,
                      builder: (dynamic data, dynamic point, dynamic series,
                          int pointIndex, int seriesIndex) {
                        Contest _temp = graphData[pointIndex];
                        int delta = _temp.nrating - _temp.orating;
                        String deltaText = delta >= 0 ? "+" : "";
                        deltaText += delta.toString();
                        return Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _temp.nrating.toString() + " ($deltaText)",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Rank : " + _temp.rank.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  // Text(
                                  //   _temp.contestname,
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  // zoomPanBehavior: ZoomPanBehavior(
                  //     enableDoubleTapZooming: true, enablePinching: true),
                  series: lineSeries,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error Occured"),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
