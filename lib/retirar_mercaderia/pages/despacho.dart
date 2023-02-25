import 'package:data_table_2/paginated_data_table_2.dart';
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
      child: DataTable2(
          dataRowHeight: 25,
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: const [
            DataColumn2(
              fixedWidth: 100,
              label: Text('CodBarra'),
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
          rows: List<DataRow>.generate(
              100,
              (index) => DataRow(cells: [
                    DataCell(Text('A' * (10 - index % 10))),

                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('Daaaaaaa' * (15 - (index + 10) % 10))),
                    //DataCell(Text(((index + 0.1) * 25.4).toString()))
                  ]))),
    );
  }
}
