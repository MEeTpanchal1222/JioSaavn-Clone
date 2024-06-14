import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroProvider extends ChangeNotifier {
  bool isClicked = false;

  Future<void> setvalues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('viewed', true);
    notifyListeners();
  }

  Future<void> getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    isClicked = preferences.getBool('viewed') ?? false;
    notifyListeners();
  }

  IntroProvider() {
    getValues();
  }
}