import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/config.dart';
import 'package:robot_soft/medidas.dart';

import 'package:robot_soft/retirar_mercaderia/retirar_mer_provider.dart';

class BusquedaProducto extends StatefulWidget {
  const BusquedaProducto({
    Key? key,
    required this.focusForm,
    required this.focusTextBusqueda,
    required this.focusTextEsf,
    required this.focusTextCil,
    required this.focusTextDiam,
  }) : super(key: key);

  final FocusNode focusForm;
  final FocusNode focusTextBusqueda;
  final FocusNode focusTextEsf;
  final FocusNode focusTextCil;
  final FocusNode focusTextDiam;

  @override
  State<BusquedaProducto> createState() => _BusquedaProductoState();
}

class _BusquedaProductoState extends State<BusquedaProducto> {
  // final FocusNode _focusTextBusqueda = FocusNode();
  // final FocusNode _focusTextEsf = FocusNode();
  // final FocusNode _focusTextCil = FocusNode();
  // final FocusNode _focusTextDiam = FocusNode();

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
      context.read<RetirarMerProvider>().txtBusqueda = _textBusqueda.text;
    });

    _txtEsferico.addListener(() {
      context.read<RetirarMerProvider>().txtEsferico = _txtEsferico.text;
    });

    _txtCilindrico.addListener(() {
      context.read<RetirarMerProvider>().txtCilindrico = _txtCilindrico.text;
    });

    _txtDiametro.addListener(() {
      context.read<RetirarMerProvider>().txtDiametro = _txtDiametro.text;
    });

    widget.focusTextBusqueda.addListener(() {
      if (widget.focusTextBusqueda.hasFocus) {
        _textBusqueda.selection = TextSelection(baseOffset: 0, extentOffset: _textBusqueda.text.length);
      }
    });

    widget.focusTextCil.addListener(() {
      if (widget.focusTextCil.hasFocus) {
        _txtCilindrico.selection = TextSelection(baseOffset: 0, extentOffset: _txtCilindrico.text.length);
      }
    });
    widget.focusTextDiam.addListener(() {
      if (widget.focusTextDiam.hasFocus) {
        _txtDiametro.selection = TextSelection(baseOffset: 0, extentOffset: _txtDiametro.text.length);
      }
    });

    widget.focusTextEsf.addListener(() {
      if (widget.focusTextEsf.hasFocus) {
        _txtEsferico.selection = TextSelection(baseOffset: 0, extentOffset: _txtEsferico.text.length);
      }
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
    return Focus(
      focusNode: widget.focusForm,
      child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.watch<Config>().drawerMenu
                    ? Container()
                    : SizedBox(
                        child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Icon(Icons.menu),
                            )),
                      ),
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
                  child: Stack(
                    children: [
                      TextField(
                        focusNode: widget.focusTextBusqueda,
                        controller: _textBusqueda,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          //suffix: context.watch<RetirarMerProvider>().cargandoProductos ? const CircularProgressIndicator() : const Text('F1'),
                          border: InputBorder.none,
                        ),
                        onEditingComplete: () => context.read<RetirarMerProvider>().getListaProductos().catchError(
                          (onError) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$onError')));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: context.watch<RetirarMerProvider>().cargandoProductos ? const CircularProgressIndicator() : const Text('F1'),
                      )
                    ],
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
                      //backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(220, 253, 236, 0)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      String codigo = await dialogPedidos(context);
                      if (codigo != null) {
                        _textBusqueda.text = codigo;
                        // context.read<RetirarMerProvider>().getListaProductos().catchError(
                        //   (onError) {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$onError')));
                        //   },
                        // );
                      }
                    },
                    child: const Text(
                      'Agrupados',
                      textAlign: TextAlign.center,
                    )),
                space60,
                const Text('Esférico: '),
                cajaTexto(controller: _txtEsferico, focus: widget.focusTextEsf, tecla: 'F2'),
                space20,
                space20,
                const Text('Cilíndrico: '),
                cajaTexto(controller: _txtCilindrico, focus: widget.focusTextCil, tecla: 'F3'),
                space20,
                space20,
                const Text('Diamétro: '),
                cajaTexto(controller: _txtDiametro, focus: widget.focusTextDiam, tecla: 'F4'),
              ],
            ),
          )),
    );
  }

  Future<dynamic> dialogPedidos(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => SizedBox(
              height: 400,
              width: 300,
              child: AlertDialog(
                content: FutureBuilder(
                  future: context.read<RetirarMerProvider>().getPedidos(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    if (context.read<RetirarMerProvider>().listaPedidos.isNotEmpty) {
                      return ListView.builder(
                        itemCount: context.read<RetirarMerProvider>().listaPedidos.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = context.read<RetirarMerProvider>().listaPedidos[index];
                          return ListTile(
                            title: Text('${data.optica} - ${data.pedido}'),
                            onTap: () {
                              Navigator.of(context).pop(snapshot.data[index].codigo);
                            },
                          );
                        },
                      );
                    }
                    return const Text('No hay pedidos');
                  },
                ),
              ),
            ));
  }

  FocusableActionDetector action() {
    return FocusableActionDetector(
      child: Container(),
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.f2): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.f3): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.f4): const ActivateIntent(),
      },
    );
  }

  Container cajaTexto({required TextEditingController controller, required FocusNode focus, String tecla = ''}) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        width: 150,
        height: 35,
        child: Stack(children: [
          TextField(
            controller: controller,
            focusNode: focus,
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onEditingComplete: () => context.read<RetirarMerProvider>().getListaProductos().catchError(
              (onError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: No se pudo obtener la lista de productos. $onError')));
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(tecla),
          )
        ]));
  }
}
