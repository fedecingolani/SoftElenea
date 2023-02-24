import 'package:flutter/material.dart';

class DescuentoStock extends StatefulWidget {
  const DescuentoStock({Key? key}) : super(key: key);

  @override
  State<DescuentoStock> createState() => _DescuentoStockState();
}

class _DescuentoStockState extends State<DescuentoStock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: const Text('DESCUENTO STOCK'),
    );
  }
}
