import 'dart:async';

import 'package:easync_ihc/utilities/constants.dart';
import 'package:easync_ihc/utilities/discipline.dart';

import 'discipline_screen.dart';
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
  var discipline;

  @override
  void initState() {
    super.initState();
    User().readUser().then((value) {
      setState(() {
        user = value;
      });
    });
    Discipline().readDiscipline().then((value) {
      setState(() {
        discipline = value;
        print(discipline);
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

  Future<bool> _onSync() async {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Sicronização feita com sucesso \n😊'),
            titleTextStyle: TextStyle(fontSize: 32, color: Colors.black),
          );
        });
  }

  FutureOr onGoBack(dynamic value) async {
    setState(() {});
  }

  Widget _buildProfile() {
    return RaisedButton(
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
      color: Color(0xFF6CA8F1),
      child: Row(children: <Widget>[
        CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile.png')),
        SizedBox(width: 20.0),
        Column(
          children: <Widget>[
            Text(
              "nome: \ne-mail: \nlocal: \nturma: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
    );
  }

  Widget _buildDisciplines() {
    return Container(
        height: 220.0,
        decoration: kBoxDecorationStyle,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Disciplinas",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DisciplineScreen(
                                discipline: discipline,
                              )),
                    );
                  },
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.streetview_outlined),
                      SizedBox(width: 10.0),
                      Text("Geografia   ")
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  onPressed: null,
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.color_lens),
                      SizedBox(width: 10.0),
                      Text("Artes           ")
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: null,
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.colorize),
                      SizedBox(width: 10.0),
                      Text("Quimica      ")
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  onPressed: null,
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.bookmark),
                      SizedBox(width: 10.0),
                      Text("Português  ")
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: null,
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.calculate),
                      SizedBox(width: 10.0),
                      Text("Matemática")
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  onPressed: null,
                  elevation: 10.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.local_florist_rounded),
                      SizedBox(width: 10.0),
                      Text("Biologia      ")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("EAsync"),
          backgroundColor: Color(0xFF6CA8F1),
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
            vertical: 70.0,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildProfile(),
              _buildDisciplines(),
              RaisedButton(
                elevation: 5.0,
                onPressed: _onSync,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF6CA8F1),
                child: Text(
                  'SINCRONIZAR',
                  style: TextStyle(
                    color: Colors.white,
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
