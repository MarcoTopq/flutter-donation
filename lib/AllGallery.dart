import 'package:donation/models/galleryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donation/DetailGallery.dart';
import 'package:donation/main.dart';

class AllGallerys extends StatefulWidget {
  @override
  _AllGallerysState createState() => _AllGallerysState();
}

class _AllGallerysState extends State<AllGallerys> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<GallerysModel>(context, listen: false)
        .fetchDataGallerys();
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
                                title: Text("All Gallerys"),
                              ),
                              SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            1.5),
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(10),
                                         child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailGallery(
                                                            id: _listGallerys
                                                                .listGallerys[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            title: _listGallerys
                                                                .listGallerys[
                                                                    index]
                                                                .title,
                                                            description:
                                                                _listGallerys
                                                                    .listGallerys[
                                                                        index]
                                                                    .description,
                                                            image: _listGallerys
                                                                .listGallerys[
                                                                    index]
                                                                .image,
                                                          ),
                                                        ));
                                                  },
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
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  urls +
                                                      '/images/' +
                                                      _listGallerys
                                                          .listGallerys[index]
                                                          .image
                                                          .toString(),
                                                  width: 400,
                                                  // height: 200,
                                                  fit: BoxFit.cover,
                                                )))));
                                  },
                                      childCount:
                                          _listGallerys.listGallerys.length)),
                            ])));
                  }
                })));
  }
}
