import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.85), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            child: const Center(child: Text('OPTICA ELENA')),
          ),
          ListTile(
            leading: const Icon(Icons.output),
            title: const Text('Retirar Mercaderia'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/retirar_mercaderia');
            },
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Ingresar Mercaderia'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ingresar_mercaderia');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Busqueda'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/busqueda');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Stock'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/stock');
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuracion'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          const Center(child: Text('Version 1.0.0 - Darkflow SRL')),
        ],
      ),
    );
  }
}
