import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const color1 = const Color(0xff1da777);
const color2 = const Color(0xff4167b2);
const color3 = const Color(0xff4a54a7);
const color4 = const Color(0xff478cf6);

class ViewUrlCf extends StatefulWidget {
  String Url;
  ViewUrlCf(this.Url);
  @override
  _ViewUrlCfState createState() => _ViewUrlCfState();
}

class _ViewUrlCfState extends State<ViewUrlCf> {
  double progress = 0;
  InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        title: Text('Problem Statement'),
        // automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: InAppWebView(
                      initialUrl: widget.Url,
                      initialHeaders: {},
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            debuggingEnabled: true,
                            preferredContentMode:
                                UserPreferredContentMode.DESKTOP),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        webView = controller;
                      },
                      onLoadStart:
                          (InAppWebViewController controller, String url) {},
                      onLoadStop: (InAppWebViewController controller,
                          String url) async {},
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                    ),
                  ),
                  Align(
                      alignment: Alignment.center, child: _buildProgressBar()),
                ],
              ),
            )
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     InAppWebView(
      //       initialUrl: widget.Url,
      //       initialHeaders: {},
      //       initialOptions: InAppWebViewGroupOptions(
      //         crossPlatform: InAppWebViewOptions(
      //             debuggingEnabled: true,
      //             preferredContentMode: UserPreferredContentMode.DESKTOP),
      //       ),
      //       onWebViewCreated: (InAppWebViewController controller) {
      //         webView = controller;
      //       },
      //       onLoadStart: (InAppWebViewController controller, String url) {},
      //       onLoadStop:
      //           (InAppWebViewController controller, String url) async {},
      //       onProgressChanged:
      //           (InAppWebViewController controller, int progress) {
      //         setState(() {
      //           this.progress = progress / 100;
      //         });
      //       },
      //     //     ),
      //         Align(alignment: Alignment.center, child: _buildProgressBar()),
      //       ],
      //     ),
    );
  }

  Widget _buildProgressBar() {
    if (progress != 1.0) {
      return CircularProgressIndicator();
// You can use LinearProgressIndicator also
//      return LinearProgressIndicator(
//        value: progress,
//        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
//        backgroundColor: Colors.blue,
//      );
    }
    return Container();
  }
}
