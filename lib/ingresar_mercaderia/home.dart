import 'package:flutter/material.dart';
import 'package:tester_app/menu/menu.dart';

import '../config.dart';

class IngresarMercaderia extends StatefulWidget {
  const IngresarMercaderia({Key? key}) : super(key: key);

  @override
  State<IngresarMercaderia> createState() => _IngresarMercaderiaState();
}

class _IngresarMercaderiaState extends State<IngresarMercaderia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
        children: [
          SizedBox(
            width: Config.WIDTH_MENU,
            height: double.infinity,
            child: Menu(),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Container(),
            ),
          )
        ],
      )),
    );
  }
}
