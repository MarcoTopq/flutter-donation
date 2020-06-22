import 'dart:convert';
import 'package:donation/main.dart';
import 'package:donation/createGallery.dart';
import 'package:donation/createDonation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailGallery extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String image;

  DetailGallery({
    Key key,
    this.id,
    this.title,
    this.description,
    this.image,
  }) : super(key: key);

  @override
  _DetailGalleryState createState() => _DetailGalleryState();
}

class _DetailGalleryState extends State<DetailGallery>
    with SingleTickerProviderStateMixin {
  String galleryId;
  // Future<void> _refreshData(BuildContext context) async {
  //   await Provider.of<DetailGalleryModel>(context, listen: false)
  //       .fetchDataDetailGallery(widget.id);
  // }

  @override
  void initState() {
    // this.getdata();
    super.initState();
    // this.kirimdata();

    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Penukaran Gallery " + title + " telah Berhasi !!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGallery()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // var Colors.red[900] = Color.fromRGBO(
  //   212,
  //   175,
  //   55,
  //   2,
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'Detail Gallery',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        backgroundColor: Colors.white,
        body:
            // RefreshIndicator(
            //     onRefresh: () => _refreshData(context),
            //     child: FutureBuilder(
            //         future: Provider.of<DetailGalleryModel>(context, listen: false)
            //             .fetchDataDetailGallery(widget.id),
            //         builder: (ctx, snapshop) {
            //           if (snapshop.connectionState == ConnectionState.waiting) {
            //             return Center(
            //               child: CircularProgressIndicator(),
            //             );
            //           } else {
            //             if (snapshop.error != null) {
            //               return Center(
            //                 child: Text("Error Loading Data"),
            //               );
            //             }
            //             return Consumer<DetailGalleryModel>(
            //                 builder: (ctx, _listGalleryDetail, child) =>
            Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                    child: Stack(children: <Widget>[
          ListView(
            children: <Widget>[
              // Card(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10),
              //   side: BorderSide(
              //     color: Colors.red[900],
              //     width: 2.0,
              //   ),
              // ),
              // color: Colors.black,
              // child:
              Column(
                children: <Widget>[
                  Image.network(
                    urls + '/images/' + widget.image,
                    height: 300,
                    // width: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              // Expanded(
              //     flex: 1,
              //     child:
              SingleChildScrollView(
                  // scrollDirection: Axis.vertical,
                  child: Container(
                      // height: 1300,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          // Text(
                          //   'KETERANGAN',
                          //   style: new TextStyle(
                          //     fontSize: 16.0,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                            widget.title,
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Deskripsi',
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                            widget.description,
                            style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ))),
            ],
          ),
        ]))));
  }
}
//                 )));
//   }
// }
