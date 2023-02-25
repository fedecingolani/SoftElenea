import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/retirar_mercaderia/retirar_mer_provider.dart';

class BusquedaResultados extends StatefulWidget {
  const BusquedaResultados({Key? key}) : super(key: key);

  @override
  State<BusquedaResultados> createState() => _BusquedaResultadosState();
}

class _BusquedaResultadosState extends State<BusquedaResultados> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<RetirarMerProvider>().listaProductos;
    print('dibuja pantalla resultados');
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            dataRowHeight: 25,
            columnSpacing: 12,
            horizontalMargin: 12,
            columns: const [
              DataColumn2(
                fixedWidth: 100,
                label: Text('CodBarra'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                fixedWidth: 100,
                label: Text('Gaveta'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                fixedWidth: 100,
                label: Text('Posición'),
                size: ColumnSize.S,
              ),
              DataColumn2(
                fixedWidth: 100,
                label: Text('Ubicación'),
              ),
              DataColumn2(
                fixedWidth: 100,
                label: Text('Cantidad'),
              ),
              DataColumn(
                label: Text('Nombre'),
              ),
            ],
            rows: data!
                .map((e) => DataRow(
                        onSelectChanged: (value) {
                          if (value == true && context.read<RetirarMerProvider>().listaProductosFiltrados.length == 2) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Solo se pueden seleccionar 2 productos')));
                            return;
                          }
                          context.read<RetirarMerProvider>().listaProductosFiltrados.contains(e) ? context.read<RetirarMerProvider>().removeProductoFiltrado(e) : context.read<RetirarMerProvider>().addProductoFiltrado(e);
                          setState(() {
                            print('seleccionado: ${e.codigoBarra}');
                          });
                        },
                        selected: context.watch<RetirarMerProvider>().listaProductosFiltrados.contains(e),
                        cells: [
                          DataCell(Text(e.codigoBarra)),
                          DataCell(Text('${e.nroGaveta}')),
                          DataCell(Text('${e.posicion}')),
                          DataCell(Text(e.codigoUbicacion)),
                          DataCell(Text(e.cantidad.toString())),
                          DataCell(Text(e.nombre)),
                        ]))
                .toList()),
      ),
    );
  }
}
