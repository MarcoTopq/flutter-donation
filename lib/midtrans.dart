import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Midtrans extends StatefulWidget {
  final String url;
  Midtrans({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  _MidtransState createState() => _MidtransState();
}

class _MidtransState extends State<Midtrans> {
  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Pay-Pay",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        backgroundColor: Colors.white,
        body: WebviewScaffold(
          url: widget.url,
          withLocalUrl: true,
          // javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (WebViewController webViewController) {
          //   _controller.complete(webViewController);
          // }
        ));
  }
}
