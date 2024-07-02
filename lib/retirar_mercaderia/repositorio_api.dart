import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:robot_soft/retirar_mercaderia/models/mode_get_despachos.dart';
import 'package:robot_soft/retirar_mercaderia/models/mode_get_pedidos.dart';
import 'package:robot_soft/retirar_mercaderia/models/model_get_productos.dart';

import 'package:http/http.dart' as http;
import 'package:robot_soft/config.dart';

class RepositorioApi {
  /// Función que obtiene los productos de la base de datos.
  /// Para la busqueda de productos se utiliza el campo [dato] que puede ser el código de barra o el nombre del producto.
  static Future<List<ModelGetProductos>?> getProductos({required String dato, String esferico = '', String cilindrico = '', String diametro = ''}) async {
    try {
      final String dat = dato.replaceAll(" ", ";");
      String url = '';

      if (dato.isNotEmpty) {
        url = '${Config.serverIP}/api/UbicacionBusqueda?texto=$dat&esferico=$esferico&cilindrico=$cilindrico&diameter=$diametro';
      }

      if (url == '') {
        return Future.error('No se pudo realizar la busqueda');
      }
      print(url);
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = modelGetProductosFromJson(response.body);

        return data.sublist(0, data.length > 100 ? 100 : data.length);
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  /// Función que graba los despachos de la base de datos.
  static Future<ModelGetDespachos> createDespacho(ModelGetDespachos data) async {
    try {
      final String url = "${Config.serverIP}/api/ArmaDespachoEgreso?origen1=${data.origen1}&codbarra1=${data.codigoBarra1}&cantidad1=${data.cantidad1}&origen2=${data.origen2}&codbarra2=${data.codigoBarra2}&cantidad2=${data.cantidad2}&pedido=${data.pedido}";

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        try {
          return modelGetDespachosFromJson(response.body).first;
        } catch (e) {
          throw 'Se Generó el despacho, pero se produjo un error al intentar leerlo.';
        }
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  /// Función que obtiene los despachos de la base de datos.
  static Future<List<ModelGetDespachos>> getDespachos() async {
    try {
      final String url = '${Config.serverIP}/api/Despachos?estado=-2';

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = modelGetDespachosFromJson(response.body);

        return data.where((element) => element.estado != 3).toList();
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  /// Función que cambia los estados de los despachos de la base de datos.
  static Future<String?> cambiarEstadoDespacho(int idDespacho, int estado) async {
    try {
      final String url = '${Config.serverIP}/api/Despacho/CambiaEstado?iddespacho=$idDespacho&estado=$estado';

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return response.body;
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  /// Funcion que consulta los despachos con tipo 2, devuelve producto
  static Future<ModelGetProductos> getProductoTipo2(String codigoBarra) async {
    try {
      final String url = '${Config.serverIP}/api/ConsultaCBDisponiblesT2?cb=$codigoBarra';

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        if (response.body == '[]') {
          return Future.error('No se encontró el producto');
        }
        return modelGetProductosFromJson(response.body).first;
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  ///Funcion que actualiza el stock del producto
  static Future<void> actualizarProducto(ModelGetProductos productos) async {
    try {
      final String url = '${Config.serverIP}/api/productos';
      final response = await http.put(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode(productos.toJson()));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        debugPrint(data);
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  ///¡¡¡FUNCION ROBOT!!!
  ///Funcion que pone en funcionamiento el robot.
  static Future<void> robotDespacho(String idDespacho) async {
    try {
      final String url = '${Config.serverIP}/api/DespachoIDRun?idDespacho=$idDespacho';
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        debugPrint(data);
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  ///Función que traer las ordenes - pedidos.
  static Future<List<Pedidos>> pedidosOrdenes() async {
    try {
      final String url = '${Config.serverIP}/api/clientesOrders';
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return pedidosFromJson(response.body);
      } else {
        return Future.error('Status Code: ${response.statusCode}');
      }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }
}
