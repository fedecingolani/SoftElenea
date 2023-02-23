import 'package:flutter/material.dart';

class ArmadoPedido extends StatefulWidget {
  ArmadoPedido({Key? key}) : super(key: key);

  @override
  State<ArmadoPedido> createState() => _ArmadoPedidoState();
}

class _ArmadoPedidoState extends State<ArmadoPedido> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: const Text('BANDEJA 1'),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: const Text('BANDEJA2 '),
            ),
          ),
        ],
      ),
    );
  }
}
