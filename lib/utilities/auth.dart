import 'user.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;

class Auth {
  Future<String> _getJson(String str) async {
    return await rootBundle.loadString(str);
  }

  Future<Map<String, dynamic>> _jsonAuth(String email, String password) async {
    Map<String, dynamic> data =
        jsonDecode(await _getJson('assets/json/login.json'));
    if (email == data['email'] && password == data['password']) {
      var user = jsonDecode(await _getJson('assets/json/user.json'));
      await User().writeUser(user);
      return user;
    }
    return {'id': '0'};
  }

  Future<String> signIn(String email, String password) async {
    var user = await _jsonAuth(email, password);
    return user['id'];
  }
}
