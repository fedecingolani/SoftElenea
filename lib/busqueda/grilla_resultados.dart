import 'package:flutter/material.dart';

class ResultadoBusqueda extends StatefulWidget {
  const ResultadoBusqueda({Key? key}) : super(key: key);

  @override
  State<ResultadoBusqueda> createState() => _ResultadoBusquedaState();
}

class _ResultadoBusquedaState extends State<ResultadoBusqueda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Text('RESULTADO BUSQUEDA'),
    );
  }
}
