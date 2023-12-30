import 'package:flutter/material.dart';

class StringProvider with ChangeNotifier {
  String _email = '';
  String _name = '';
  String _admin = '';
  String get admin => _admin;
  String get email => _email;
  String get name => _name;
  void setEmail(String str) {
    _email = str;
    notifyListeners();
  }

  void setAdmin(String str) {
    _admin = str;
    notifyListeners();
  }

  void setName(String str) {
    _name = str;
    notifyListeners();
  }
}
