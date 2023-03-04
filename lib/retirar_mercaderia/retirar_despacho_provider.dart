import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tester_app/config.dart';
import 'package:tester_app/retirar_mercaderia/models/model_getDespachos.dart';
import 'package:tester_app/retirar_mercaderia/models/model_getProductos.dart';
import 'package:tester_app/retirar_mercaderia/repositorio_api.dart';

class DespachoProvider extends ChangeNotifier {
  List<ModelGetDespachos> _listaDespachos = [];

  List<ModelGetDespachos> get listaDespachos => _listaDespachos;

  set listaDespachos(List<ModelGetDespachos> value) {
    _listaDespachos = value;
    notifyListeners();
  }

  bool _cargandoDespachos = false;
  bool get cargandoDespachos => _cargandoDespachos;
  set cargandoDespachos(bool value) {
    _cargandoDespachos = value;
    notifyListeners();
  }

  String _txtCodigoBarraStock = '';
  String get txtCodigoBarraStock => _txtCodigoBarraStock;
  set txtCodigoBarraStock(String value) {
    _txtCodigoBarraStock = value;
    notifyListeners();
  }

  bool _armandoDespacho = false;
  bool get armandoDespacho => _armandoDespacho;
  set armandoDespacho(bool value) {
    _armandoDespacho = value;
    notifyListeners();
  }

  Future<ModelGetDespachos> armarDespachos(List<ModelGetProductos> lista) async {
    try {
      armandoDespacho = true;
      ModelGetDespachos despacho = ModelGetDespachos(cantidad1: 1, codigoBarra1: lista[0].codigoBarra, origen1: lista[0].codigoUbicacion, cantidad2: lista.length == 2 ? 1 : 0, codigoBarra2: lista.length == 2 ? lista[1].codigoBarra : '', origen2: lista.length == 2 ? lista[1].codigoUbicacion : '', pedido: 0);

      final resu = await RepositorioApi.createDespacho(despacho).catchError((onError) {
        throw onError;
      });
      armandoDespacho = false;
      return resu;
    } catch (e) {
      armandoDespacho = false;
      print(e.toString());
      return Future.error(e.toString());
    }
  }

  Future<void> getListaDespacho() async {
    try {
      final rand = new Random();

      cargandoDespachos = true;
      listaDespachos = await RepositorioApi.getDespachos();
      cargandoDespachos = false;
    } catch (e) {
      print(e.toString());
      cargandoDespachos = false;
      return Future.error(e.toString());
    }
  }

  Future<void> getProductStock(String codigoBarra) async {
    try {
      cargandoDespachos = true;
      listaDespachos = await RepositorioApi.getDespachos();
      cargandoDespachos = false;
    } catch (e) {
      print(e.toString());
      cargandoDespachos = false;
      return Future.error(e.toString());
    }
  }

  void cambiarEstado(int id, int estado) async {
    await RepositorioApi.cambiarEstadoDespacho(id, estado);
    getListaDespacho();
  }

  ModelGetProductos? _productoStock;
  ModelGetProductos? get productoStock => _productoStock;
  set productoStock(ModelGetProductos? value) {
    _productoStock = value;
    notifyListeners();
  }

  /// Función que obtiene los despachos de la base de datos.
  /// Devuelve entero con el stock nuevo.
  /// [cantidad] es la cantidad que se va a retirar del stock. si es negativo, se suma al stock.
  Future<int> updateStock(String codigoBarra, int cantidad) async {
    try {
      RepositorioApi.getProductoTipo2(codigoBarra).then((value) {
        productoStock = value;
      }).catchError((onError) {
        throw onError;
      });

      return 0;
      // final String url = '${Config.IP_SERVER}/api/ConsultaCBDisponiblesT2?cb=$codigoBarra';

      // final response = await http.get(Uri.parse(url), headers: {
      //   'Content-Type': 'application/json'
      // });

      // if (response.statusCode == 200 && response.body.isNotEmpty) {
      //   final data = jsonDecode(response.body);
      //   final String url = '${Config.IP_SERVER}/api/productos';

      //   return data['cantidad'] - cantidad;
      // } else {
      //   return Future.error('Status Code: ${response.statusCode}');
      // }
    } catch (e) {
      return Future.error('TryCatch: ${e.toString()}');
    }
  }

  List<ModelGetProductos> _listaProductosDetalle = [];
  List<ModelGetProductos> get listaProductosDetalle => _listaProductosDetalle;
  set listaProductosDetalle(List<ModelGetProductos> value) {
    _listaProductosDetalle = value;
    notifyListeners();
  }

  addListaProductoDeatalle(ModelGetProductos value) {
    _listaProductosDetalle.add(value);
    notifyListeners();
  }

  /// Genera las vistas para el detalle de los articulos que están en los despachos.
  void despachoSeleccionado(ModelGetDespachos? data) async {
    if (data != null) {
      if (data.codigoBarra1 != null) {
        listaProductosDetalle = [];
        await RepositorioApi.getProductos(dato: data.codigoBarra1!).then((value) {
          if (value != null) {
            final x = value.where((element) => element.codigoUbicacion == data.origen1).toList().first;
            addListaProductoDeatalle(x);
          }
        }).catchError((onError) {
          throw onError;
        });
      }
      if (data.codigoBarra2 != null) {
        await RepositorioApi.getProductos(dato: data.codigoBarra2!).then((value) {
          if (value != null) {
            final x = value.where((element) => element.codigoUbicacion == data.origen2).toList().first;
            addListaProductoDeatalle(x);
          }
        }).catchError((onError) {
          throw onError;
        });
      }
    }
  }

  int _idSeleccionado = -1;
  int get idSeleccionado => _idSeleccionado;
  set idSeleccionado(int value) {
    _idSeleccionado = value;
    notifyListeners();
  }
}
