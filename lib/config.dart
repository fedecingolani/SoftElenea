import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static String IP_SERVER = 'http://179.42.160.161:8080/rpeapi';
  static double WIDTH_MENU = 275;
  static bool DRAWER = false;
  static int TIMER_DESPACHO = 10;

  static Future<void> init() async {
    print('Proceso de inicialización de Config');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    IP_SERVER = prefs.getString('ip_server') ?? 'http://179.42.160.161:8080/rpeapi';
    WIDTH_MENU = prefs.getDouble('width_menu') ?? 275;
    DRAWER = prefs.getBool('drawer') ?? false;
    TIMER_DESPACHO = prefs.getInt('timer_despacho') ?? 10;
    DRAWER = true;
  }
}
