class Filme {
  final int id;
  String title;
  String poster_path;
  String overview;
  String vote_average;

  Filme(this.id,this.title);

  String get urlFoto => "https://image.tmdb.org/t/p/w300$poster_path" ;

  Filme.fromJson(Map<String, dynamic> json)  :
        id = json['id'] as int,
        title = json["title"],
        poster_path = json["poster_path"],
        vote_average = json["vote_average"].toString(),
        overview = json["overview"];

  Map toMap() {
    Map<String,dynamic> map = {
      "title": title,
      "poster_path": poster_path,
      "vote_average": vote_average,
      "overview": overview,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Filme{id: $id, title: $title, poster_path: $urlFoto, vote_average: $vote_average}';
  }


}