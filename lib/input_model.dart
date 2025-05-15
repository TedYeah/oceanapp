import 'package:flutter/material.dart';

class InputModel extends ChangeNotifier {
  String inputText = '';

  void updateText(String text) {
    inputText = text;
    notifyListeners();
  }
}
