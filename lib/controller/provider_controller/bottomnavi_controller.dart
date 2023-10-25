import 'package:flutter/cupertino.dart';

class BottomNavi with ChangeNotifier {
  int bottomIndex = 0;

  void bottomnaviIndex(int value) {
    bottomIndex = value;
    notifyListeners();
  }
}
