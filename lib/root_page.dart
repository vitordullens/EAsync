import 'package:flutter/material.dart';
import 'package:easync_ihc/utilities/auth.dart';
import 'screens/login_screen.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final Auth auth;
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginScreen(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          body: new Container(
            child: Text("Entrei"),
          ),
        );
    }
  }
}
