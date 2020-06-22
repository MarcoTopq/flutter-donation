import 'package:donation/Profile.dart';
import 'package:donation/main.dart';
import 'package:donation/models/usersModel.dart';
import 'package:donation/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<UserListModel>(context, listen: false)
        .fetchDataUserList();
  }

  Future<http.Response> hapusdata(String id) async {
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil = await http
        .delete(Uri.decodeFull(urls + "/users/" + id), headers: headers);
    return Future.value(hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () => _refreshData(context),
            child: FutureBuilder(
                future: Provider.of<UserListModel>(context, listen: false)
                    .fetchDataUserList(),
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
                    return Consumer<UserListModel>(
                        builder: (ctx, _listUserList, child) => Center(
                                child: CustomScrollView(slivers: <Widget>[
                              SliverAppBar(
                                iconTheme: IconThemeData(
                                  color: Colors.white, //change your color here
                                ),
                                title: Text("User List"),
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
                                          leading: Icon(
                                            Icons.person,
                                            color: Colors.red[900],
                                            size: 30,
                                          ),
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
                                                        builder: (context) => UserDetail(
                                                            id: _listUserList
                                                                .listUserList[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                            username:
                                                                _listUserList
                                                                    .listUserList[
                                                                        index]
                                                                    .username,
                                                            phone: _listUserList
                                                                .listUserList[
                                                                    index]
                                                                .phone,
                                                            email: _listUserList
                                                                .listUserList[
                                                                    index]
                                                                .email,
                                                            role: _listUserList
                                                                .listUserList[
                                                                    index]
                                                                .role,
                                                            password: _listUserList
                                                                .listUserList[
                                                                    index]
                                                                .password)));
                                              },
                                            ),
                                            // margin: EdgeInsets.only(top: 25.0),
                                          ),
                                          title: Text(
                                            'Username',
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _listUserList
                                                .listUserList[index].username,
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.mail,
                                            color: Colors.red[900],
                                            size: 30,
                                          ),
                                          trailing: new Container(
                                            child: new IconButton(
                                              icon: new Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () async {
                                                await hapusdata(_listUserList
                                                    .listUserList[index].id
                                                    .toString());
                                                Toast.show("User berhasil di hapus", context);
                                                 Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Users()));
                                              },
                                            ),
                                            // margin: EdgeInsets.only(top: 25.0),
                                          ),
                                          title: Text(
                                            'Email',
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _listUserList
                                                .listUserList[index].email,
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.phone,
                                            color: Colors.red[900],
                                            size: 30,
                                          ),
                                          title: Text(
                                            'Phone',
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _listUserList
                                                .listUserList[index].phone,
                                            style: new TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )));
                              },
                                      childCount:
                                          _listUserList.listUserList.length)),
                            ])));
                  }
                })));
  }
}
