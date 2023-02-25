import 'package:flutter/material.dart';

import 'package:tester_app/menu/menu.dart';

import 'package:tester_app/retirar_mercaderia/pages/despacho_detalle.dart';
import 'package:tester_app/retirar_mercaderia/pages/despacho.dart';
import 'package:tester_app/retirar_mercaderia/pages/armado_bandejas.dart';
import 'package:tester_app/retirar_mercaderia/pages/busqueda_producto.dart';
import 'package:tester_app/retirar_mercaderia/pages/busqueda_resultados.dart';
import 'package:tester_app/retirar_mercaderia/pages/stock.dart';
import 'package:tester_app/setting_init.dart';

class RetirarMercaderia extends StatefulWidget {
  RetirarMercaderia({Key? key}) : super(key: key);

  @override
  State<RetirarMercaderia> createState() => _RetirarMercaderiaState();
}

class _RetirarMercaderiaState extends State<RetirarMercaderia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DRAWER ? Menu() : null,
      body: Center(
          child: Row(
        children: [
          DRAWER
              ? const SizedBox(width: 0)
              : SizedBox(
                  width: WIDTH_MENU,
                  height: double.infinity,
                  child: Menu(),
                ),
          Expanded(
              child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 75, width: double.infinity, child: BusquedaProducto()),
                  const SizedBox(height: 375, width: double.infinity, child: BusquedaResultados()),
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(height: 250, width: double.infinity, child: ArmadoBandejas()),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(height: 250, width: double.infinity, child: Despacho()),
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
