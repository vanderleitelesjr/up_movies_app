
import 'dart:convert';

import 'package:up_movies_app/utils/prefs.dart';


class Usuario {
  final String nome;
  final String email;

  Usuario(this.nome, this.email);

  Usuario.fromJson(Map<String,dynamic> map) :
        nome = map["nome"],
        email = map["email"];

  toMap() {
    return {
      "nome": nome,
      "email": email
    };
  }

  toJson() {
    return json.encode(toMap());
  }

  void savePrefs() {
    String s = toJson();
    print("*** JSON do USUARIO ***");
    print(s);

    Prefs.setString("user.prefs", s);
  }

  static Future<Usuario> getPrefs() async {
    String s = await Prefs.getString("user.prefs");
    if(s == null || s.isEmpty) {
      return null;
    }
    final map = json.decode(s);
    final user = Usuario.fromJson(map);
    return user;
  }
}