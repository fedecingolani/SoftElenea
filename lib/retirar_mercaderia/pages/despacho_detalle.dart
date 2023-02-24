import 'package:flutter/material.dart';

class DetalleDespacho extends StatefulWidget {
  const DetalleDespacho({Key? key}) : super(key: key);

  @override
  State<DetalleDespacho> createState() => _DetalleDespachoState();
}

class _DetalleDespachoState extends State<DetalleDespacho> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: const Text('DETALLE DESPACHO'),
    );
  }
}
