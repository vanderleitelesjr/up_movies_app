import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up_movies_app/pages/login_page.dart';
import 'package:up_movies_app/utils/nav.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future future = FirebaseAuth.instance.currentUser();

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Container(
            width: 300,
            color: Colors.red,
          );
        }

        FirebaseUser usuario = snapshot.data;

        return _menu(context, usuario);
      },
    );
  }

  _menu(context, FirebaseUser usuario) {
    return SafeArea(
      child: Container(
        color: Colors.grey[200],
        width: 320,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("${usuario.displayName}"),
              accountEmail: Text(usuario != null ? usuario.email : ""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    usuario.photoUrl ?? "https://firebasestorage.googleapis.com/v0/b/up-movies-app.appspot.com/o/avatar-372-456324.png?alt=media&token=e1cefe18-52ad-4409-bc94-f5c827606db7"),
              ),
              otherAccountsPictures: <Widget>[
                Image.asset("assets/imgs/android.png"),
                Image.asset("assets/imgs/android.png")
              ],
            ),
            Column(
              children: <Widget>[
                _menuItem("Home", Icons.home),
                _menuItem("Star", Icons.star),
                _menuItem("Favoritos", Icons.favorite),
                _menuItem("Logout", Icons.arrow_back,
                    onClick: () => _onClickLogout(context)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _menuItem(title, icon, {Function onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: ListTile(
        leading: Icon(
          icon,
          size: 50,
          color: Colors.red,
        ),
        trailing: Icon(
          Icons.forward,
          size: 50,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(
          "mais informações...",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  _onClickLogout(context) {
    pop(context);
    pushReplacement(context, LoginPage());
    print("Logout");
  }
}