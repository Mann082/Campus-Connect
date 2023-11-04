import 'dart:async';
import 'dart:convert';
import 'package:campus_connect/providers/bus_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class driverControlsScreen extends StatefulWidget {
  static const routeName = "/driverControlScreen";
  const driverControlsScreen({super.key});

  @override
  State<driverControlsScreen> createState() => _driverControlsScreenState();
}

class _driverControlsScreenState extends State<driverControlsScreen> {
  var _currentPosition;
  var _pushLocation = false;
  Timer? _locationTimer;

  void _startTimer() {
    _locationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_pushLocation) {
        _getCurrentLocation();
      }
    });
  }

  void _stopTimer() {
    _locationTimer?.cancel();
  }

  void _getCurrentLocation() async {
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position!;
    });

    var selectedbus = Provider.of<Buses>(context, listen: false).selectedBus;
    final url = Uri.https(
        "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
        '/live/$selectedbus.json');
    var requestData = {
      "latitude": _currentPosition.latitude,
      "longitude": _currentPosition.longitude
    };
    var response = await http.patch(url, body: jsonEncode(requestData));

    print(
        'Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Bus'),
        elevation: 10,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              "Push Location",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            LiteRollingSwitch(
              //initial value
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              value: _pushLocation,
              textOn: 'Active',
              textOff: 'Inactive',
              colorOn: Colors.greenAccent,
              colorOff: Colors.redAccent,
              iconOn: Icons.lightbulb_outline,
              iconOff: Icons.power_settings_new,
              textSize: 15.0,
              onChanged: (bool state) {
                setState(() {
                  _pushLocation = state;
                });
                if (state) {
                  _startTimer();
                } else {
                  _stopTimer(); // Stop location updates when switch is off
                }
                print('Current State of SWITCH IS: $state');
              },
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
