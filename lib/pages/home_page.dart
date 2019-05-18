
import 'package:flutter/material.dart';
import 'package:up_movies_app/drawer_list.dart';
import 'package:up_movies_app/pages/tab_filmes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
             "Movies",
            ),
            bottom: TabBar(tabs: [
              Tab(
                text: "Em Alta",
              ),
              Tab(
                text: "Meus Filmes",
              )
            ]),
          ),
          body: TabBarView(children: [
            TabFilmes("emAlta"),
            TabFilmes("favoritos"),
          ]),
          drawer: DrawerList(),
    ),
      );
  }
}