import 'package:flutter/cupertino.dart';

class HomePageProvider with ChangeNotifier {
  int indexvalue = 0;

  void appbarIndex({int index = 0}) {
    indexvalue = index;
    notifyListeners();
  }
}
