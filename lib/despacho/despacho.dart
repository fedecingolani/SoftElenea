import 'package:flutter/material.dart';

class Despacho extends StatefulWidget {
  Despacho({Key? key}) : super(key: key);

  @override
  State<Despacho> createState() => _DespachoState();
}

class _DespachoState extends State<Despacho> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: const Text('DESPACHO'),
    );
  }
}
