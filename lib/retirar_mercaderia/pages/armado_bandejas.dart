import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/medidas.dart';

import '../retirar_despacho_provider.dart';
import '../retirar_mer_provider.dart';

import '../models/model_get_productos.dart';

class ArmadoBandejas extends StatefulWidget {
  const ArmadoBandejas({Key? key}) : super(key: key);

  @override
  State<ArmadoBandejas> createState() => _ArmadoBandejasState();
}

class _ArmadoBandejasState extends State<ArmadoBandejas> {
  @override
  Widget build(BuildContext context) {
    var data = context.watch<RetirarMerProvider>().listaProductosFiltrados;
    debugPrint('Dibuja ArmadoBandejas');
    return Stack(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 230,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: data.isNotEmpty
                  ? SingleChildScrollView(
                      child: detalleBandeja(data, 0),
                    )
                  : const Center(child: Text('BANDEJA 1 SIN PRODUCTOS')),
            ),
          ),
          Expanded(
            child: Container(
              height: 230,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              child: data.isNotEmpty && data.length > 1
                  ? SingleChildScrollView(
                      child: detalleBandeja(data, 1),
                    )
                  : const Center(child: Text('BANDEJA 2 SIN PRODUCTOS')),
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
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Tooltip(
                  message: 'Generar Despacho',
                  child: FilledButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(120, 255, 247, 0)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () => context.read<DespachoProvider>().armarDespachos(context.read<RetirarMerProvider>().listaProductosFiltrados).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error')));
                          }).whenComplete(() => context.read<DespachoProvider>().getListaDespacho()),
                      child: const Text('Generar Despacho')),
                ),
              ],
            )),
      ),
    ]);
  }

  Column detalleBandeja(List<ModelGetProductos> data, int index) {
    String bandeja = index == 0 ? 'BANDEJA 1' : 'BANDEJA 2';
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              bandeja,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  context.read<RetirarMerProvider>().eliminarProductoBandeja(index);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                ))
          ],
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(data[0].nombre),
        ),
        const Divider(),
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
