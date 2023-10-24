import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier {
  int indexvalue = 0;
  int bottomIndex = 0;

  void appbarIndex({int index = 0}) {
    indexvalue = index;
    notifyListeners();
  }

  void bottomnaviIndex(int value) {
    bottomIndex = value;
    notifyListeners();
  }
}
