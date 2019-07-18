import 'dart:convert';
import 'package:up_movies_app/domain/filme.dart';
import 'package:http/http.dart' as http;

import '../rota.dart';

class RotasService {
  static Future<List<Rota>> getRotas() async {

    final url = "https://triptogo-224720.appspot.com/api/v1/rotas/";

    final response = await http.get(url);
    
    final mapRotas = json.decode(response.body);

    List<Rota> rotas = mapRotas.map<Rota>((json) => Rota.fromJson(json)).toList();

    return rotas;
  }
}