import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeController();

  bool isLoading = false;
  bool responseOK = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> sendImageToApi() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 5));
    responseOK = true;
    notifyListeners();
    setLoading(false);
  }
}
