import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OnlineData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response = await get(Uri.parse(
        'https://dl.dropboxusercontent.com/s/tifvv3vx91wfnmg/stories.json?dl=0'));

    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
      } catch (e) {
        _error = true;
        _errorMessage = (e).toString();
        _map = {};
      }
    } else {
      _error = true;
      _errorMessage = 'Connection to page failed!';
      _map = {};
    }
    notifyListeners();
  }

  void initialValues() {
    Map<String, dynamic> _map = {};
    bool _error = false;
    String _errorMessage = '';
    notifyListeners();
  }
}