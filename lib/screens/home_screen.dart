import 'dart:async';

import 'profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:easync_ihc/utilities/auth.dart';
import 'package:easync_ihc/utilities/user.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.auth, this.onSignedOut});
  final Auth auth;
  final VoidCallback onSignedOut;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user;

  @override
  void initState() {
    super.initState();
    User().readUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  Future<void> _signOut() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Você tem certeza?'),
            content: new Text('Você quer sair do seu perfil?'),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NÃO"),
                  ),
                  SizedBox(width: 72),
                  new GestureDetector(
                    onTap: () {
                      widget.onSignedOut();
                      Navigator.of(context).pop(false);
                    },
                    child: Text("SIM"),
                  ),
                  SizedBox(width: 64),
                ],
              )
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Você tem certeza?'),
            content: new Text('Você quer sair do aplicativo?'),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NÃO"),
                  ),
                  SizedBox(width: 72),
                  new GestureDetector(
                    onTap: () {
                      widget.onSignedOut();
                      Navigator.of(context).pop(false);
                    },
                    child: Text("SIM"),
                  ),
                  SizedBox(width: 64),
                ],
              )
            ],
          ),
        ) ??
        false;
  }

  FutureOr onGoBack(dynamic value) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 120.0,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              user: user,
                            )),
                  ).then(onGoBack);
                },
                color: Colors.blueGrey,
                child: Row(children: <Widget>[
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile.png')),
                  SizedBox(width: 20.0),
                  Column(
                    children: <Widget>[
                      Text(
                        "nome: \ne-mail: \nlocal: \nturma: ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        user == null
                            ? 'Carregando...'
                            : '${user['nome']}\n${user['email']}\n${user['cidade']}, ${user['pais']}\n${user['serie']} - ${user['turma']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              RaisedButton(
                elevation: 5.0,
                onPressed: () => {},
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                child: Text(
                  'SINCRONIZAR',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
