import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicatorProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void cicularIndicator(bool loading) {
    _isLoggedIn = loading;
    notifyListeners();
  }
}
class CircularIndicatorProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  void circularProgressIndicator(bool load) {
    _loading = load;
    notifyListeners();
  }
}
