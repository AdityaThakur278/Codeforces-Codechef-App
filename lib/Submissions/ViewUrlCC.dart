import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:codeforces_codechef/colors.dart';

class ViewUrlCC extends StatefulWidget {
  String Url;
  ViewUrlCC(this.Url);
  @override
  _ViewUrlCCState createState() => _ViewUrlCCState();
}

class _ViewUrlCCState extends State<ViewUrlCC> {
  double progress = 0;
  InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5,
        title: Text('Codechef Submission'),
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
                                UserPreferredContentMode.MOBILE),
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
