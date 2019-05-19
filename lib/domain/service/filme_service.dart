import 'dart:convert';
import 'package:up_movies_app/domain/filme.dart';
import 'package:http/http.dart' as http;

class FilmeService {
  static Future<List<Filme>> getFilmes(filtro) async {

    final url = "https://api.themoviedb.org/3/movie/popular?api_key=8ca642cd4d44af0779864a650c602c6b&language=pt-BR";
    print("> get: $url");

    final response = await http.get(url);
    
    final mapFilmes = json.decode(response.body);

    List<Filme> filmes = mapFilmes["results"].map<Filme>((json) => Filme.fromJson(json)).toList();

    if (filtro != ""){
      List<Filme> filtrado = filmes.where((i) => i.title.toLowerCase().contains(filtro.toString().toLowerCase())).toList();
      return filtrado;
    }else{
      return filmes;
    }
  }
}