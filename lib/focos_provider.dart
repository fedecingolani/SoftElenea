import 'package:flutter/material.dart';

class FocoProvider extends ChangeNotifier {
  final FocusNode busqueda = FocusNode();

  final FocusNode esferico = FocusNode();
  final FocusNode cilindrico = FocusNode();
  final FocusNode diametro = FocusNode();

  final FocusNode stock = FocusNode();
  final FocusNode despacho = FocusNode();
  final FocusNode innerFocusNode = FocusNode();

  KeyEvent? currentKeyEvent;

  void dispose() {
    busqueda.dispose();
    esferico.dispose();
    cilindrico.dispose();
    diametro.dispose();
    stock.dispose();
    despacho.dispose();
    innerFocusNode.dispose();
    super.dispose();
  }

  void busquedaFocus() {
    busqueda.requestFocus();
    notifyListeners();
  }

  void esfericoFocus() {
    esferico.requestFocus();
    notifyListeners();
  }

  void cilindricoFocus() {
    cilindrico.requestFocus();
    notifyListeners();
  }

  void diametroFocus() {
    diametro.requestFocus();
    notifyListeners();
  }

  void stockFocus() {
    stock.requestFocus();
    notifyListeners();
  }

  void despachoFocus() {
    despacho.requestFocus();
    notifyListeners();
  }

  void requestFocus(String field) {
    if (field == 'busqueda') {
      busqueda.requestFocus();
    } else if (field == 'stock') {
      stock.requestFocus();
    } else if (field == 'despacho') {
      innerFocusNode.requestFocus();
    }
    notifyListeners();
  }

  void onKeyEvent(KeyEvent event) {
    currentKeyEvent = event;
    notifyListeners();
  }
}
