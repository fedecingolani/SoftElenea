// To parse this JSON data, do
//
//     final modelGetDespachos = modelGetDespachosFromJson(jsonString);

import 'dart:convert';

List<ModelGetDespachos> modelGetDespachosFromJson(String str) => List<ModelGetDespachos>.from(json.decode(str).map((x) => ModelGetDespachos.fromJson(x)));

String modelGetDespachosToJson(List<ModelGetDespachos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelGetDespachos {
  ModelGetDespachos({
    this.idDespacho,
    this.tipo,
    this.origen1,
    this.destino1,
    this.origen2,
    this.destino2,
    this.estado,
    this.codigoBarra1,
    this.cantidad1,
    this.codigoBarra2,
    this.cantidad2,
    this.fecAlta,
    this.fecBaja,
    this.fecModi,
    this.pedido,
  });

  int? idDespacho;
  int? tipo;
  String? origen1;
  String? destino1;
  String? origen2;
  String? destino2;
  int? estado;
  String? codigoBarra1;
  int? cantidad1;
  String? codigoBarra2;
  int? cantidad2;
  String? fecAlta;
  String? fecBaja;
  String? fecModi;
  int? pedido;

  factory ModelGetDespachos.fromJson(Map<String, dynamic> json) => ModelGetDespachos(
        idDespacho: json["IdDespacho"] ?? 0,
        tipo: json["Tipo"] ?? 0,
        origen1: json["Origen1"] ?? '',
        destino1: json["Destino1"] ?? '',
        origen2: json["Origen2"] ?? '',
        destino2: json["Destino2"] ?? '',
        estado: json["Estado"] ?? 0,
        codigoBarra1: json["CodigoBarra1"] ?? '',
        cantidad1: json["Cantidad1"] ?? 0,
        codigoBarra2: json["CodigoBarra2"] ?? '',
        cantidad2: json["Cantidad2"] ?? 0,
        fecAlta: json["FecModi"] ?? '',
        fecBaja: json["FecModi"] ?? '',
        fecModi: json["FecModi"] ?? '',
        pedido: json["Pedido"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "IdDespacho": idDespacho,
        "Tipo": tipo,
        "Origen1": origen1,
        "Destino1": destino1,
        "Origen2": origen2,
        "Destino2": destino2,
        "Estado": estado,
        "CodigoBarra1": codigoBarra1,
        "Cantidad1": cantidad1,
        "CodigoBarra2": codigoBarra2,
        "Cantidad2": cantidad2,
        "FecAlta": fecAlta,
        "FecBaja": fecBaja,
        "FecModi": fecModi,
        "Pedido": pedido,
      };
}
