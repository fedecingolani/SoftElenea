import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/medidas.dart';
import 'package:tester_app/retirar_mercaderia/models/models_getProductos.dart';
import 'package:tester_app/retirar_mercaderia/retirar_mer_provider.dart';

class ArmadoBandejas extends StatefulWidget {
  const ArmadoBandejas({Key? key}) : super(key: key);

  @override
  State<ArmadoBandejas> createState() => _ArmadoBandejasState();
}

class _ArmadoBandejasState extends State<ArmadoBandejas> {
  @override
  Widget build(BuildContext context) {
    List<ModelGetProductos> data = context.watch<RetirarMerProvider>().listaProductosFiltrados;
    print('armado bandeja');
    return Stack(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: data.isNotEmpty
                  ? SingleChildScrollView(
                      child: detalleBandeja(data, 0),
                    )
                  : const Text('BANDEJA 1 '),
            ),
          ),
          Expanded(
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: data.isNotEmpty && data.length > 1
                  ? SingleChildScrollView(
                      child: detalleBandeja(data, 1),
                    )
                  : const Text('BANDEJA 2 '),
            ),
          ),
        ],
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(120, 255, 247, 0)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {},
                    child: Text('Generar Despacho')),
              ],
            )),
      ),
    ]);
  }

  Column detalleBandeja(List<ModelGetProductos> data, int index) {
    String bandeja = index == 0 ? 'BANDEJA 1' : 'BANDEJA 2';
    return Column(
      children: [
        Center(
            child: Text(
          bandeja,
          style: const TextStyle(fontSize: 18),
        )),
        Divider(),
        Text(data[0].nombre),
        Divider(),
        Text('Cod. Barra: ${data[index].codigoBarra}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gaveta: ${data[index].nroGaveta.toString()}'),
            space20,
            Text('Ubicación: ${data[index].codigoUbicacion}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Posición: ${data[index].posicion.toString()}'),
            space20,
            Text('Cantidad: ${data[index].cantidad.toString()}'),
          ],
        ),
      ],
    );
  }
}
