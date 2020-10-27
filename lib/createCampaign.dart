import 'dart:io' show File;
import 'package:donation/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:toast/toast.dart';

class CreateCampaign extends StatefulWidget {
  @override
  _CreateCampaignState createState() => _CreateCampaignState();
}

class _CreateCampaignState extends State<CreateCampaign>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  int place;
  List drop = [];
  String _mySelection;
  String _mySelection2;
  String _mySelection3;
  int posisi;
  String _myMonth;
  String month;
  Future myFuture;
  var i;
  var res;
  var file;
  String values;
  List myObject = [];
  List tepra = [
    [
      'Bencana Alam',
    ],
    [
      'Kesehatan',
    ],
    [
      'Pendidikan',
    ],
  ];

  List tahun = [
    '2018',
    '2019',
    '2020',
  ];

  List anggaran = [
    'MURNI',
    'PERUBAHAN',
  ];
  bool editable = true;
  File files;
  DateTime date;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();
  TextEditingController fundraiserController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  TextEditingController timelimitController = new TextEditingController();
  TextEditingController totaldonationController = new TextEditingController();

  FocusNode myFocusNode;

  @override
  void dispose() {
    fundraiserController.dispose();
    emailController.dispose();
    titleController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    timelimitController.dispose();
    totaldonationController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.text = email;
    fundraiserController.text = username;
    super.initState();
    myFocusNode = FocusNode();
    // this.kirimdata();
  }

  Future<http.Response> kirimdata(File file) async {
    // var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    // var length = await file.length();

    var mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split('/');

    var request =
        http.MultipartRequest("POST", Uri.parse(urls + "/campaigns/image"));
    // var pic = http.MultipartFile("photos", stream, length,
    //     filename: basename(file.path));
    final files = await http.MultipartFile.fromPath('photos', file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    request.files.add(files);
    var response = await request.send();
    print(response.statusCode);
    // print(response.stream.toList());

    await response.stream
        .transform(utf8.decoder)
        .listen((value) => res = json.decode(value)
            // setState(() {
            //   res = value.toString();
            // });
            // print(value);
            );

    Map<String, String> headers = {
      // "Content-Type": "multipart/form-data",
      'Content-Type': 'application/x-www-form-urlencoded',
      "Accept": "application/JSON",
    };
    http.Response hasil =
        await http.post(Uri.decodeFull(urls + "/campaigns/create"),
            body: {
              "fundraiser": fundraiserController.text,
              "email": emailController.text,
              "title": titleController.text,
              "category": _mySelection,
              "description": descriptionController.text,
              "image": res['image'],
              "current_donation": '0',
              "total_donation": totaldonationController.text,
              "time_limit": timelimitController.text,
            },
            headers: headers);
    return Future.value(hasil);
  }

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
            "Create Campaign",
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
                child: Text("Create Campaign ",
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(40),
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.white,
                                    child: MaterialButton(
                                      focusNode: myFocusNode,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      onPressed: () async {
                                        files = await FilePicker.getFile();
                                        // files = await FilePicker.getMultiFile();
                                        setState(() {
                                          file = 1;
                                        });
                                      },
                                      child: Text("Tambah Gambar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              file == null
                                  ? Text('')
                                  : Center(
                                      child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Image.file(files),
                                      // fit: BoxFit.cover,
                                      height: 200.0,
                                      alignment: Alignment.topCenter,
                                      width: 200,
                                    )),
                            ]),
                        Container(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Nama Penggalang',
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
                                    controller: fundraiserController,
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
                                    hintText: "Email",
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
                            'Judul',
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
                                    controller: titleController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 15.0, 20.0, 15.0),
                                      hintText: "Judul",
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
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Kategori',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                      hint: Text('Kategori'),
                                      items: tepra?.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item[0].toString()),
                                              value: item[0].toString(),
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
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            'Jumlah Penggalangan',
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
                                  controller: totaldonationController,
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
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            'Deskripsi',
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
                                    maxLines: 4,
                                    controller: descriptionController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          0.0, 15.0, 20.0, 15.0),
                                      hintText: "Deskripsi",
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
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Tanggal Berakhir',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: DateTimeField(
                                      format: format,
                                      controller: timelimitController,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            lastDate: DateTime(2100));
                                        if (date != null) {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                currentValue ?? DateTime.now()),
                                          );
                                          return DateTimeField.combine(
                                              date, time);
                                        } else {
                                          return currentValue;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Harap di isi';
                                        }
                                      })),
                            ],
                          ),
                        ),
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
                                  if (_formKey.currentState.validate()) {
                                    kirimdata(files).then((value) async {
                                      if (value.statusCode == 200) {
                                        final responseJson =
                                            json.decode(value.body);
                                        // print(responseJson['user']);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Homepage()));
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateCampaign()));
                                      }
                                    });
                                  }
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
