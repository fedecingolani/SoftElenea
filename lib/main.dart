import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/ingresar_mercaderia/home.dart';

import 'package:tester_app/menu/menu.dart';
import 'package:tester_app/retirar_mercaderia/home.dart';
import 'package:tester_app/retirar_mercaderia/retirar_despacho_provider.dart';
import 'package:tester_app/retirar_mercaderia/retirar_mer_provider.dart';
import 'package:tester_app/config.dart';
import 'package:tester_app/settings_page.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Config.init();
  if (defaultTargetPlatform == TargetPlatform.windows) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1900, 1080),
      center: true,
      fullScreen: false,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      minimumSize: Size(1400, 900),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();

      await windowManager.maximize();

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
          ChangeNotifierProvider(create: (_) => RetirarMerProvider()),
          ChangeNotifierProvider(create: (_) => DespachoProvider()),
        ],
        builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark, primaryColorDark: Colors.amber.shade500, primarySwatch: Colors.amber),
                ),
                initialRoute: '/retirar_mercaderia',
                routes: {
                  '/retirar_mercaderia': (context) => RetirarMercaderia(),
                  '/ingresar_mercaderia': (context) => IngresarMercaderia(),
                  '/settings': (context) => const SettingPage(),
                }));
  }
}
