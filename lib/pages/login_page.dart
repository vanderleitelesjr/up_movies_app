import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:up_movies_app/domain/service/firebase_service.dart';
import 'package:up_movies_app/pages/cadastro_page.dart';
import 'package:up_movies_app/pages/home_page.dart';
import 'package:up_movies_app/utils/alert.dart';
import 'package:up_movies_app/utils/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _tLogin = TextEditingController(text: "");
  final _tSenha = TextEditingController(text: "");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    Future<String> f = _firebaseMessaging.getToken();
    f.then((s){
      print("Token $s");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message){
        print("");
        print(message);
      },
      onLaunch: (Map<String, dynamic> message){},
      onResume: (Map<String, dynamic> message){},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TripToGo",
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
          Text(
            "Email",
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            controller: _tLogin,
            style: TextStyle(fontSize: 20, color: Colors.blue),

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
              onPressed: () {_onClickLogin(context,false);},
              child: Text("Login",style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ),
          /*Container(
            height: 46,
            margin: EdgeInsets.only(top: 20),
            child: GoogleSignInButton(
              onPressed: () {_onClickLogin(context,true);},
            ),
          ),*/
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              _onClickCadastrar(context);
            },
            child: Text(
              "Cadastre-se",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  _onClickCadastrar(context) {
    push(context,CadastroPage());
  }

  void _onClickLogin(context,google) async{
    if (!google) {
      final service = FirebaseService();
      String email = _tLogin.text;
      String senha = _tSenha.text;
      final response = await service.login(email, senha);

      if (response.isOk()){
        pushReplacement(context, HomePage());
      }else{
        alert(context,msg: response.msg);
      }
    }else{
      final service = FirebaseService();
      final response = await service.loginGoogle();

      if (response.isOk()){
        pushReplacement(context, HomePage());
      }else{
        alert(context,msg: response.msg);
      }
    }
  }
}