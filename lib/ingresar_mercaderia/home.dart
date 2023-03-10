import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/ingresar_mercaderia/page/armado_ingreso.dart';
import 'package:robot_soft/menu/menu.dart';

import '../config.dart';

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
            Expanded(
                child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 75, width: double.infinity, child: Container()),
                    SizedBox(height: 375, width: double.infinity, child: Container()),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(height: 300, width: double.infinity, child: Container()),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(height: 300, width: double.infinity, child: Container()),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(height: 250, width: double.infinity, child: Container()),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(height: 250, width: double.infinity, child: Container()),
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
