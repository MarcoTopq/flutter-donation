import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donation/main.dart';

List<Gallerys> gallerysFromJson(String str) => List<Gallerys>.from(json.decode(str).map((x) => Gallerys.fromJson(x)));

String gallerysToJson(List<Gallerys> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Gallerys {
    int id;
    String title;
    String description;
    String image;
    String createdAt;
    String updatedAt;

    Gallerys({
        this.id,
        this.title,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
    });

    factory Gallerys.fromJson(Map<String, dynamic> json) => Gallerys(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class GallerysModel with ChangeNotifier {
  List<Gallerys> _listGallerys = [];
  List filteredGallerys = new List();
  List<Gallerys> get listGallerys {
    return _listGallerys;
  }

  Future<void> fetchDataGallerys() async {
    final response = await http.get(
        Uri.encodeFull(urls + '/gallerys/'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<Gallerys> newData = [];
      for (Map i in convertData) {
        newData.add(Gallerys.fromJson(i));
      }
      _listGallerys = newData;

      notifyListeners();
    }
  }
}