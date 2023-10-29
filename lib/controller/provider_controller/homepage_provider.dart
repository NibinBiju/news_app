// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/model/news_api_model.dart';

class HomePageProvider with ChangeNotifier {
  int indexvalue = 0;
  bool isLoad = false;
  var jsonData;
  NewsModel? model;

  void appbarIndex({int index = 0}) {
    indexvalue = index;
    notifyListeners();
  }

  Future<void> fetchData(String newsSerch) async {
    isLoad = true;

    var uri = Uri.parse(
        'https://newsapi.org/v2/everything?q=$newsSerch&apiKey=b719771d665245c9b1dc922eb15e9b65');

    var response = await http.get(uri);

    print(response.statusCode);
    print(response.body);
    print(model?.articles?[indexvalue].urlToImage);
    jsonData = jsonDecode(response.body);

    model = NewsModel.fromJson(jsonData);

    isLoad = false;
    notifyListeners();
  }
}
