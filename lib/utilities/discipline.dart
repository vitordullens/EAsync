import 'dart:io';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Discipline {
  static Discipline _instance;
  factory Discipline() => _instance ??= new Discipline._();
  Discipline._();

  Future<String> _getJson(String str) async {
    return await rootBundle.loadString(str);
  }

  Future<void> saveFile() async {
    var discipline = await Discipline().readDiscipline();
    if (discipline == null) {
      discipline = jsonDecode(await _getJson('assets/json/discipline.json'));
      await Discipline().writeDiscipline(discipline);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/discipline.json');
  }

  Future<File> writeDiscipline(var discipline) async {
    final file = await _localFile;
    var json = jsonEncode(discipline);
    return file.writeAsString('$json');
  }

  Future<dynamic> readDiscipline() async {
    try {
      final file = await _localFile;
      Map<String, dynamic> discipline = jsonDecode(await file.readAsString());
      return discipline;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
