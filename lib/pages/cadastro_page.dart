import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_movies_app/domain/service/firebase_service.dart';
import 'package:up_movies_app/pages/home_page.dart';
import 'package:up_movies_app/utils/alert.dart';
import 'package:up_movies_app/utils/nav.dart';
import 'package:image_picker/image_picker.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage>{
  final _tNome = TextEditingController(text: "");
  final _tLogin = TextEditingController(text: "");
  final _tSenha = TextEditingController(text: "");
  File fileCamera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movies",
        ),
      ),
      body: _body(context),
    );
  }

  _body(context){
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          GestureDetector(
          onTap: () {_onClickFoto(context);},
            child: fileCamera != null ?
            Image.file(fileCamera,height: 200,):
            Image.network("https://firebasestorage.googleapis.com/v0/b/up-movies-app.appspot.com/o/avatar-372-456324.png?alt=media&token=e1cefe18-52ad-4409-bc94-f5c827606db7",height: 200,),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Nome",
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: _tNome,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Email",
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: _tLogin,
            style: TextStyle(fontSize: 20, color: Colors.blue),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Senha",
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: _tSenha,
            style: TextStyle(fontSize: 20, color: Colors.blue),
            obscureText: true,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 46,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {_onClickCadastrar(context,false);},
              child: Text("Cadastrar",style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  Future _onClickCadastrar(context, bool param1) async {
    final service = FirebaseService();
    String nome = _tNome.text;
    String email = _tLogin.text;
    String senha = _tSenha.text;
    File foto = fileCamera;
    final response = await service.cadastrar(nome, email, senha, foto);

    if (response.isOk()){
      pushReplacement(context, HomePage());
    }else{
      alert(context,msg: response.msg);
    }
  }

   _onClickFoto(context) async {
    fileCamera = await ImagePicker.pickImage(source: ImageSource.camera);

    if(fileCamera != null){
      setState(() {
      });
    }
   }
}