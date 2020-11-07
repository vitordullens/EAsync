import 'dart:io';
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

  Future<File> writeUser(var user) async {
    final file = await _localFile;
    return file.writeAsString('$user');
  }

  Future<String> readUser() async {
    try {
      final file = await _localFile;
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return null;
    }
  }
}
