
import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  int _num = 0;
  int get num => _num;
  setNum() {
    _num++;
    if (_num == 3) {
      _num = 0;
    }
    notifyListeners();
  }
}
