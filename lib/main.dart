import 'package:flutter/material.dart';
import 'package:easync_ihc/root_page.dart';
import 'package:easync_ihc/utilities/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EAsync',
      debugShowCheckedModeBanner: false,
      home: RootPage(auth: new Auth()),
    );
  }
}
