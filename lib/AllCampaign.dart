import 'package:donation/models/campaignModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation/DetailCampaign.dart';
import 'package:donation/main.dart';

class AllCampaign extends StatefulWidget {
  @override
  _AllCampaignState createState() => _AllCampaignState();
}

class _AllCampaignState extends State<AllCampaign> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<CampaignModel>(context, listen: false)
        .fetchDataCampaign();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<CampaignModel>(context, listen: false)
                    .fetchDataCampaign(),
                builder: (ctx, snapshop) {
                  if (snapshop.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshop.error != null) {
                      return Center(
                        child: Text("Error Loading Data"),
                      );
                    }
                    return Consumer<CampaignModel>(
                        builder: (ctx, _listCampaign, child) => Center(
                                child: CustomScrollView(slivers: <Widget>[
                              SliverAppBar(
                                iconTheme: IconThemeData(
                                  color: Colors.white, //change your color here
                                ),
                                title: Text("All Campaign"),
                              ),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                return Container(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: 200,
                                        // height: 400,
                                        // color: Colors.red,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              // side: BorderSide(
                                              //   color: Colors.white,
                                              //   width: 5.0,
                                              // ),
                                            ),
                                            color: Colors.white,
                                            child: Column(
                                              // fit: StackFit.loose,
                                              children: <Widget>[
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                      urls +
                                                          '/images/' +
                                                          _listCampaign
                                                              .listCampaign[
                                                                  index]
                                                              .image
                                                              .toString(),
                                                      width: 400,
                                                      height: 200,
                                                      fit: BoxFit.cover,
                                                    )),
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    // width: 100,
                                                    // height: 150,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5)),
                                                        Expanded(
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                _listCampaign
                                                                    .listCampaign[
                                                                        index]
                                                                    .title
                                                                    .toString(),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15)),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                            Text(
                                                                'Donasi Terkumpul',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12)),
                                                            Text(
                                                                _listCampaign
                                                                    .listCampaign[
                                                                        index]
                                                                    .currentDonation
                                                                    .toString()
                                                                    .replaceAllMapped(
                                                                        new RegExp(
                                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                        (Match m) =>
                                                                            '${m[1]},'),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        900],
                                                                    fontSize:
                                                                        15)),
                                                            Text('dari',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12)),
                                                            Text(
                                                                _listCampaign
                                                                    .listCampaign[
                                                                        index]
                                                                    .totalDonation
                                                                    .toString()
                                                                    .replaceAllMapped(
                                                                        new RegExp(
                                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                        (Match m) =>
                                                                            '${m[1]},'),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        900],
                                                                    fontSize:
                                                                        15)),
                                                          ],
                                                        )),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20)),
                                                        // LinearProgressIndicator(
                                                        //   value: 80.0,
                                                        // ),
                                                        InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DetailCampaign(
                                                                      id: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      fundraiser: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .fundraiser,
                                                                      title: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .title,
                                                                      email: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .email,
                                                                      category: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .category,
                                                                      description: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .description,
                                                                      image: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .image,
                                                                      totalDonation: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .totalDonation
                                                                          .toString(),
                                                                      currentDonation: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .currentDonation
                                                                          .toString(),
                                                                      timeLimit: _listCampaign
                                                                          .listCampaign[
                                                                              index]
                                                                          .timeLimit
                                                                          .toString(),
                                                                    ),
                                                                  ));
                                                            },
                                                            child: Container(
                                                                width: 100,
                                                                height: 50,
                                                                child: Card(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      side:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .red[900],
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    child: Center(
                                                                        child: Text(
                                                                            'Donasi',
                                                                            style:
                                                                                TextStyle(color: Colors.red[900], fontSize: 20)))))),
                                                      ],
                                                      // )
                                                    )),
                                              ],
                                            ))));
                              },
                                      childCount:
                                          _listCampaign.listCampaign.length)),
                            ])));
                  }
                })));
  }
}
