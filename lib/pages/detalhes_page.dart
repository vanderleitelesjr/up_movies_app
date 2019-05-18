import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:up_movies_app/domain/filme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:up_movies_app/domain/service/favoritos_service.dart';

class DetalhesFilme extends StatefulWidget {
  final Filme filme;

  const DetalhesFilme(this.filme);

  @override
  _DetalhesFilmeState createState() => _DetalhesFilmeState();
}

class _DetalhesFilmeState extends State<DetalhesFilme> {
  bool _isFavorito = false;

  @override
  void initState() {
    super.initState();

    FavoritosService().exists(widget.filme).then((b){
      setState(() {
        _isFavorito = b;
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filme.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: _isFavorito ? Colors.red : Colors.grey),
            onPressed: () => _onClickFavoritar(context,widget.filme),
          )
        ],
      ),
      body: _body(context),
    );
  }

  CustomScrollView _body(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leading: Container(),
          floating: false,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            background: Image.network(widget.filme.urlFoto ?? "http://www.livroandroid.com.br/livro/filmes/esportivos/Ferrari_FF.png",fit:BoxFit.cover,),
          ),
          expandedHeight: 300,
        ),
        SliverFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(child:
                    Text(
                      widget.filme.title,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      FlutterRatingBar(
                        initialRating: double.parse(widget.filme.vote_average)/2,
                        fillColor: Colors.amber,
                        borderColor: Colors.amber.withAlpha(50),
                        allowHalfRating: true,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(widget.filme.vote_average.toString())
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(widget.filme.overview),
                ],
              )),
              Divider(color: Colors.black12,)
            ],
          ),
        ),
      ],
    );
  }

  Future _onClickFavoritar(context,filme) async {
    final service = FavoritosService();
    final b = await service.favoritar(filme);

    setState(() {
      _isFavorito = b;
    });
  }
}