// To parse this JSON data, do
//
//     final pedidos = pedidosFromJson(jsonString);

import 'dart:convert';

List<Pedidos> pedidosFromJson(String str) => List<Pedidos>.from(json.decode(str).map((x) => Pedidos.fromJson(x)));

String pedidosToJson(List<Pedidos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pedidos {
  Pedidos({
    required this.ncliente,
    required this.optica,
    required this.pedido,
    required this.bandeja,
    required this.proceso,
  });

  String ncliente;
  String optica;
  double pedido;
  String bandeja;
  double proceso;

  factory Pedidos.fromJson(Map<String, dynamic> json) => Pedidos(
        ncliente: json["ncliente"],
        optica: json["optica"],
        pedido: json["pedido"],
        bandeja: json["bandeja"],
        proceso: json["proceso"],
      );

  Map<String, dynamic> toJson() => {
        "ncliente": ncliente,
        "optica": optica,
        "pedido": pedido,
        "bandeja": bandeja,
        "proceso": proceso,
      };
}
