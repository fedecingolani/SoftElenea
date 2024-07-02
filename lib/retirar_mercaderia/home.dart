import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/focos_provider.dart';

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
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // _focusTextBusqueda.requestFocus();

    // _focusDetalleDespacho.addListener(() {
    //   if (_focusDetalleDespacho.hasFocus) {
    //     print('focus detalle despacho');
    //   }
    // });

    super.initState();

    HardwareKeyboard.instance.addHandler((event) {
      final focusManager = context.read<FocoProvider>();
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.f1) {
          focusManager.busquedaFocus();
        } else if (event.logicalKey == LogicalKeyboardKey.f2) {
          focusManager.esfericoFocus();
        } else if (event.logicalKey == LogicalKeyboardKey.f3) {
          focusManager.cilindricoFocus();
        } else if (event.logicalKey == LogicalKeyboardKey.f4) {
          focusManager.diametroFocus();
        }
      }
      return false;
    });
  }

  // KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
  //   if (event.logicalKey == LogicalKeyboardKey.f1) {
  //     _focusTextBusqueda.requestFocus();
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.f2) {
  //     _focusTextEsf.requestFocus();
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.f3) {
  //     _focusTextCil.requestFocus();
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.f4) {
  //     _focusTextDiam.requestFocus();
  //   }
  //   if (event.logicalKey == LogicalKeyboardKey.f5) {
  //     _focusStock.requestFocus();
  //   }

  //   return event.logicalKey == LogicalKeyboardKey.f1 ? KeyEventResult.handled : KeyEventResult.ignored;
  // }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
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
                    SizedBox(
                      height: 375,
                      width: double.infinity,
                      child: BusquedaResultados(
                        focus: FocusNode(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: ArmadoBandejas(
                                focus: FocusNode(),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Despacho(
                                focusNode: FocusNode(),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: DescuentoStock(
                                focusTextStock: FocusNode(),
                              )),
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
