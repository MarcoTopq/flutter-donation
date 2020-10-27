import 'dart:convert';
import 'package:donation/Login.dart';
import 'package:donation/main.dart';
import 'package:donation/createCampaign.dart';
import 'package:donation/createDonation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DetailCampaign extends StatefulWidget {
  final String id;
  final String fundraiser;
  final String title;
  final String email;
  final String category;
  final String description;
  final String image;
  final String totalDonation;
  final String timeLimit;
  final String currentDonation;

  DetailCampaign({
    Key key,
    this.id,
    this.fundraiser,
    this.title,
    this.email,
    this.category,
    this.description,
    this.image,
    this.totalDonation,
    this.timeLimit,
    this.currentDonation,
  }) : super(key: key);

  @override
  _DetailCampaignState createState() => _DetailCampaignState();
}

class _DetailCampaignState extends State<DetailCampaign>
    with SingleTickerProviderStateMixin {
  String campaignId;
  // Future<void> _refreshData(BuildContext context) async {
  //   await Provider.of<DetailCampaignModel>(context, listen: false)
  //       .fetchDataDetailCampaign(widget.id);
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
          title: new Text("Penukaran Campaign " + title + " telah Berhasi !!!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreateCampaign()),
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
            'Detail Campaign',
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
            //         future: Provider.of<DetailCampaignModel>(context, listen: false)
            //             .fetchDataDetailCampaign(widget.id),
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
            //             return Consumer<DetailCampaignModel>(
            //                 builder: (ctx, _listCampaignDetail, child) =>
            Center(
                child: Container(
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
              Padding(padding: EdgeInsets.all(10)),
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
                      height: 1300,
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
          Positioned(
              bottom: -5.0,
              left: -10.0,
              child: Container(
                  width: MediaQuery.of(context).size.width / 0.5,
                  height: MediaQuery.of(context).size.height / 8,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey[600],
                        width: 2.0,
                      ),
                    ),
                    color: Colors.grey[600],
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(10)),
                          Container(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Terkumpul',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10)),
                                  Text(
                                      widget.currentDonation
                                          .toString()
                                          .replaceAllMapped(
                                              new RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]},'),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  Text('dari',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10)),
                                  Expanded(
                                      child: Text(
                                    widget.totalDonation
                                        .toString()
                                        .replaceAllMapped(
                                            new RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (Match m) => '${m[1]},'),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ))
                                ],
                              )),
                          Padding(padding: EdgeInsets.all(5)),
                        ]),
                  ))),
          Positioned(
              bottom: 20.0,
              right: 20.0,
              child: Container(
                  width: 100,
                  height: MediaQuery.of(context).size.height / 15,
                  child: InkWell(
                      onTap: () async {
                        email == null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateDonation(
                                          id: widget.id,
                                          currentDonation:
                                              widget.currentDonation,
                                        )));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.red[900],
                            width: 2.0,
                          ),
                        ),
                        color: Colors.red[900],
                        child: Center(
                            child: Text('Donasi',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ))))
        ]))));
  }
}
//                 )));
//   }
// }
