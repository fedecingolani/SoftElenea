import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/retirar_mercaderia/retirar_mer_provider.dart';

class DetalleDespacho extends StatefulWidget {
  const DetalleDespacho({Key? key}) : super(key: key);

  @override
  State<DetalleDespacho> createState() => _DetalleDespachoState();
}

class _DetalleDespachoState extends State<DetalleDespacho> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Text(context.watch<RetirarMerProvider>().listaProductosFiltrados.length.toString()),
    );
  }
}
