import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:tester_app/menu/menu.dart';
import 'package:tester_app/retirar_mercaderia/home.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1900, 1080),
      center: true,
      fullScreen: false,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      minimumSize: Size(1400, 800),
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark, primarySwatch: Colors.blue),
        ),
        initialRoute: '/retirar_mercaderia',
        routes: {
          '/retirar_mercaderia': (context) => RetirarMercaderia(),
          '/ingresar_mercaderia': (context) => Container(),
        });
  }
}
