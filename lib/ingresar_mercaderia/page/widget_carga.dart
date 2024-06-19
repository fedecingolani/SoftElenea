import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/medidas.dart';

import '../../config.dart';

class WidgetCargaDatos extends StatefulWidget {
  WidgetCargaDatos({Key? key}) : super(key: key);

  @override
  State<WidgetCargaDatos> createState() => _WidgetCargaDatosState();
}

class _WidgetCargaDatosState extends State<WidgetCargaDatos> {
  final _textBusqueda = TextEditingController();
  final _focusTextBusqueda = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              children: [
                context.watch<Config>().drawerMenu
                    ? Container()
                    : SizedBox(
                        child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Icon(Icons.menu),
                            )),
                      ),
                space10,
                const Text('Lectura: '),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  width: 250,
                  height: 35,
                  child: Stack(
                    children: [
                      TextField(
                        focusNode: _focusTextBusqueda,
                        controller: _textBusqueda,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          //suffix: context.watch<RetirarMerProvider>().cargandoProductos ? const CircularProgressIndicator() : const Text('F1'),
                          border: InputBorder.none,
                        ),
                        // onEditingComplete: () => context.read().getListaProductos().catchError(
                        //   (onError) {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$onError')));
                        //   },
                        // ),
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: context.watch<RetirarMerProvider>().cargandoProductos ? const CircularProgressIndicator() : const Text('F1'),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
