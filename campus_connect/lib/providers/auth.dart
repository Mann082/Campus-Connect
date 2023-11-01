import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token = "";
  DateTime _expiryDate = DateTime.now();
  String _userId = "";
  Timer? _authTimer = null;

  bool get isAuth {
    return (token != null) && (token != "");
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String keyword) async {
    var url = Uri.https(
      "identitytoolkit.googleapis.com",
      "/v1/accounts:$keyword",
      {
        'key': 'AIzaSyDK0iYa8qYvb0ACZ8dsji9EM_X-dypBleo'
      }, // Replace 'YOUR_API_KEY' with your actual API key
    );
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null)
        throw HttpException(responseData['error']['message']);
      print(response.body);
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
      _autoLogout();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setStringList(
          'userData', [_token, _userId, _expiryDate.toIso8601String()]);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('userData')) return false;
    if (pref.getStringList('userData') == null) {
      print('No user data found.');
      return false;
    }
    List<String>? extractedData = pref.getStringList('userData');
    if (extractedData == null || extractedData.length < 3) {
      print('Invalid user data format.');
      return false;
    }

    final expiryDate = DateTime.tryParse(extractedData[2]);
    if (expiryDate == null || expiryDate.isBefore(DateTime.now())) {
      print('Invalid expiry date or already expired.');
      return false;
    }

    _token = extractedData[0];
    _userId = extractedData[1];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
    return true;
  }

  // Future<bool> tryAutoLogin() async {
  //   final pref = await SharedPreferences.getInstance();
  //   // if (pref.containsKey('userData')) {
  //   //   return false;
  //   // }
  //   print(pref.getString('userData'));
  //   print(pref.getString('userData'));
  //   if (pref.getString('userData') == null) return false;
  //   List<String>? extractedData = pref.getStringList('userData');
  //   if (extractedData == null) return false;
  //   // final Map<String, Object> extractedData =
  //   //     json.decode(pref.getString('userData') as String);
  //   final expiryDate = DateTime.parse(extractedData[2]);
  //   if (expiryDate.isBefore(DateTime.now())) return false;
  //   _token = extractedData[0].toString();
  //   _userId = extractedData[1].toString();
  //   _expiryDate = expiryDate;
  //   notifyListeners();
  //   _autoLogout();
  //   return true;
  // }

  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiryDate = DateTime.now();
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
