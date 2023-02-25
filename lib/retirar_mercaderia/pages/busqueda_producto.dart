import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tester_app/medidas.dart';
import 'package:tester_app/retirar_mercaderia/repositorio_api.dart';
import 'package:tester_app/retirar_mercaderia/retirar_mer_provider.dart';

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

  final TextEditingController _textBusqueda = TextEditingController();
  final TextEditingController _txtEsferico = TextEditingController();
  final TextEditingController _txtCilindrico = TextEditingController();
  final TextEditingController _txtDiametro = TextEditingController();

  @override
  void initState() {
    _textBusqueda.text = context.read<RetirarMerProvider>().txtBusqueda;
    _txtEsferico.text = context.read<RetirarMerProvider>().txtEsferico;
    _txtCilindrico.text = context.read<RetirarMerProvider>().txtCilindrico;
    _txtDiametro.text = context.read<RetirarMerProvider>().txtDiametro;

    _textBusqueda.addListener(() {
      print('Busqueda: ${_textBusqueda.text}');
      context.read<RetirarMerProvider>().txtBusqueda = _textBusqueda.text;
    });

    _txtEsferico.addListener(() {
      print('Esferico: ${_txtEsferico.text}');
      context.read<RetirarMerProvider>().txtEsferico = _txtEsferico.text;
    });

    _txtCilindrico.addListener(() {
      print('Cilindrico: ${_txtCilindrico.text}');
      context.read<RetirarMerProvider>().txtCilindrico = _txtCilindrico.text;
    });

    _txtDiametro.addListener(() {
      print('Diametro: ${_txtDiametro.text}');
      context.read<RetirarMerProvider>().txtDiametro = _txtDiametro.text;
    });

    super.initState();
  }

  @override
  void dispose() {
    _textBusqueda.dispose();
    _txtEsferico.dispose();
    _txtCilindrico.dispose();
    _txtDiametro.dispose();
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                width: 250,
                height: 35,
                child: TextField(
                  controller: _textBusqueda,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    suffixIcon: context.watch<RetirarMerProvider>().cargandoProductos ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()) : null,
                    border: InputBorder.none,
                  ),
                  onEditingComplete: () => context.read<RetirarMerProvider>().getListaProductos(),
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
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(220, 253, 236, 0)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Agrupados',
                    textAlign: TextAlign.center,
                  )),
              space60,
              const Text('Esférico: '),
              cajaTexto(controller: _txtEsferico),
              space20,
              space20,
              const Text('Cilíndrico: '),
              cajaTexto(controller: _txtCilindrico),
              space20,
              space20,
              const Text('Diamétro: '),
              cajaTexto(controller: _txtDiametro),
            ],
          ),
        ));
  }

  Container cajaTexto({required TextEditingController controller}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      width: 150,
      height: 35,
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onSubmitted: (value) async => context.read<RetirarMerProvider>().getListaProductos(),
      ),
    );
  }
}
