import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/config.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_despacho_provider.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_mer_provider.dart';

class Despacho extends StatefulWidget {
  const Despacho({required this.focusNode, Key? key}) : super(key: key);

  final FocusNode focusNode;

  @override
  State<Despacho> createState() => _DespachoState();
}

class _DespachoState extends State<Despacho> {
  Timer? timer;

  @override
  void initState() {
    int timerDespacho = context.read<Config>().timerDespacho;
    initGetData(timerDespacho);
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('dispose despacho');
    timer?.cancel();
    debugPrint('timer despacho cancelado: ${timer?.isActive}');
    super.dispose();
  }

  void initGetData(int timerDespacho) async {
    await context.read<DespachoProvider>().getListaDespacho().catchError(
      (onError) {
        if (mounted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: No se pudo obtener la lista de Despachos. $onError')));
          }
        }
      },
    );

    timer = Timer.periodic(Duration(seconds: timerDespacho), (timer) async {
      debugPrint('timer despacho activo: ${timer.isActive}');
      if (mounted == false) return;
      await context.read<DespachoProvider>().getListaDespacho().catchError(
        (onError) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: No se pudo obtener la lista de Despachos. $onError')));
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //bool cargando = context.watch<DespachoProvider>().cargandoDespachos;
    return Focus(
      focusNode: widget.focusNode,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: true == true ? Colors.red : Colors.green,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: dataTableDespachos(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Tooltip(
              message: 'Retirar Mercaderia',
              child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () => context.read<DespachoProvider>().armarDespachos(context.read<RetirarMerProvider>().listaProductosFiltrados).catchError((error) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Se produjo algun error. $error')));
                        }
                      }).whenComplete(() => context.read<DespachoProvider>().getListaDespacho()),
                  child: const Text('Retirar Mercaderia')),
            ),
          ),
        ),
      ]),
    );
  }

  Widget dataTableDespachos() {
    final datos = context.watch<DespachoProvider>().listaDespachos;
    if (datos.isEmpty) {
      return const Center(
        child: Text('No hay despachos para mostrar'),
      );
    }
    return DataTable2(
        headingRowHeight: 33,
        dataRowHeight: 25,
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 650,
        columns: const [
          DataColumn2(
            fixedWidth: 90,
            label: Text('Codigo'),
          ),
          DataColumn2(
            fixedWidth: 75,
            label: Text('Cantidad'),
          ),
          DataColumn2(
            fixedWidth: 75,
            label: Text('Origen'),
          ),
          DataColumn2(fixedWidth: 40, label: Text('')),
          DataColumn2(
            fixedWidth: 90,
            label: Text('Codigo'),
          ),
          DataColumn2(
            fixedWidth: 75,
            label: Text('Cantidad'),
          ),
          DataColumn2(
            fixedWidth: 75,
            label: Text('Origen'),
          ),
          DataColumn2(fixedWidth: 20, label: Text('')),
          DataColumn2(
            fixedWidth: 75,
            label: Text('Pedido'),
          ),
          DataColumn2(
            fixedWidth: 50,
            label: Text('Estado'),
          ),
        ],
        rows: datos
            .map((e) => DataRow(
                    onSelectChanged: (value) {
                      if (value == true) {
                        context.read<DespachoProvider>().idSeleccionado = e.idDespacho!;
                        context.read<DespachoProvider>().despachoSeleccionado(e).catchError(
                          (onError) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $onError')));
                            }
                          },
                        );
                      } else {
                        context.read<DespachoProvider>().idSeleccionado = -1;
                        context.read<DespachoProvider>().despachoSeleccionado(null);
                      }
                    },
                    selected: context.watch<DespachoProvider>().idSeleccionado == e.idDespacho,
                    color: cambiarColor(e.estado),
                    cells: [
                      DataCell(Text(e.codigoBarra1.toString())),
                      DataCell(Center(child: Text(e.cantidad1.toString()))),
                      DataCell(Text(e.origen1.toString())),
                      DataCell(Container(
                        width: 5,
                        height: 40,
                        color: Colors.black,
                      )),
                      DataCell(Text(e.codigoBarra2.toString())),
                      DataCell(Center(child: Text(e.cantidad2.toString()))),
                      DataCell(Text(e.origen2.toString())),
                      DataCell(Container(
                        width: 5,
                        height: 30,
                        color: Colors.black,
                      )),
                      DataCell(Center(child: Text(e.pedido.toString()))),
                      DataCell(
                        PopupMenuButton(
                          tooltip: 'Estado: ${verEstado(e.estado)}',
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (_) {
                            return [
                              PopupMenuItem(onTap: () => context.read<DespachoProvider>().cambiarEstado(e.idDespacho!, 0), value: 1, child: const Text('Inicio')),
                              PopupMenuItem(onTap: () => context.read<DespachoProvider>().cambiarEstado(e.idDespacho!, 2), value: 2, child: const Text('Cambio de Stock')),
                              PopupMenuItem(onTap: () => context.read<DespachoProvider>().cambiarEstado(e.idDespacho!, 3), value: 3, child: const Text('Finalizado')),
                            ];
                          },
                        ),
                      )
                      //DataCell(Text(((index + 0.1) * 25.4).toString()))
                    ]))
            .toList());
  }

  String verEstado(int? estado) {
    switch (estado) {
      case 0:
        return 'Inicio';
      case 1:
        return 'En Proceso';
      case 2:
        return 'Cambio de Stock';
      case 3:
        return 'Finalizado';
      default:
        return 'Inicio';
    }
  }

  MaterialStateProperty<Color?>? cambiarColor(int? estado) {
    switch (estado) {
      case 0:
        return null;
      case 1:
        return MaterialStateProperty.all(Colors.green);
      case 2:
        return MaterialStateProperty.all(Colors.red);
      default:
        return null;
    }
  }
}
