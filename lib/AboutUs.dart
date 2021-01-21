import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codeforces_codechef/main.dart';
import 'package:codeforces_codechef/colors.dart';

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5,
        title: Text('About Developers'),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
                width: 150,
              ),
              CircleAvatar(
                backgroundColor: color5,
                radius: 52,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/DP.jpg'),
                ),
              ),
              Text('Aditya Thakur',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    color: color5,
                    fontWeight: FontWeight.bold,
                  )),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: color5,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text('adityathakur2708@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                ),
              ),
              CircleAvatar(
                backgroundColor: color5,
                radius: 52.0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/sameer.jpeg'),
                ),
              ),
              Text('Sameer Raturi',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    color: color5,
                    fontWeight: FontWeight.bold,
                  )),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: color5,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text('sameerraturi2001@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                ),
              ),
              CircleAvatar(
                backgroundColor: color5,
                radius: 52.0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/prof1.jpg'),
                ),
              ),
              Text('Utkarsh Pandya',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 30,
                    color: color5,
                    fontWeight: FontWeight.bold,
                  )),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                color: color5,
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text('utkarshpandya64@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 16,
                      )),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                ),
              ),
            ],
          )),
    );
  }
}
