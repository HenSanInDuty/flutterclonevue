import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  var homePath = false;
  var title = "";
  void changeHomePathToLogin() {
    homePath = false;
    notifyListeners();
  }

  void changeHomePathToHome() {
    homePath = true;
    notifyListeners();
  }

  void changeTitle(text) {
    title = text;
    notifyListeners();
  }
}
