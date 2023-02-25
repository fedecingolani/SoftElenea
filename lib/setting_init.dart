import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String IP_SERVER = '';
double WIDTH_MENU = 275;
bool DRAWER = false;

class SettingInit {
  static Future<void> init() async {
    IP_SERVER = await SharedPreferences.getInstance().then((value) => value.getString('ip_server') ?? '');
    WIDTH_MENU = await SharedPreferences.getInstance().then((value) => value.getDouble('width_menu') ?? 275);
    DRAWER = await SharedPreferences.getInstance().then((value) => value.getBool('drawer') ?? false);
    DRAWER = false;
  }
}
