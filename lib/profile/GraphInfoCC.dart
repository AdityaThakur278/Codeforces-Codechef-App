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
  int rating;
  DateTime time;
  // String color;
  Contest(
    this.contestname,
    this.rank,
    this.rating,
    this.time,
    // this.color,
  );
}

class graph1 extends StatefulWidget {
  @override
  _graph1State createState() => _graph1State();
}

class _graph1State extends State<graph1> {
  Future<List<Contest>> graphData;
  int minRating = 5000;
  int maxRating = 0;
  @override
  void initState() {
    graphData = _getUserContestInfo();
    super.initState();
  }

  Future<List<Contest>> _getUserContestInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String handle = prefs.getString('codechef_handle');

    final response = await http.get(
        'https://competitive-coding-api.herokuapp.com/api/codechef/' + handle);
    try {
      if (response.statusCode == 200) {
        // print("Enter");
        var jsonData = jsonDecode(response.body);
        List<Contest> tempList = new List<Contest>();
        // print(jsonData['contest_ratings']);
        for (var contests in jsonData['contest_ratings']) {
          // print(contests['code']);
          minRating = min(int.parse(contests['rating']), minRating);
          maxRating = max(int.parse(contests['rating']), maxRating);
          // print(contests['code']);
          // print(int.parse(contests['rank']));
          // print(int.parse(contests['rating']));
          // print(DateTime.parse(contests['end_date']));
          Contest temp = Contest(
            contests['code'],
            int.parse(contests['rank']),
            int.parse(contests['rating']),
            DateTime.parse(contests['end_date']),
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

  // DateTime startTime(timestamp) {
  //   var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  //   return date;
  // }

  List<LineSeries<Contest, DateTime>> _generateLineSeries(
      List<Contest> graphData) {
    return [
      LineSeries<Contest, DateTime>(
        dataSource: graphData,
        xValueMapper: (Contest contest, _) => contest.time,
        yValueMapper: (Contest contest, _) => contest.rating,
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
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                                    "Rank : " + _temp.rank.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    _temp.contestname,
                                    style: TextStyle(color: Colors.white),
                                  ),
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
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
