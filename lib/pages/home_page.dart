
import 'package:flutter/material.dart';
import 'package:up_movies_app/drawer_list.dart';
import 'package:up_movies_app/pages/tab_filmes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final filtroController = TextEditingController();
  String filtro = "";

  @override
  void initState() {
    filtroController.addListener((){
      if(filtroController.text.isEmpty){
        setState(() {
          filtro = "";
        });
      }else{
        setState(() {
          filtro = filtroController.text;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: filtroController,
              decoration: (InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Pesquisar filmes...",
              )),
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
            TabFilmes(false,filtro),
            TabFilmes(true,filtro),
          ]),
          drawer: DrawerList(),
        ),
      );
  }
}