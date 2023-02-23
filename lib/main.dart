import 'package:flutter/material.dart';
import 'package:tester_app/busqueda/busqueda.dart';
import 'package:tester_app/despacho/despacho.dart';
import 'package:tester_app/despacho/detalle_despacho.dart';
import 'package:tester_app/pedido/armado_pedido.dart';
import 'package:tester_app/stock/stock.dart';
import 'package:window_manager/window_manager.dart';

import 'busqueda/grilla_resultados.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

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
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          SizedBox(
            width: 300,
            height: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: const Text('MENU'),
            ),
          ),
          Expanded(
              child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 75, width: double.infinity, child: CuadroBusqueda()),
                  const SizedBox(height: 300, width: double.infinity, child: ResultadoBusqueda()),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(height: 300, width: double.infinity, child: ArmadoPedido()),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(height: 300, width: double.infinity, child: Despacho()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(height: 300, width: double.infinity, child: DescuentoStock()),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(height: 300, width: double.infinity, child: DetalleDespacho()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
