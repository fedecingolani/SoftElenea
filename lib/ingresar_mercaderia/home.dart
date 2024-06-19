import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/ingresar_mercaderia/page/widget_carga.dart';
import 'package:robot_soft/medidas.dart';
import 'package:robot_soft/menu/menu.dart';

import '../config.dart';
import '../retirar_mercaderia/pages/busqueda_producto.dart';

class IngresarMercaderia extends StatefulWidget {
  const IngresarMercaderia({Key? key}) : super(key: key);

  @override
  State<IngresarMercaderia> createState() => _IngresarMercaderiaState();
}

class _IngresarMercaderiaState extends State<IngresarMercaderia> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Menu(),
        body: Center(
            child: Row(
          children: [
            context.watch<Config>().drawerMenu
                ? SizedBox(
                    width: context.watch<Config>().widthMenu,
                    height: double.infinity,
                    child: const Menu(),
                  )
                : Container(),
            space10,
            Expanded(
                child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 350, width: double.infinity, child: WidgetCargaDatos()),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                              )),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            )),
            space10
          ],
        )),
      ),
    );
  }
}
