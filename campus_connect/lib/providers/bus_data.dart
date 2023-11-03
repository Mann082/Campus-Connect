import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Buses with ChangeNotifier {
  List<String> busList = [];
  LatLng? currLocation;
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

  Future<Map<String, double>> getBusLocation() async {
    final url = Uri.https(
        "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/live/$selectedBus.json');
    try {
      var response = await http.get(url);
      var resData = jsonDecode(response.body);
      Map<String, double> mp = {
        'latitude': resData['latitude'].toDouble(),
        'longitude': resData['longitude'].toDouble()
      };
      return mp;
    } catch (err) {
      print(err);
      return {}; // Return an empty map or handle the error as needed
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
