import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends ChangeNotifier {
  String ipServer = 'http://179.42.160.161:8080/rpeapi';
  String get serverIP => ipServer;
  Future<void> setServerIP(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip_server', value);
    ipServer = value;
    notifyListeners();
  }

  double _widthMenu = 275;
  double get widthMenu => _widthMenu;
  Future<void> setWidthMenu(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('width_menu', value);
    _widthMenu = value;
    notifyListeners();
  }

  bool _drawer = false;
  bool get drawerMenu => _drawer;
  Future<void> setDrawerMenu(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('drawer', value);
    _drawer = value;
    notifyListeners();
  }

  int _timerDespacho = 10;
  int get timerDespacho => _timerDespacho;
  Future<void> setTimerDespacho(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('timer_despacho', value);
    _timerDespacho = value;
    notifyListeners();
  }

  Config() {
    initConfig();
  }

  Future<void> initConfig() async {
    debugPrint('Proceso de inicialización de Config');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ipServer = prefs.getString('ip_server') ?? 'http://179.42.160.161:8080/rpeapi';
    _widthMenu = prefs.getDouble('width_menu') ?? 275;
    _drawer = prefs.getBool('drawer') ?? false;
    _timerDespacho = prefs.getInt('timer_despacho') ?? 10;
  }
}
