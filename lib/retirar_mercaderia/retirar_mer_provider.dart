import 'package:flutter/material.dart';
import 'package:tester_app/retirar_mercaderia/models/models_getProductos.dart';
import 'package:tester_app/retirar_mercaderia/repositorio_api.dart';

class RetirarMerProvider extends ChangeNotifier {
  String _txtBusqueda = '';
  String get txtBusqueda => _txtBusqueda;
  set txtBusqueda(String value) {
    _txtBusqueda = value;
    notifyListeners();
  }

  String _txtEsferico = '';
  String get txtEsferico => _txtEsferico;
  set txtEsferico(String value) {
    _txtEsferico = value;
    notifyListeners();
  }

  String _txtCilindrico = '';
  String get txtCilindrico => _txtCilindrico;
  set txtCilindrico(String value) {
    _txtCilindrico = value;
    notifyListeners();
  }

  String _txtDiametro = '';
  String get txtDiametro => _txtDiametro;
  set txtDiametro(String value) {
    _txtDiametro = value;
    notifyListeners();
  }

  List<ModelGetProductos>? _listaProductos = [];
  List<ModelGetProductos>? get listaProductos => _listaProductos;
  set listaProductos(List<ModelGetProductos>? value) {
    _listaProductos = value;
    notifyListeners();
  }

  List<ModelGetProductos> _listaProductosFiltrados = [];

  List<ModelGetProductos> get listaProductosFiltrados => _listaProductosFiltrados;

  set listaProductosFiltrados(List<ModelGetProductos> value) {
    _listaProductosFiltrados = value;
    notifyListeners();
  }

  void addProductoFiltrado(ModelGetProductos producto) {
    _listaProductosFiltrados.add(producto);
    notifyListeners();
  }

  void removeProductoFiltrado(ModelGetProductos producto) {
    _listaProductosFiltrados.remove(producto);
    notifyListeners();
  }

  bool _cargandoProductos = false;
  bool get cargandoProductos => _cargandoProductos;
  set cargandoProductos(bool value) {
    _cargandoProductos = value;
    notifyListeners();
  }

  void getListaProductos() async {
    cargandoProductos = true;
    listaProductos = [];
    listaProductos = await RepositorioApi.getProductos(dato: _txtBusqueda, esferico: _txtEsferico, cilindrico: _txtCilindrico, diametro: _txtDiametro);
    cargandoProductos = false;
  }
}
