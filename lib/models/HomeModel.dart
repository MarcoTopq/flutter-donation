import 'package:donation/models/campaignModel.dart';
import 'package:donation/models/galleryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:donation/main.dart';

class HomeModel with ChangeNotifier {
  List<Campaign> _listCampaign = [];
  List filteredCampaign = new List();
  List<Campaign> get listCampaign {
    return _listCampaign;
  }

  List<Gallerys> _listGallerys = [];
  List filteredGallerys = new List();
  List<Gallerys> get listGallerys {
    return _listGallerys;
  }

  Future<void> fetchDataCampaign() async {
    final response = await http.get(Uri.encodeFull(urls + '/campaigns/'),
        headers: {"Accept": "application/JSON"});
    if (response.statusCode == 200) {
      var convertData = json.decode(response.body);
      List<Campaign> newData = [];

      for (Map i in convertData) {
        newData.add(Campaign.fromJson(i));
      }
      _listCampaign = newData;

      notifyListeners();
    }

    final response2 = await http.get(Uri.encodeFull(urls + '/gallerys/'),
        headers: {"Accept": "application/JSON"});
    if (response2.statusCode == 200) {
      var convertData2 = json.decode(response2.body);
      List<Gallerys> newData2 = [];
      for (Map i in convertData2) {
        newData2.add(Gallerys.fromJson(i));
      }
      _listGallerys = newData2;

      notifyListeners();
    }
  }
}
