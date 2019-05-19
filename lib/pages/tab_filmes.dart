import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_movies_app/domain/filme.dart';
import 'package:up_movies_app/domain/service/favoritos_service.dart';
import 'package:up_movies_app/domain/service/filme_service.dart';
import 'package:up_movies_app/pages/detalhes_page.dart';
import 'package:up_movies_app/utils/nav.dart';

class TabFilmes extends StatefulWidget {
  bool showFavoritos;
  String filtro;

  TabFilmes(this.showFavoritos,this.filtro);

  @override
  _TabFilmesState createState() => _TabFilmesState(showFavoritos,filtro);
}

class _TabFilmesState extends State<TabFilmes> {
  bool showFavoritos;
  String filtro;

  _TabFilmesState(this.showFavoritos,this.filtro);

  @override
  Widget build(BuildContext context) {
    return showFavoritos ? _favListBuilder(context,filtro) :  _listBuilder(context,filtro);
  }

  _listBuilder(context,filtro) {
    Future<List<Filme>> filmes = FilmeService.getFilmes(filtro);

    return FutureBuilder<List<Filme>>(
      future: filmes,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Filme> filmes = snapshot.data;
        return _listView(context,filmes);
      },
    );
  }

  _favListBuilder(context,filtro) {
    final service = FavoritosService();

    return StreamBuilder<QuerySnapshot>(
      stream: service.getFilmes(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          List<Filme> filmes = service.toList(snapshot);

          return _listView(context, filmes);
        }else if (snapshot.hasError){
          return Center(
            child: Text("Sem dados",style: TextStyle(
                color: Colors.grey,
                fontSize: 26,
                fontStyle: FontStyle.italic
            ),),
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _listView(context, List<Filme> filmes) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: filmes.length,
      itemBuilder: (context, idx) {
        final filme = filmes[idx];

        return GestureDetector(
          onTap: () => _onClickFilme(context, filme),
          child: Container(
            child: Image.network(
              filme.urlFoto ?? "http://www.livroandroid.com.br/livro/filmes/esportivos/Ferrari_FF.png",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  _onClickFilme(context, Filme filme) {
    push(context,DetalhesFilme(filme));
  }
}
