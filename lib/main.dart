import 'package:donation/AllCampaign.dart';
import 'package:donation/AllGallery.dart';
import 'package:donation/CampaignList.dart';
import 'package:donation/DetailCampaign.dart';
import 'package:donation/DetailGallery.dart';
import 'package:donation/GalleryList.dart';
import 'package:donation/Login.dart';
import 'package:donation/Profile.dart';
import 'package:donation/createCampaign.dart';
import 'package:donation/createDonation.dart';
import 'package:donation/createGallery.dart';
import 'package:donation/models/HomeModel.dart';
import 'package:donation/models/campaignModel.dart';
import 'package:donation/models/galleryModel.dart';
import 'package:donation/models/usersModel.dart';
import 'package:donation/userList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var urls = 'https://donatation-fkti.herokuapp.com';
// var urls = 'http://192.168.1.6:3000';

var email;
var username;
var token;
var role;
bool login;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: HomeModel(),
          ),
          ChangeNotifierProvider.value(
            value: CampaignModel(),
          ),
          ChangeNotifierProvider.value(
            value: GallerysModel(),
          ),
          ChangeNotifierProvider.value(
            value: UserListModel(),
          ),
        ],
        child: MaterialApp(
            title: 'Donation',
            theme: ThemeData(
                primaryColor: Colors.red[900],
                primarySwatch: MaterialColor(Colors.grey.shade200.value, {
                  50: Colors.grey.shade50,
                  100: Colors.grey.shade100,
                  200: Colors.grey.shade200,
                  300: Colors.grey.shade300,
                  400: Colors.grey.shade400,
                  500: Colors.grey.shade500,
                  600: Colors.grey.shade600,
                  700: Colors.grey.shade700,
                  800: Colors.grey.shade800,
                  900: Colors.grey.shade900
                }),
                fontFamily: 'OpenSans',
                backgroundColor: Color.fromRGBO(
                  212,
                  175,
                  55,
                  2,
                )),
            home: Homepage()));
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<HomeModel>(context, listen: false).fetchDataCampaign();
  }

  Future<void> _getToken() async {
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = prefs.get('Email');
      print(email);
      username = prefs.get('Username');
      token = prefs.get('Token');
      role = prefs.get('Role');
      print(role);
      if (email == null) {
        login = false;
      } else {
        login = true;
      }
    });
  }

  @override
  void initState() {
    _getToken();
    // this._getToken();
    super.initState();
    _getToken();

    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => _refreshData(context),
          child: FutureBuilder(
              future: Provider.of<HomeModel>(context, listen: false)
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
                  return Consumer<HomeModel>(
                      builder: (ctx, _listCampaign, child) => Center(
                              child: CustomScrollView(slivers: <Widget>[
                            SliverAppBar(
                              stretch: false,
                              pinned: true,
                              floating: true,
                              iconTheme: IconThemeData(
                                color: Colors.white, //change your color here
                              ),
                              title: Text("Donation"),
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                              return Container(
                                child: InkWell(
                                    onTap: () {
                                      login == false
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()))
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateCampaign()));
                                    },
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
                                                    child: Image.asset(
                                                      'assets/galang.png',
                                                      width: 400,
                                                      // height: 300,
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
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5)),
                                                            Text(
                                                                'Ayo Galang Dana',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        900],
                                                                    fontSize:
                                                                        15)),
                                                            Text(
                                                                'untuk bantu sesama',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
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
                                                        Container(
                                                            width: 120,
                                                            height: 50,
                                                            child: Card(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Colors
                                                                            .red[
                                                                        900],
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                child: Center(
                                                                    child: Text(
                                                                        'Galang Dana',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red[900],
                                                                            fontSize: 15))))),
                                                      ],
                                                      // )
                                                    )),
                                              ],
                                            )))),
                              );
                            }, childCount: 1
                                    // _listCampaign.listCampaign.length
                                    )),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Gallery",
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontSize: 20)),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllGallerys(),
                                              ));
                                        },
                                        child: Text("View All",
                                            style: TextStyle(
                                                color: Colors.red[900],
                                                fontSize: 10)),
                                      )
                                    ],
                                  ));
                            }, childCount: 1)),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          return Container(
                                              padding: EdgeInsets.all(5),
                                              width: 300,
                                              height: 400,
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailGallery(
                                                            id: _listCampaign
                                                                .listGallerys[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            title: _listCampaign
                                                                .listGallerys[
                                                                    index]
                                                                .title,
                                                            description:
                                                                _listCampaign
                                                                    .listGallerys[
                                                                        index]
                                                                    .description,
                                                            image: _listCampaign
                                                                .listGallerys[
                                                                    index]
                                                                .image,
                                                          ),
                                                        ));
                                                  },
                                                  child: Image.network(
                                                    urls +
                                                        '/images/' +
                                                        _listCampaign
                                                            .listGallerys[index]
                                                            .image
                                                            .toString(),
                                                    fit: BoxFit.cover,
                                                  )));
                                        },
                                      ));
                                },
                                childCount: 1,
                              ),
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Penggalangan Dana",
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontSize: 20)),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AllCampaign(),
                                              ));
                                        },
                                        child: Text("View All",
                                            style: TextStyle(
                                                color: Colors.red[900],
                                                fontSize: 10)),
                                      )
                                    ],
                                  ));
                            }, childCount: 1)),
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
                                                            .listCampaign[index]
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
                                                                      .all(5)),
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
                                                                      .red[900],
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
                                                                      .red[900],
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
                                                                              .red[
                                                                          900],
                                                                      width:
                                                                          2.0,
                                                                    ),
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  child: Center(
                                                                      child: Text(
                                                                          'Donasi',
                                                                          style: TextStyle(
                                                                              color: Colors.red[900],
                                                                              fontSize: 20)))))),
                                                    ],
                                                    // )
                                                  )),
                                            ],
                                          ))));
                            }, childCount: _listCampaign.listCampaign.length)),
                          ])));
                }
              })),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .grey[850], //This will change the drawer background to blue.
            //other styles
          ),
          child: Drawer(
            elevation: 12,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child:
                      // Text("data"),
                      Image.asset(
                    'assets/galang.png',
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                  ),
                ),
                email == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(top: 2),
                        decoration: new BoxDecoration(
                            color: Colors.black12,
                            border: new Border(
                                bottom:
                                    new BorderSide(color: Colors.grey[850]))),
                        child: ListTile(
                          leading:
                              Icon(Icons.perm_identity, color: Colors.red[900]),
                          title: Text('Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                        id: prefs.get('Id'),
                                        username: prefs.get('Username'),
                                        phone: prefs.get('Phone'),
                                        job: prefs.get('Job'),
                                        sex: prefs.get('Sex'),
                                        domicile: prefs.get('Domicile'),
                                        email: prefs.get('Email'),
                                        role: prefs.get('Role'),
                                        password: prefs.get('Password'))));
                          },
                        )),
                Container(
                    padding: EdgeInsets.only(top: 2),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        border: new Border(
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading:
                          Icon(Icons.insert_drive_file, color: Colors.red[900]),
                      title: Text('All Campaign',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllCampaign()));
                      },
                    )),
                Container(
                    padding: EdgeInsets.only(top: 2),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        border: new Border(
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading: Icon(Icons.image, color: Colors.red[900]),
                      title: Text('Gallery',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllGallerys()));
                      },
                    )),
                email == null
                    ? Container()
                    : role != 'admin'
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(top: 2),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                border: new Border(
                                    bottom: new BorderSide(
                                        color: Colors.grey[850]))),
                            child: ListTile(
                              leading:
                                  Icon(Icons.people, color: Colors.red[900]),
                              title: Text('List Users',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Users()));
                              },
                            )),
                email == null
                    ? Container()
                    : role != 'admin'
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(top: 2),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                border: new Border(
                                    bottom: new BorderSide(
                                        color: Colors.grey[850]))),
                            child: ListTile(
                              leading: Icon(Icons.photo_album,
                                  color: Colors.red[900]),

                              title: Text('Create Gallery',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              // isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateGallery()));
                              },
                            )),
                email == null
                    ? Container()
                    : role != 'admin'
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(top: 2),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                border: new Border(
                                    bottom: new BorderSide(
                                        color: Colors.grey[850]))),
                            child: ListTile(
                              leading: Icon(Icons.photo_library,
                                  color: Colors.red[900]),

                              title: Text('Manage Gallery',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              // isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GallerysList()));
                              },
                            )),
                email == null
                    ? Container()
                    : role != 'admin'
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(top: 2),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                border: new Border(
                                    bottom: new BorderSide(
                                        color: Colors.grey[850]))),
                            child: ListTile(
                              leading:
                                  Icon(Icons.folder, color: Colors.red[900]),

                              title: Text('Manage Campaign',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              // isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CampaignList()));
                              },
                            )),
                Container(
                    padding: EdgeInsets.only(top: 2),
                    decoration: new BoxDecoration(
                        color: Colors.black12,
                        border: new Border(
                            bottom: new BorderSide(color: Colors.grey[850]))),
                    child: ListTile(
                      leading: Icon(Icons.input, color: Colors.yellowAccent),
                      title: email == null
                          ? Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                          : Text('Logout',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                      onTap: email == null
                          ? () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }
                          : () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              await prefs.remove('Email');
                              await prefs.remove('Token');
                              await prefs.remove('Role');
                              await prefs.remove('username');
                              await prefs.remove('password');
                              setState(() {
                                login = false;
                                email = null;
                                token = null;
                                role = null;
                              });

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            },
                    )),
                Padding(padding: EdgeInsets.only(top: 300)),
                // Container(
                //     height: 100,
                //     padding: EdgeInsets.only(top: 10),
                //     decoration: new BoxDecoration(
                //         color: Colors.black12,
                //         border: new Border(
                //             bottom: new BorderSide(
                //                 color: Colors.grey[850]))),
                //     child: Center(
                //         child: ListTile(
                //       // leading: Icon(Icons.assessment, color: Colors.red[900]),
                //       title: Text('Build by Topq',
                //           style: TextStyle(
                //               color: Colors.red[900],
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold)),
                //       subtitle: Text('Topq@gmail.com',
                //           style: TextStyle(
                //             color: Colors.white,
                //             // fontSize: 15,
                //             // fontWeight: FontWeight.bold
                //           )),
                //       // isThreeLine: true,
                //       onTap: () {
                //         Navigator.of(context).pushNamed(
                //           '/mangas',
                //         );
                //       },
                //     ))),
              ],
            ),
          )),
    );
  }
}
