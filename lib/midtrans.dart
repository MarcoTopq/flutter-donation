import 'dart:async';

import 'package:donation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:toast/toast.dart';

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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            Toast.show("Donasi Berhasil", context);

            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homepage()));
          },
          icon: Icon(Icons.add),
          label: Text('Halaman Utama'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: WebviewScaffold(
          url: widget.url,
          // withLocalUrl: true,
          // javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (WebViewController webViewController) {
          //   _controller.complete(webViewController);
          // }
        ));
  }
}
