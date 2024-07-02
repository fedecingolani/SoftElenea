import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/medidas.dart';
import 'package:robot_soft/retirar_mercaderia/models/model_get_productos.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_despacho_provider.dart';

class DetalleDespacho extends StatefulWidget {
  const DetalleDespacho({Key? key}) : super(key: key);

  @override
  State<DetalleDespacho> createState() => _DetalleDespachoState();
}

class _DetalleDespachoState extends State<DetalleDespacho> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<DespachoProvider>().listaProductosDetalle;
    if (data.isEmpty) {
      return Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('No hay datos para mostrar')));
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      //child: Container(),
      child: Row(
        children: [
          Expanded(flex: 1, child: datelleProducto(data, context, 0)),
          Expanded(flex: 1, child: datelleProducto(data, context, 1)),
        ],
      ),
    );
  }

  Column datelleProducto(List<ModelGetProductos> data, BuildContext context, int index) {
    if (index == 1 && data.length == 1) {
      return Column();
    }
    return Column(
      children: [
        space10,
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 85,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    data[index].nombre,
                  ),
                )),
          ],
        ),
        space10,
        Row(
          children: [
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Esferico',
                  texto: data[index].esferico.trim(),
                )),
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Cilindrico',
                  texto: data[index].cilindrico.trim(),
                )),
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Diametro',
                  texto: data[index].diameter.trim(),
                )),
          ],
        ),
        space10,
        Row(
          children: [
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Codigo',
                  texto: data[index].codigoBarra.trim(),
                )),
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Gaveta',
                  texto: data[index].nroGaveta.toString().trim(),
                )),
            Expanded(
                flex: 1,
                child: cajaDatos(
                  context: context,
                  nombre: 'Ubicación',
                  texto: data[index].codigoUbicacion,
                )),
          ],
        ),
      ],
    );
  }

  Container cajaDatos({required BuildContext context, String nombre = '', String texto = ''}) {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 47,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(nombre),
          Text(texto),
        ],
      ),
    );
  }
}
