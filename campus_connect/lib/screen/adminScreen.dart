import 'dart:convert';
import 'dart:math';

import 'package:campus_connect/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class adminScreen extends StatefulWidget {
  static const routeName = '/adminScreen';

  adminScreen({super.key});

  @override
  State<adminScreen> createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {
  TextEditingController _controller = TextEditingController();

  void _handleSubmit() async {
    try {
      var url = Uri.https(
          "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
          '/Buses.json');
      var response = await http.get(url);
      var resData = jsonDecode(response.body);
      url = Uri.https(
          "campusconnect-401818-default-rtdb.asia-southeast1.firebasedatabase.app",
          '/.json');
      resData.add([_controller.text, "${DateTime.now()}"]);
      print(resData);
      var newresponse = {'Buses': resData};
      response = await http.patch(url, body: jsonEncode(newresponse));
      print(jsonDecode(response.body));
      _showSuccessDialog();
    } catch (err) {
      _showErrorDialog(err.toString());
    }
    // var requestData =
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bus Added Successfully"),
        // content: Text("You can login now"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Okay!"))
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Oops!! An Error Occured"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Okay!"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
      drawer: mainDrawer(title: 'Admin'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                labelText: 'Enter Bus announcement',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Brodcast'),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Create Bus',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
