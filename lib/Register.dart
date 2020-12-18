import 'dart:async';

import 'package:flutter/material.dart';
import 'package:donation/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donation/Login.dart';
import 'package:toast/toast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  final _registerKey = GlobalKey<FormState>();
  String _mySelection;
  String _mySelection2;
  String _mySelection3;
  int posisi;

  List domisili = ['Samarinda', 'Luar Samarinda'];

  List sex = [
    'Pria',
    'Wanita',
  ];

  List job = ['Sipil', 'Swasta', 'Pelajar', 'Lainnya'];
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/users/signup"),
            body: {
              "username": usernameController.text,
              "email": emailController.text,
              "phone": phoneController.text,
              "password": passwordController.text,
              "sex": _mySelection,
              "domicile": _mySelection2,
              "job": _mySelection3,
              "role": "user"
            },
            headers: headers);
    return Future.value(hasil);
  }

  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width * 0.9;
    double a_height = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          // centerTitle: true,
          title: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              // fontWeight: FontWeight.bold,
              // fontFamily: Utils.ubuntuRegularFont),
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        // backgroundColor: Colors.grey[850],
        body: Center(
            child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("Register ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text("For more access",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Form(
                key: _registerKey,
                child: Container(
                  // width: a_width,
                  // height: a_height,
                  padding: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.red[900],
                        width: 2.0,
                      ),
                    ),
                    color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Username',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  child: TextField(
                                    obscureText: false,
                                    controller: usernameController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Username",
                                        fillColor: Colors.red[900],
                                        hoverColor: Colors.red[900],
                                        focusColor: Colors.red[900],
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  child: TextField(
                                    obscureText: false,
                                    controller: emailController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Email",
                                        fillColor: Colors.red[900],
                                        hoverColor: Colors.red[900],
                                        focusColor: Colors.red[900],
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Phone',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    controller: phoneController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Phone",
                                        fillColor: Colors.red[900],
                                        hoverColor: Colors.red[900],
                                        focusColor: Colors.red[900],
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  child: TextField(
                                    obscureText: true,
                                    controller: passwordController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                        fillColor: Colors.red[900],
                                        hoverColor: Colors.red[900],
                                        focusColor: Colors.red[900],
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Password",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0))),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Jenis Kelamin',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                  child: DropdownButtonFormField<String>(
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      iconEnabledColor: Colors.red[900],
                                      onChanged: (newVal) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          _mySelection = newVal;
                                          // print('url :' + url);

                                          print('posisi' + posisi.toString());
                                        });
                                      },
                                      isExpanded: true,
                                      isDense: true,
                                      value: _mySelection,
                                      hint: Text('Jenis Kelamin'),
                                      items: sex?.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item.toString()),
                                              value: item.toString(),
                                            );
                                          })?.toList() ??
                                          [],
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Harap di pilih';
                                        }
                                      }))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Domisili',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                  child: DropdownButtonFormField<String>(
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      iconEnabledColor: Colors.red[900],
                                      onChanged: (newVal) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          _mySelection2 = newVal;
                                          // print('url :' + url);

                                          print('posisi' + posisi.toString());
                                        });
                                      },
                                      isExpanded: true,
                                      isDense: true,
                                      value: _mySelection2,
                                      hint: Text('Domisili'),
                                      items: domisili?.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item.toString()),
                                              value: item.toString(),
                                            );
                                          })?.toList() ??
                                          [],
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Harap di pilih';
                                        }
                                      }))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Pekerjaan',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                  child: DropdownButtonFormField<String>(
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      iconEnabledColor: Colors.red[900],
                                      onChanged: (newVal) {
                                        setState(() {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          _mySelection3 = newVal;
                                          // print('url :' + url);

                                          print('posisi' + posisi.toString());
                                        });
                                      },
                                      isExpanded: true,
                                      isDense: true,
                                      value: _mySelection3,
                                      hint: Text('Pekerjaan'),
                                      items: job?.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item.toString()),
                                              value: item.toString(),
                                            );
                                          })?.toList() ??
                                          [],
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Harap di pilih';
                                        }
                                      }))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RoundedLoadingButton(
                            width: 230,
                            child: Text(
                              "Register",
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
                                if (_registerKey.currentState.validate()) {
                                  kirimdata().then((value) async {
                                    print(value.statusCode);
                                    if (value.statusCode == 200) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                      final responseJson =
                                          json.decode(value.body);
                                      print(responseJson['username']);

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      prefs.setString(
                                          'Token', responseJson['token']);
                                      print(responseJson['user']);
                                      prefs.setString(
                                          'Id',
                                          responseJson['user']['id']
                                              .toString());
                                      prefs.setString('Username',
                                          responseJson['user']['username']);
                                      prefs.setString('Email',
                                          responseJson['user']['email']);
                                      prefs.setString('Phone',
                                          responseJson['user']['phone']);
                                      prefs.setString('Password',
                                          responseJson['user']['password']);
                                      prefs.setString(
                                          'Role', responseJson['user']['role']);

                                      print('Token  :' + prefs.get('Token'));
                                      print('Token  :' + prefs.get('Email'));

                                      setState(() {
                                        login = true;
                                        email = prefs.get('Email');
                                        token = prefs.get('Token');
                                        role = prefs.get('Role');
                                      });
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register()));
                                    }
                                  });
                                } else {
                                  Toast.show("Harap isi semua kolom", context);
                                  _btnController.reset();
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        )));
  }
}
