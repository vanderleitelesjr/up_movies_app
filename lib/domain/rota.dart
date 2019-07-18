class Rota {
  final int id;
  String nome;
  String latitude;
  String longitude;
  String estado;

  Rota(this.id,this.nome);

  Rota.fromJson(Map<String, dynamic> json)  :
        id = json['id'] as int,
        nome = json["nome"],
        estado = json["estado"],
        latitude = json["latitude"],
        longitude = json["longitude"];

  Map toMap() {
    Map<String,dynamic> map = {
      "nome": nome,
      "estado": estado,
      "latitude": latitude,
      "longitude": longitude,
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

}