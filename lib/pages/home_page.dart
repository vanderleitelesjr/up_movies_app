
import 'package:flutter/material.dart';
import 'package:up_movies_app/drawer_list.dart';
import 'package:up_movies_app/pages/tab_rotas.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("TripToGo"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Rotas",
              ),
            ]),
          ),
          body: TabBarView(children: [
            TabRotas(),
          ]),
          drawer: DrawerList(),
        ),
      );
  }
}