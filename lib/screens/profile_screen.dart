import 'package:easync_ihc/utilities/user.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.user});
  final Map<String, dynamic> user;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();

  String _nome, _cidade, _descricao;

  void submit() async {
    final form = formKey.currentState;
    form.save();
    setState(() {
      widget.user['nome'] = _nome;
      widget.user['cidade'] = _cidade;
      widget.user['descricao'] = _descricao;
    });
    await User().writeUser(widget.user);
  }

  Future<bool> _onSaved() async {
    submit();
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Perfil salvo com sucesso \n😊'),
            titleTextStyle: TextStyle(fontSize: 32, color: Colors.black),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: Color(0xFF6CA8F1),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.user);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/profile.png')),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: "${widget.user['nome']}",
                      onSaved: (value) => _nome = value,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "Nome",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: "${widget.user['email']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      initialValue: "${widget.user['cidade']}",
                      onSaved: (value) => _cidade = value,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "Cidade",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: "${widget.user['pais']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "País",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: "${widget.user['cpf']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "CPF",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: "${widget.user['serie']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "Série",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      initialValue: "${widget.user['turma']}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "Turma",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      initialValue: "${widget.user['descricao']}",
                      onSaved: (value) => _descricao = value,
                      maxLines: 6,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        labelText: "Descrição",
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.0),
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
    );
  }
}
