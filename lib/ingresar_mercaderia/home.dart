import 'package:flutter/material.dart';
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
        appBar: AppBar(),
        drawer: const Menu(),
        body: Column(
          children: [
            SizedBox(
              height: 400,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 11, 192, 137).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container()),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        // decoration: BoxDecoration(
                        //   color: Color.fromARGB(255, 11, 192, 137).withOpacity(0.2),
                        //   borderRadius: BorderRadius.circular(10),
                        // ),
                        child: GridView.count(
                          crossAxisCount: 63,
                          childAspectRatio: 1,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          children: List.generate(
                              1197,
                              (index) => GestureDetector(
                                    onSecondaryTap: () => print('right click'),
                                    child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 42, 9, 152).withOpacity(0.2),
                                        ),
                                        child: Container()),
                                  )),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          height: double.infinity,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 42, 9, 152).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container())),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: double.infinity,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 42, 9, 152).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        child: Text('hola'),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
