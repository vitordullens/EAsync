import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class Auth {
  bool signedIn = false;

  Future<String> _getJson(String str) async {
    return await rootBundle.loadString(str);
  }

  Future<Map<String, dynamic>> _jsonAuth(String email, String password) async {
    Map<String, dynamic> data =
        jsonDecode(await _getJson('assets/json/login.json'));
    if (email == data['email'] && password == data['password']) {
      return jsonDecode(await _getJson('assets/json/user.json'));
    }
    // return {'id': 0};
  }

  Future<String> signIn(String email, String password) async {
    var user = await _jsonAuth(email, password);
    signedIn = true;
    return user['id'];
  }
}
