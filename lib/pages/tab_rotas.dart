import 'package:flutter/material.dart';
import 'package:up_movies_app/domain/rota.dart';
import 'package:up_movies_app/domain/service/rota_service.dart';

class TabRotas extends StatefulWidget {

  TabRotas();

  @override
  _TabRotasState createState() => _TabRotasState();
}

class _TabRotasState extends State<TabRotas> {

  _TabRotasState();

  @override
  Widget build(BuildContext context) {
    return _listBuilder(context);
  }

  _listBuilder(context) {
    Future<List<Rota>> rotas = RotasService.getRotas();

    return FutureBuilder<List<Rota>>(
      future: rotas,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Rota> rotas = snapshot.data;
        return _listView(context,rotas);
      },
    );
  }

  _listView(context, List<Rota> rotas) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: rotas.length,
      itemBuilder: (context, idx) {
        final rota = rotas[idx];

        return GestureDetector(
          onTap: () => _onClickRota(context, rota),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(rota.nome),
              Text(rota.estado),
              Text(rota.latitude),
              Text(rota.longitude),
            ],
          ),
        );
      },
    );
  }

  _onClickRota(context, Rota rota) {
    //push(context,DetalhesRota(rota));
    print(rota.nome);
  }
}
