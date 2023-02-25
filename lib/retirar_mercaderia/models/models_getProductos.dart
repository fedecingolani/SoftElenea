// To parse this JSON data, do
//
//     final modelGetProductos = modelGetProductosFromJson(jsonString);

import 'dart:convert';

List<ModelGetProductos> modelGetProductosFromJson(String str) => List<ModelGetProductos>.from(json.decode(str).map((x) => ModelGetProductos.fromJson(x)));

String modelGetProductosToJson(List<ModelGetProductos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGetProductos {
  ModelGetProductos({
    required this.codigoBarra,
    required this.nroGaveta,
    required this.codigoUbicacion,
    required this.posicion,
    required this.cantidad,
    required this.nombre,
    required this.esferico,
    required this.cilindrico,
    required this.diameter,
  });

  String codigoBarra;
  int nroGaveta;
  String codigoUbicacion;
  int posicion;
  int cantidad;
  String nombre;
  String esferico;
  String cilindrico;
  String diameter;

  factory ModelGetProductos.fromJson(Map<String, dynamic> json) => ModelGetProductos(
        codigoBarra: json["CB"],
        nroGaveta: json["NroGabeta"],
        codigoUbicacion: json["CodigoUbicacion"],
        posicion: json["Posicion"],
        cantidad: json["Cantidad"],
        nombre: json["Nombre"],
        esferico: json["esferico"],
        cilindrico: json["cilindrico"],
        diameter: json["diameter"],
      );

  Map<String, dynamic> toJson() => {
        "CB": codigoBarra,
        "NroGabeta": nroGaveta,
        "CodigoUbicacion": codigoUbicacion,
        "Posicion": posicion,
        "Cantidad": cantidad,
        "Nombre": nombre,
        "esferico": esferico,
        "cilindrico": cilindrico,
        "diameter": diameter,
      };
}
