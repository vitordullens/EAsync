import 'package:flutter/material.dart';
import 'package:easync_ihc/utilities/discipline.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({this.questions, this.json});
  final List<dynamic> questions;
  final Map<String, dynamic> json;
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final formKey = GlobalKey<FormState>();

  String q1, q2;

  Future<bool> _onSaved() async {
    submit();
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Respostas salvas com sucesso \n😊'),
            titleTextStyle: TextStyle(fontSize: 32, color: Colors.black),
          );
        });
  }

  void submit() async {
    final form = formKey.currentState;
    form.save();
    setState(() {
      widget.json['geografia']['capitulo 1']['respostas'] = [q1, q2];
    });
    await Discipline().writeDiscipline(widget.json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Exercícios"),
        backgroundColor: Color(0xFF6CA8F1),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 20.0,
          ),
          width: double.infinity,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/cap1.png')),
                SizedBox(height: 30),
                Text("${widget.questions[0]}"),
                TextFormField(
                  initialValue: widget.json['geografia']['capitulo 1']
                              ['respostas'] !=
                          null
                      ? "${widget.json['geografia']['capitulo 1']['respostas'][0]}"
                      : '',
                  onSaved: (value) => q1 = value,
                  maxLines: 6,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    labelText: "Resposta",
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 30),
                Text("${widget.questions[1]}"),
                TextFormField(
                  initialValue: widget.json['geografia']['capitulo 1']
                              ['respostas'] !=
                          null
                      ? "${widget.json['geografia']['capitulo 1']['respostas'][1]}"
                      : '',
                  onSaved: (value) => q2 = value,
                  maxLines: 6,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    labelText: "Resposta",
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  elevation: 5.0,
                  onPressed: _onSaved,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Color(0xFF6CA8F1),
                  child: Text(
                    'SALVAR',
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
      ),
    );
  }
}
