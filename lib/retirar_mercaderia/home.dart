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
  final _focusBusquedaProducto = FocusNode();
  final _focusTextBusqueda = FocusNode();
  final _focusTextEsf = FocusNode();
  final _focusTextCil = FocusNode();
  final _focusTextDiam = FocusNode();

  final _focusStock = FocusNode();
  final _focusDetalleDespacho = FocusNode();

  final _busquedaResultado = FocusNode();
  final _armadoBandejas = FocusNode();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusTextBusqueda.requestFocus();

    _focusDetalleDespacho.addListener(() {
      if (_focusDetalleDespacho.hasFocus) {
        print('focus detalle despacho');
      }
    });

    super.initState();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.f1) {
      _focusTextBusqueda.requestFocus();
    }
    if (event.logicalKey == LogicalKeyboardKey.f2) {
      _focusTextEsf.requestFocus();
    }
    if (event.logicalKey == LogicalKeyboardKey.f3) {
      _focusTextCil.requestFocus();
    }
    if (event.logicalKey == LogicalKeyboardKey.f4) {
      _focusTextDiam.requestFocus();
    }
    if (event.logicalKey == LogicalKeyboardKey.f5) {
      _focusStock.requestFocus();
    }

    return event.logicalKey == LogicalKeyboardKey.f1 ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return SafeArea(
      child: Focus(
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
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
                      SizedBox(
                          height: 75,
                          width: double.infinity,
                          child: BusquedaProducto(
                            focusForm: _focusBusquedaProducto,
                            focusTextBusqueda: _focusTextBusqueda,
                            focusTextEsf: _focusTextEsf,
                            focusTextCil: _focusTextCil,
                            focusTextDiam: _focusTextDiam,
                          )),
                      SizedBox(
                        height: 375,
                        width: double.infinity,
                        child: BusquedaResultados(
                          focus: _busquedaResultado,
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
                                  focus: _armadoBandejas,
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Despacho(
                                  focusNode: _focusDetalleDespacho,
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
                                  focusTextStock: _focusStock,
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
      ),
    );
  }
}
