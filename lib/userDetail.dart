import 'dart:convert';

import 'package:donation/userList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:donation/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class UserDetail extends StatefulWidget {
  final String id;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String role;

  UserDetail({
    Key key,
    this.id,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.role,
  }) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Future<void> _refreshData(BuildContext context) async {
  //   await Provider.of<UserDetailDetailModel>(context, listen: false)
  //       .fetchDataUserDetailDetail();
  // }

  @override
  void initState() {
    usernameController.text = widget.username;
    emailController.text = widget.email;
    phoneController.text = widget.phone;
    passwordController.text = widget.password;
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    // _refreshData(context);
  }

  Future<http.Response> kirimdata() async {
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/users/edit/" + widget.id),
            body: {
              "username": usernameController.text,
              "email": emailController.text,
              "phone": phoneController.text,
              "password": passwordController.text,
              "role": widget.role
            },
            headers: headers);
    return Future.value(hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'UserDetail',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        // backgroundColor: Colors.grey[850],
        body:
            // RefreshIndicator(
            //     onRefresh: () => _refreshData(context),
            //     child: FutureBuilder(
            //         future: Provider.of<UserDetailDetailModel>(context, listen: false)
            //             .fetchDataUserDetailDetail(),
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
            //             return Consumer<UserDetailDetailModel>(
            //                 builder: (ctx, _listUserDetailDetail, child) =>
            Center(
                child: ListView(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20)),
            Column(
              children: <Widget>[
                // Container(
                // width: 100,
                // height: 100,
                // child: ClipRRect(
                // borderRadius:
                //     BorderRadius.circular(0.0),
                // child: Icon(Icons.person)
                // Image.asset(
                //   'assets/pertamina.png',
                //   fit: BoxFit.cover,
                //   // width: 100,
                //   height: 100,
                // )
                //       ),
                // ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.red[900],
                    size: 50,
                  ),
                  title: Text(
                    'Username',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: TextField(
                    obscureText: false,
                    controller: usernameController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.red[900],
                    size: 50,
                  ),
                  title: Text(
                    'Email',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: TextField(
                      obscureText: false,
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.red[900],
                    size: 50,
                  ),
                  title: Text(
                    'Phone',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: TextField(
                    obscureText: false,
                    controller: phoneController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                ListTile(
                  leading: Icon(
                    Icons.vpn_key,
                    color: Colors.red[900],
                    size: 50,
                  ),
                  title: Text(
                    'Password',
                    style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: TextField(
                    obscureText: true,
                    controller: passwordController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(10)),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.red[900],
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          // if (_formKey.currentState.validate()) {
                          kirimdata().then((value) async {
                            if (value.statusCode == 200) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              // prefs.remove('Id');
                              // prefs.remove('Username');
                              // prefs.get('Phone');
                              // prefs.get('Email');
                              // prefs.get('Role');
                              // prefs.get('Password');
                              final responseJson = json.decode(value.body);
                              // prefs.setString(
                              //     'Username', responseJson['username']);
                              // prefs.setString('Email', responseJson['email']);
                              // prefs.setString('Phone', responseJson['phone']);
                              // prefs.setString(
                              //     'Password', responseJson['password']);
                              // prefs.setString('Role', responseJson['role']);
                              Toast.show("Perubahan Berhasil", context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserDetail(
                                          id: responseJson['id'].toString(),
                                          username: responseJson['username'],
                                          phone: responseJson['phone'],
                                          email: responseJson['email'],
                                          role: responseJson['role'],
                                          password: responseJson['password'])));
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Users()));
                            }
                          });
                          // }
                        },
                        child: Text("Edit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
              ],
            )
          ],
        )));
    //   }
    // }
    // )));
  }
}
