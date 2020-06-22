// import 'package:donation/GallerysDetail.dart';
import 'package:donation/GalleryDetail.dart';
import 'package:donation/Profile.dart';
import 'package:donation/main.dart';
import 'package:donation/models/galleryModel.dart';
import 'package:donation/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class GallerysList extends StatefulWidget {
  @override
  _GallerysListState createState() => _GallerysListState();
}

class _GallerysListState extends State<GallerysList> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<GallerysModel>(context, listen: false)
        .fetchDataGallerys();
  }

  Future<http.Response> hapusdata(String id) async {
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil = await http
        .delete(Uri.decodeFull(urls + "/Gallerys/" + id), headers: headers);
    return Future.value(hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<GallerysModel>(context, listen: false)
                    .fetchDataGallerys(),
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
                    return Consumer<GallerysModel>(
                        builder: (ctx, _listGallerys, child) => Center(
                                child: CustomScrollView(slivers: <Widget>[
                              SliverAppBar(
                                iconTheme: IconThemeData(
                                  color: Colors.white, //change your color here
                                ),
                                title: Text("Gallery List"),
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
                                                        builder: (context) =>
                                                            GalleryDetail(
                                                              id: _listGallerys
                                                                  .listGallerys[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              title: _listGallerys
                                                                  .listGallerys[
                                                                      index]
                                                                  .title,
                                                              image: _listGallerys
                                                                  .listGallerys[
                                                                      index]
                                                                  .image,
                                                              description:
                                                                  _listGallerys
                                                                      .listGallerys[
                                                                          index]
                                                                      .description,
                                                            )));
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
                                            _listGallerys
                                                .listGallerys[index].title,
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
                                                  await hapusdata(_listGallerys
                                                      .listGallerys[index].id
                                                      .toString());
                                                  Toast.show(
                                                      "Gallerys berhasil dihapus",
                                                      context);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GallerysList()));
                                                },
                                              ),
                                              // margin: EdgeInsets.only(top: 25.0),
                                            ),
                                            leading: Container(
                                              child: Image.network(
                                                  // 'assets/galang.png',
                                                  urls +
                                                      "/images/" +
                                                      _listGallerys
                                                          .listGallerys[index]
                                                          .image),
                                            )
                                            // subtitle: Text(
                                            //   _listGallerys
                                            //       .listGallerys[index].email,
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
                                          _listGallerys.listGallerys.length)),
                            ])));
                  }
                })));
  }
}
