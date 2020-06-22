import 'package:donation/CampaignDetail.dart';
import 'package:donation/Profile.dart';
import 'package:donation/main.dart';
import 'package:donation/models/campaignModel.dart';
import 'package:donation/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class CampaignList extends StatefulWidget {
  @override
  _CampaignListState createState() => _CampaignListState();
}

class _CampaignListState extends State<CampaignList> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<CampaignModel>(context, listen: false)
        .fetchDataCampaign();
  }

  Future<http.Response> hapusdata(String id) async {
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil = await http
        .delete(Uri.decodeFull(urls + "/campaigns/" + id), headers: headers);
    return Future.value(hasil);
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
                                title: Text("Campaign List"),
                              ),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.all(10),
                                    child: Card(
                                        child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          // leading: Icon(
                                          //   Icons.folder,
                                          //   color: Colors.red[900],
                                          //   size: 30,
                                          // ),
                                          trailing: new Container(
                                            child: new IconButton(
                                              icon: new Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => CampaignDetail(
                                                            id: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            title: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .title,
                                                            description: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .description,
                                                            email: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .email,
                                                            fundraiser: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .fundraiser,
                                                            image: _listCampaign
                                                                .listCampaign[
                                                                    index]
                                                                .image,
                                                            category: _listCampaign
                                                                .listCampaign[index]
                                                                .category,
                                                            currentDonation: _listCampaign.listCampaign[index].currentDonation,
                                                            timeLimit: _listCampaign.listCampaign[index].timeLimit.toString(),
                                                            totalDonation: _listCampaign.listCampaign[index].totalDonation.toString())));
                                              },
                                            ),
                                            // margin: EdgeInsets.only(top: 25.0),
                                          ),
                                          // title: Text(
                                          //   'Judul',
                                          //   style: new TextStyle(
                                          //     fontSize: 15.0,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          title: Text(
                                            _listCampaign
                                                .listCampaign[index].title,
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                            // leading: Icon(
                                            //   Icons.mail,
                                            //   color: Colors.red[900],
                                            //   size: 30,
                                            // ),
                                            trailing: new Container(
                                              child: new IconButton(
                                                icon: new Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () async {
                                                  await hapusdata(_listCampaign
                                                      .listCampaign[index].id
                                                      .toString());
                                                  Toast.show(
                                                      "Campaign berhasil di hapus",
                                                      context);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CampaignList()));
                                                },
                                              ),
                                              // margin: EdgeInsets.only(top: 25.0),
                                            ),
                                            leading: Container(
                                              child: Image.network(
                                                  // 'assets/galang.png',
                                                  urls +
                                                      "/images/" +
                                                      _listCampaign
                                                          .listCampaign[index]
                                                          .image),
                                            )
                                            // subtitle: Text(
                                            //   _listCampaign
                                            //       .listCampaign[index].email,
                                            //   style: new TextStyle(
                                            //     fontSize: 15.0,
                                            //     color: Colors.black,
                                            //   ),
                                            // ),
                                            ),
                                        Padding(padding: EdgeInsets.all(10))
                                      ],
                                    )));
                              },
                                      childCount:
                                          _listCampaign.listCampaign.length)),
                            ])));
                  }
                })));
  }
}
