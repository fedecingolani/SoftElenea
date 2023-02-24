import 'package:flutter/material.dart';
import 'package:tester_app/medidas.dart';

class BusquedaProducto extends StatefulWidget {
  const BusquedaProducto({Key? key}) : super(key: key);

  @override
  State<BusquedaProducto> createState() => _BusquedaProductoState();
}

class _BusquedaProductoState extends State<BusquedaProducto> {
  final FocusNode _focusTextBusqueda = FocusNode();
  final FocusNode _focusTextEsf = FocusNode();
  final FocusNode _focusTextCil = FocusNode();
  final FocusNode _focusTextDiam = FocusNode();

  TextEditingController _textBusqueda = TextEditingController();
  TextEditingController _textEsf = TextEditingController();
  TextEditingController _textCil = TextEditingController();
  TextEditingController _textDiam = TextEditingController();

  @override
  void initState() {
    _textBusqueda.addListener(() {
      print('Busqueda: ${_textBusqueda.text}');
    });
    super.initState();
  }

  @override
  void dispose() {
    _textBusqueda.dispose();
    _textEsf.dispose();
    _textCil.dispose();
    _textDiam.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space10,
              const Text('Busqueda: '),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: 250,
                height: 35,
                child: RawKeyboardListener(
                  focusNode: _focusTextBusqueda,
                  onKey: (input) => debugPrint("*****KEY PRESSED ${input.physicalKey} "),
                  child: TextField(
                    controller: _textBusqueda,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              space20,
              FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(120, 255, 247, 0)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Agrupados',
                    textAlign: TextAlign.center,
                  )),
              space20,
              space20,
              space20,
              const Text('Esférico: '),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: 150,
                height: 35,
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              space20,
              space20,
              const Text('Cilíndrico: '),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: 150,
                height: 35,
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              space20,
              space20,
              const Text('Diamétro: '),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: 150,
                height: 35,
                child: const TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
