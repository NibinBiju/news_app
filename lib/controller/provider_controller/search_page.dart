import 'package:flutter/material.dart';
import 'package:weather_app/model/news_api_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class SearchPageNotifier with ChangeNotifier {
  bool isLoad = false;
  var jsonData;
  NewsModel? model;

  Future<void> searchfetchData(String newsSerch) async {
    isLoad = true;
    notifyListeners();
    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$newsSerch&apiKey=b719771d665245c9b1dc922eb15e9b65');

    var response = await http.get(uri);
    print(response.statusCode);
    print(response.body);

    jsonData = jsonDecode(response.body);

    model = NewsModel.fromJson(jsonData);

    isLoad = false;
    notifyListeners();
  }
}
