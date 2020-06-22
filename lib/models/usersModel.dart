import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donation/main.dart';
import 'package:flutter/foundation.dart';

List<UserList> userListFromJson(String str) => List<UserList>.from(json.decode(str).map((x) => UserList.fromJson(x)));

String userListToJson(List<UserList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserList {
    int id;
    String username;
    String phone;
    String email;
    String password;
    String role;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic isDeleted;

    UserList({
        this.id,
        this.username,
        this.phone,
        this.email,
        this.password,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phone": phone,
        "email": email,
        "password": password,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "isDeleted": isDeleted,
    };
}

class UserListModel with ChangeNotifier {
  List<UserList> _listUserList = [];
  List filteredUserList = new List();
  List<UserList> get listUserList {
    return _listUserList;
  }

  Future<void> fetchDataUserList() async {
    final response = await http.get(
        Uri.encodeFull(urls + '/users/'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<UserList> newData = [];

      // var data = Map<String, dynamic>.from(convertData);
      //   newData.add(UserListClass.fromJson(data));

      for (Map i in convertData) {
        newData.add(UserList.fromJson(i));
      }
      _listUserList = newData;

      notifyListeners();
    }
  }
}