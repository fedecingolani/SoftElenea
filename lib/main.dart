import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/ingresar_mercaderia/home.dart';

import 'package:robot_soft/menu/menu.dart';
import 'package:robot_soft/retirar_mercaderia/home.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_despacho_provider.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_mer_provider.dart';
import 'package:robot_soft/config.dart';
import 'package:robot_soft/settings_page.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.windows) {
    WindowOptions windowOptions = const WindowOptions(
      title: 'Robot Picking',
      size: Size(800, 600),
      fullScreen: false,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      minimumSize: Size(800, 600),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();

      await windowManager.focus();
    });
    await windowManager.ensureInitialized();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Config()),
          ChangeNotifierProvider(create: (_) => RetirarMerProvider()),
          ChangeNotifierProvider(lazy: false, create: (_) => DespachoProvider()),
        ],
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Optica Elena',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark, primaryColorDark: Colors.amber.shade500, primarySwatch: Colors.amber),
              ),
              initialRoute: '/retirar_mercaderia',
              routes: {
                '/retirar_mercaderia': (context) => const RetirarMercaderia(),
                '/ingresar_mercaderia': (context) => const IngresarMercaderia(),
                '/settings': (context) => const SettingPage(),
              });
        });
  }
}
