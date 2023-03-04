import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xml2json/xml2json.dart';

class OnlineData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';
  final Xml2Json xml2Json = Xml2Json();

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response = await get(
        Uri.parse('https://feeds.feedburner.com/ndtvnews-top-stories'));

    if (response.statusCode == 200) {
      try {
        xml2Json.parse(response.body);
        var jsonString = xml2Json.toParker();
        _map = jsonDecode(jsonString);
        _error = false;
        // print(_map);
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


// getJsonFromXMLUrl(String url) async {
//   final Xml2Json xml2Json = Xml2Json();

//   try {
//     var response = await http.get(var response = await http.get('https://feeds.feedburner.com/ndtvnews-top-stories'););
//     xml2Json.parse(response.body);

//     var jsonString = xml2Json.toParker();
//     return jsonDecode(jsonString);
//   } catch (e) {
//     print(e);
//   }
// }