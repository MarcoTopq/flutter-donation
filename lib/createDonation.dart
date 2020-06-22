import 'dart:convert';
import 'dart:io' show File;
import 'package:donation/main.dart';
import 'package:donation/midtrans.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateDonation extends StatefulWidget {
  final String id;
  final String currentDonation;
  CreateDonation({
    Key key,
    this.id,
    this.currentDonation,
  }) : super(key: key);
  @override
  _CreateDonationState createState() => _CreateDonationState();
}

class _CreateDonationState extends State<CreateDonation>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool editable = true;
  String total;
  DateTime date;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController donationController = new TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // this.kirimdata();
  }

  Future<http.Response> kirimdata() async {
    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };

    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/donations/create"),
            body: {
              "name": nameController.text,
              "email": emailController.text,
              "campaign_id": widget.id,
              "donation": donationController.text,
              "totaldonation": total,
            },
            headers: headers);
    return Future.value(hasil);
  }

  List<File> files;
  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width * 0.9;
    double a_height = MediaQuery.of(context).size.width * 0.7;
    var gold = Color.fromRGBO(
      212,
      175,
      55,
      2,
    );
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Create Donation",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: Colors.red[900],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("Create Donation ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text("",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      // fontWeight: FontWeight.bold,
                      // fontFamily: Utils.ubuntuRegularFont),
                    ))),
            Form(
                key: _formKey,
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
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            'Nama',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Container(
                                color: Colors.white,
                                child: TextFormField(
                                    autofocus: false,
                                    obscureText: false,
                                    controller: nameController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 15.0, 20.0, 15.0),
                                      hintText: "Nama",
                                      fillColor: Colors.red[900],
                                      hoverColor: Colors.red[900],
                                      focusColor: Colors.red[900],
                                      // border: OutlineInputBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(2.0))
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Harap di isi';
                                      }
                                    }))),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Container(
                              color: Colors.white,
                              child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  obscureText: false,
                                  controller: emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.red[900],
                                    hoverColor: Colors.red[900],
                                    focusColor: Colors.red[900],
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0.0, 15.0, 20.0, 15.0),
                                    hintText: "Name@mail.com",
                                    // border: OutlineInputBorder(
                                    // borderRadius:
                                    //     BorderRadius.circular(2.0))
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Harap di isi';
                                    }
                                  }),
                            )),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            'Jumlah Donasi',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Container(
                              color: Colors.white,
                              child: TextFormField(
                                  autofocus: false,
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  controller: donationController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.red[900],
                                    hoverColor: Colors.red[900],
                                    focusColor: Colors.red[900],
                                    contentPadding: EdgeInsets.fromLTRB(
                                        0.0, 15.0, 20.0, 15.0),
                                    hintText: "0",
                                    // border: OutlineInputBorder(
                                    // borderRadius:
                                    //     BorderRadius.circular(2.0))
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Harap di isi';
                                    }
                                  }),
                            )),
                        Padding(padding: EdgeInsets.all(10)),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.red[900],
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () async {
                                  var jum = int.parse(widget.currentDonation) +
                                      int.parse(donationController.text);

                                  total = jum.toString();

                                  // if (_formKey.currentState.validate()) {
                                  kirimdata().then((value) async {
                                    if (value.statusCode == 200) {
                                      final responseJson =
                                          json.decode(value.body);
                                      print(responseJson[
                                          'transactionRedirectUrl']);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Midtrans(
                                                  url: responseJson[
                                                      'transactionRedirectUrl'])));
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateDonation()));
                                    }
                                  });
                                  // }
                                },
                                child: Text("Buat Donasi",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
