import 'package:easync_ihc/utilities/auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({this.auth, this.onSignedOut});
  final Auth auth;
  final VoidCallback onSignedOut;

  void _signOut() {
    onSignedOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EAsync"),
        actions: <Widget>[
          FlatButton(
              onPressed: _signOut,
              child: Text(
                'Sair',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ))
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            "BEM-VINDO",
            style: TextStyle(fontSize: 23.0),
          ),
        ),
      ),
    );
  }
}
