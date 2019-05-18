
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:up_movies_app/domain/filme.dart';
import 'package:up_movies_app/domain/service/firebase_service.dart';

class FavoritosService {
  getFilmes() => _filmes.snapshots();

  CollectionReference get _filmes {
    String uid = firebaseUserUid;
    DocumentReference refUser = Firestore.instance.collection("users")
        .document(uid);
    return refUser.collection("filmes");
  }

  List<Filme> toList(AsyncSnapshot<QuerySnapshot> snapshot) {
   try {
     print("FavoritosService toList");
     List<Filme> filmes = snapshot.data.documents
         .map((document) => Filme.fromJson(document.data) )
         .toList();
     print("FavoritosService filmes $filmes");
     return filmes;
   }catch(error){
     print("erro favoritos $error");
   }
   return [];
  }

  Future<bool> favoritar(Filme filme) async {
    var document = _filmes.document("${filme.id}");
    var documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print("${filme.title}, adicionado nos favoritos");
      document.setData(filme.toMap());

      return true;
    } else {
      print("${filme.title}, removido nos favoritos");
      document.delete();

      return false;
    }
  }

  Future<bool> exists(Filme filme) async {

    var document = _filmes.document("${filme.id}");

    var documentSnapshot = await document.get();

    return await documentSnapshot.exists;
  }
}