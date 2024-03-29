import 'dart:async';

import 'package:flutter/material.dart';

import 'package:robot_soft/retirar_mercaderia/models/mode_get_despachos.dart';
import 'package:robot_soft/retirar_mercaderia/models/model_get_productos.dart';
import 'package:robot_soft/retirar_mercaderia/repositorio_api.dart';

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
    Future.delayed(const Duration(milliseconds: 500), () {
      notifyListeners();
    });
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

  /// Arma un despacho con los productos seleccionados y lo guarda en la base de datos.
  Future<void> armarDespachos(List<ModelGetProductos> lista) async {
    try {
      if (lista.isEmpty) {
        return Future.error('No hay productos seleccionados');
      }
      armandoDespacho = true;
      ModelGetDespachos despacho = ModelGetDespachos(cantidad1: 1, codigoBarra1: lista[0].codigoBarra, origen1: lista[0].codigoUbicacion, cantidad2: lista.length == 2 ? 1 : 0, codigoBarra2: lista.length == 2 ? lista[1].codigoBarra : '', origen2: lista.length == 2 ? lista[1].codigoUbicacion : '', pedido: 0);

      await RepositorioApi.createDespacho(despacho).then((value) {
        armandoDespacho = false;
        return value;
      }).catchError((onError) {
        armandoDespacho = false;
        throw onError;
      });
    } catch (e) {
      armandoDespacho = false;

      return Future.error(e.toString());
    }
  }

  /// Obtiene la lista de despachos de la base de datos. Cambia el estado de [cargandoDespachos] a true mientras se obtiene la lista.
  Future<void> getListaDespacho() async {
    try {
      cargandoDespachos = true;
      listaDespachos = await RepositorioApi.getDespachos();
      cargandoDespachos = false;
    } catch (e) {
      debugPrint(e.toString());
      cargandoDespachos = false;
      return Future.error(e.toString());
    }
  }

  /// Cambia el estado de un despacho en la base de datos.
  /// [id] es el id del despacho. [estado] es el estado al que se quiere cambiar.
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
  Future<void> updateStock(String codigoBarra, int cantidad) async {
    try {
      await RepositorioApi.getProductoTipo2(codigoBarra).then((value) {
        productoStock = value;
      });

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
      return Future.error('Error STOCK: ${e.toString()}');
    }
  }

  /// Lista que contiene los productos que se van a agregar al despacho.
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
  Future<void> despachoSeleccionado(ModelGetDespachos? data) async {
    try {
      if (data == null) {
        listaProductosDetalle = [];
        return Future.error('No se seleccionó ningún despacho');
      }
      if (data.codigoBarra1!.isNotEmpty) {
        _listaProductosDetalle = [];
        await RepositorioApi.getProductos(dato: data.codigoBarra1!).then((value) {
          if (value != null) {
            final x = value.where((element) => element.codigoUbicacion == data.origen1).toList().first;
            addListaProductoDeatalle(x);
          }
        });
      }
      if (data.codigoBarra2!.isNotEmpty) {
        await RepositorioApi.getProductos(dato: data.codigoBarra2!).then((value) {
          if (value != null) {
            final x = value.where((element) => element.codigoUbicacion == data.origen2).toList().first;
            addListaProductoDeatalle(x);
          }
        });
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  /// Variable para mostrar el detalle de los despachos. Guarda el id del despacho seleccionado.
  int _idSeleccionado = -1;
  int get idSeleccionado => _idSeleccionado;
  set idSeleccionado(int value) {
    _idSeleccionado = value;
    notifyListeners();
  }
}
