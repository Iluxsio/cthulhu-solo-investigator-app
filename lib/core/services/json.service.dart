import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class JSONService {
  Future<List<String>> getStringList(String url) async {
    String jsonString = await rootBundle.loadString(url);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<dynamic> jsonList = jsonMap["data"];
    List<String> response = jsonList.map((dynamic element) => element.toString()).toList();
    return response;
  }

  Future<List<dynamic>> getList(String url) async {
    String jsonString = await rootBundle.loadString(url);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<dynamic> jsonList = jsonMap["data"];
    List<String> response = jsonList.map((dynamic element) => element.toString()).toList();
    return response;
  }

  Future<List<dynamic>> getObjectList(String url) async {
    String jsonString = await rootBundle.loadString(url);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<dynamic> jsonList = jsonMap["data"] as List<dynamic>;
    return jsonList;
  }
}
