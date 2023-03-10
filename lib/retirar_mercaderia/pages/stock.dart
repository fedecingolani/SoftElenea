import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:robot_soft/medidas.dart';
import 'package:robot_soft/retirar_mercaderia/retirar_despacho_provider.dart';

class DescuentoStock extends StatefulWidget {
  const DescuentoStock({Key? key}) : super(key: key);

  @override
  State<DescuentoStock> createState() => _DescuentoStockState();
}

class _DescuentoStockState extends State<DescuentoStock> {
  TextEditingController controller = TextEditingController();
  bool bajaStock = false;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    controller.addListener(() {
      context.read<DespachoProvider>().txtCodigoBarraStock = controller.text;
      if (controller.text.isEmpty) {
        context.read<DespachoProvider>().productoStock = null;
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space10,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              space10,
              const Text('Codigo Barra: '),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  width: 210,
                  height: 35,
                  child: TextField(
                    focusNode: _focusNode,
                    controller: controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onEditingComplete: () => context.read<DespachoProvider>().updateStock(controller.text, 1).catchError(
                      (onError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$onError')));
                      },
                    ),
                    // onEditingComplete: () async {
                    //   var a = await context.read<DespachoProvider>().updateStock(controller.text, 1).catchError(
                    //     (onError) {
                    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $onError')));
                    //     },
                    //   );
                    // },
                  ),
                ),
              ),
              Tooltip(
                message: 'Sube Stock',
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        bajaStock = false;
                      });
                    },
                    icon: Icon(
                      Icons.upload,
                      color: bajaStock == true ? Colors.grey : Theme.of(context).primaryColor,
                      size: 30,
                    )),
              ),
              Tooltip(
                message: 'Baja Stock',
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        bajaStock = true;
                      });
                    },
                    icon: Icon(
                      Icons.download,
                      color: bajaStock == false ? Colors.grey : Theme.of(context).primaryColor,
                      size: 30,
                    )),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilledButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(120, 255, 247, 0)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {},
                      child: Text(bajaStock == true ? 'Baja Stock' : 'Sube Stock')),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      context.watch<DespachoProvider>().productoStock?.nombre ?? 'Nombre Producto',
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Nueva Cantidad'),
                        Text(
                          context.watch<DespachoProvider>().productoStock?.cantidad.toString() ?? '',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Posición'),
                        Text(
                          context.watch<DespachoProvider>().productoStock?.posicion.toString() ?? '',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Gaveta'),
                        Text(
                          '${context.watch<DespachoProvider>().productoStock?.nroGaveta ?? ''}',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ubicación'),
                        Text(
                          context.watch<DespachoProvider>().productoStock?.codigoUbicacion ?? '',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
