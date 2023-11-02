import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Buses with ChangeNotifier {
  List<String> busList = [];
  var selectedBus;

  Future<void> fetchBuses() async {
    final url = Uri.https(
        "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/Buses.json');
    try {
      var response = await http.get(url);
      print(response.body);
      var resData = jsonDecode(response.body);
      busList = [];
      for (var data in resData) {
        busList.add(data[0]);
      }
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void setBus(String bus) {
    selectedBus = bus;
    notifyListeners();
  }

  Future<void> getBusRouteByNumber(String num) async {
    final url = Uri.https(
        "https://campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app/");
  }
}
