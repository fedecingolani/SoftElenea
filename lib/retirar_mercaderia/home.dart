import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:robot_soft/menu/menu.dart';

import 'package:robot_soft/retirar_mercaderia/pages/despacho_detalle.dart';
import 'package:robot_soft/retirar_mercaderia/pages/despacho.dart';
import 'package:robot_soft/retirar_mercaderia/pages/armado_bandejas.dart';
import 'package:robot_soft/retirar_mercaderia/pages/busqueda_producto.dart';
import 'package:robot_soft/retirar_mercaderia/pages/busqueda_resultados.dart';
import 'package:robot_soft/retirar_mercaderia/pages/stock.dart';
import 'package:robot_soft/config.dart';

class RetirarMercaderia extends StatefulWidget {
  const RetirarMercaderia({Key? key}) : super(key: key);

  @override
  State<RetirarMercaderia> createState() => _RetirarMercaderiaState();
}

class _RetirarMercaderiaState extends State<RetirarMercaderia> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
                          child: SizedBox(height: 300, width: double.infinity, child: ArmadoBandejas()),
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
                          child: SizedBox(height: 250, width: double.infinity, child: DescuentoStock()),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(height: 250, width: double.infinity, child: DetalleDespacho()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
