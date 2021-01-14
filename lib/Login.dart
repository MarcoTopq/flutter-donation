import 'dart:async';

import 'package:donation/Register.dart';
import 'package:flutter/material.dart';
import 'package:donation/main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _loginKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void dispose() {
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
        await http.post(Uri.decodeFull(urls + "/users/signin"),
            body: {
              "email": emailController.text,
              "password": passwordController.text,
            },
            headers: headers);
    return Future.value(hasil);
  }

  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width * 0.9;
    double a_height = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
        // backgroundColor: Colors.redAccent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
            //change your color here
          ),
          // centerTitle: true,
          title: Text(
            "Login",
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
                child: Text("Login ",
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
                key: _loginKey,
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
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
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
                                      hintText: "email",
                                      fillColor: Colors.red[900],
                                      hoverColor: Colors.red[900],
                                      focusColor: Colors.red[900],
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.0))),
                                ))),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
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
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RoundedLoadingButton(
                              width: 230,
                              child: Text(
                                "Login",
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
                                  if (_loginKey.currentState.validate()) {
                                    kirimdata().then((value) async {
                                      if (value.statusCode == 200) {
                                        final responseJson =
                                            json.decode(value.body);
                                        print(responseJson);
                                        _btnController.reset();
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
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
                                        prefs.setString('Role',
                                            responseJson['user']['role']);
                                        prefs.setString(
                                            'Sex', responseJson['user']['sex']);
                                        prefs.setString(
                                            'Job', responseJson['user']['job']);
                                        prefs.setString('domicile',
                                            responseJson['user']['Domicile']);
                                        print('Token  :' + prefs.get('Token'));
                                        print('Token  :' + prefs.get('Email'));

                                        setState(() {
                                          login = true;
                                          username = prefs.get('Username');
                                          email = prefs.get('Email');
                                          token = prefs.get('Token');
                                          role = prefs.get('Role');
                                        });

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      } else {
                                        Toast.show(
                                            "Harap isi semua kolom", context);
                                        _btnController.reset();
                                      }
                                    });
                                  }
                                },
                              ),
                            )),
                        InkWell(
                            onTap: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text("Create Account ?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.all(10))
                      ],
                    ),
                  ),
                )),
          ],
        )));
  }
}
