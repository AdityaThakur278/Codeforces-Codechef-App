import 'package:flutter/material.dart';
import 'UserInfoCF.dart';
import 'GraphInfoCF.dart';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class CFfriendProfile extends StatefulWidget {
  String handle;
  CFfriendProfile(this.handle);

  @override
  _CFfriendProfileState createState() => _CFfriendProfileState();
}

class _CFfriendProfileState extends State<CFfriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        title: Text('Codeforces Friend'),
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
          children: [
            UserInfoCF(widget.handle),
            graph(widget.handle),
          ],
        ),
      ),
    );
  }
}
