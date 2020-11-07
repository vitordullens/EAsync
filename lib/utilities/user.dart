import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:path_provider/path_provider.dart';

class User {
  static User _instance;
  factory User() => _instance ??= new User._();
  User._();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.json');
  }

  Future<File> writeUser(Map<String, dynamic> user) async {
    final file = await _localFile;
    var json = jsonEncode(user);
    return file.writeAsString('$json');
  }

  Future<Map<String, dynamic>> readUser() async {
    try {
      final file = await _localFile;
      Map<String, dynamic> user = jsonDecode(await file.readAsString());
      return user;
    } catch (e) {
      return null;
    }
  }
}
