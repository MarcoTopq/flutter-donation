import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donation/main.dart';

List<Campaign> campaignFromJson(String str) => List<Campaign>.from(json.decode(str).map((x) => Campaign.fromJson(x)));

String campaignToJson(List<Campaign> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Campaign {
    int id;
    String fundraiser;
    String title;
    String email;
    String category;
    String description;
    String image;
    int currentDonation;
    int totalDonation;
    DateTime timeLimit;
    String createdAt;
    String updatedAt;

    Campaign({
        this.id,
        this.fundraiser,
        this.title,
        this.email,
        this.category,
        this.description,
        this.image,
        this.currentDonation,
        this.totalDonation,
        this.timeLimit,
        this.createdAt,
        this.updatedAt,
    });

    factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"],
        fundraiser: json["fundraiser"],
        title: json["title"],
        email: json["email"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        currentDonation: json["current_donation"],
        totalDonation: json["total_donation"],
        timeLimit: json["time_limit"] == null ? null : DateTime.parse(json["time_limit"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fundraiser": fundraiser,
        "title": title,
        "email": email,
        "category": category,
        "description": description,
        "image": image,
        "current_donation": currentDonation,
        "total_donation": totalDonation,
        "time_limit": timeLimit == null ? null : timeLimit.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
    };
}

class CampaignModel with ChangeNotifier {
  List<Campaign> _listCampaign = [];
  List filteredCampaign = new List();
  List<Campaign> get listCampaign {
    return _listCampaign;
  }

  Future<void> fetchDataCampaign() async {
    final response = await http.get(
        Uri.encodeFull(urls + '/campaigns/'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<Campaign> newData = [];

      // var data = Map<String, dynamic>.from(convertData);
      //   newData.add(CampaignClass.fromJson(data));

      for (Map i in convertData) {
        newData.add(Campaign.fromJson(i));
      }
      _listCampaign = newData;

      notifyListeners();
    }
  }
}