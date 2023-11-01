import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Buses with ChangeNotifier {
  List<String> busList = [];

  Future<void> fetchBuses() async {
    final url = Uri.https(
        "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
        'routes.json');
    final data = {
      "live": [123.12, 345.23],
      "polyline": [
        [123.12, 345.23],
        [123.12, 345.23],
        [123.12, 345.23],
        [123.12, 345.23],
        [123.12, 345.23]
      ]
    };
    try {
      var response = await http.get(url);
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  Future<void> getBusRouteByNumber(String num) async {
    final url = Uri.https(
        "https://campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app/");
  }
}
