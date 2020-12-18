import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:donation/main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  final String id;
  final String username;
  final String phone;
  final String email;
  final String password;
  final String role;
  final String job;
  final String sex;
  final String domicile;

  Profile({
    Key key,
    this.id,
    this.username,
    this.phone,
    this.email,
    this.job,
    this.sex,
    this.domicile,
    this.password,
    this.role,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController jobController = new TextEditingController();
  TextEditingController sexController = new TextEditingController();
  TextEditingController domicileController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  var datas = [];
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    jobController.dispose();
    sexController.dispose();
    domicileController.dispose();

    super.dispose();
  }

  // Future<void> _refreshData(BuildContext context) async {
  //   await Provider.of<ProfileDetailModel>(context, listen: false)
  //       .fetchDataProfileDetail();
  // }

  @override
  void initState() {
    // usernameController.text = widget.username;
    // emailController.text = widget.email;
    // phoneController.text = widget.phone;
    // passwordController.text = widget.password;
    // jobController.text = widget.job;
    // sexController.text = widget.sex;
    // domicileController.text = widget.domicile;
    data();
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
              "sex": sexController.text,
              "domicile": domicileController.text,
              "job": jobController.text,
              "role": widget.role
            },
            headers: headers);
    return Future.value(hasil);
  }

  Future<http.Response> data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil =
        await http.get(Uri.decodeFull(urls + '/users/' + prefs.get('Id')),
            // body: {
            //   "user_id": prefs.get('Id'),
            // },
            headers: headers);
    print(hasil.body);
    var data = json.decode(hasil.body);
    setState(() {
      datas.add(data);
      print(datas);
      usernameController.text = datas[0]['username'].toString();
      emailController.text = datas[0]['email'].toString();
      phoneController.text = datas[0]['phone'].toString();
      passwordController.text = datas[0]['password'].toString();
      jobController.text = datas[0]['job'].toString();
      sexController.text = datas[0]['sex'].toString();
      domicileController.text = datas[0]['domicile'].toString();
    });
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
            'Profile',
            style: new TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        // backgroundColor: Colors.grey[850],
        body: datas == null
            ? Container()
            :
            // RefreshIndicator(
            //     onRefresh: () => _refreshData(context),
            //     child: FutureBuilder(
            //         future: Provider.of<ProfileDetailModel>(context, listen: false)
            //             .fetchDataProfileDetail(),
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
            //             return Consumer<ProfileDetailModel>(
            //                 builder: (ctx, _listProfileDetail, child) =>
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
                          Icons.portrait,
                          color: Colors.red[900],
                          size: 50,
                        ),
                        title: Text(
                          'Jenis Kelamin',
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: TextField(
                          obscureText: false,
                          controller: sexController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20)),
                      ListTile(
                        leading: Icon(
                          Icons.business_center,
                          color: Colors.red[900],
                          size: 50,
                        ),
                        title: Text(
                          'Pekerjaan',
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: TextField(
                          obscureText: false,
                          controller: jobController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20)),
                      ListTile(
                        leading: Icon(
                          Icons.person_pin_circle,
                          color: Colors.red[900],
                          size: 50,
                        ),
                        title: Text(
                          'Domisili',
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: TextField(
                          obscureText: false,
                          controller: domicileController,
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
                          padding: const EdgeInsets.all(20.0),
                          child: RoundedLoadingButton(
                            width: 230,
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            color: Colors.red[900],
                            controller: _btnController,
                            onPressed: () => Timer(
                              Duration(seconds: 3),
                              () async {
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
                                    _btnController.reset();
                                    final responseJson =
                                        json.decode(value.body);
                                    prefs.setString(
                                        'Username', responseJson['username']);
                                    prefs.setString(
                                        'Email', responseJson['email']);
                                    prefs.setString(
                                        'Phone', responseJson['phone']);
                                    prefs.setString(
                                        'Password', responseJson['password']);
                                    prefs.setString(
                                        'Role', responseJson['role']);
                                    Toast.show("Perubahan Berhasil", context);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile(
                                                id: prefs.get('Id'),
                                                username: prefs.get('Username'),
                                                phone: prefs.get('Phone'),
                                                email: prefs.get('Email'),
                                                role: prefs.get('Role'),
                                                password:
                                                    prefs.get('Password'))));
                                  } else {
                                    Toast.show(
                                        "Harap isi semua kolom", context);
                                    _btnController.reset();
                                  }
                                });
                                // }
                              },
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
