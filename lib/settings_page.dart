import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:robot_soft/config.dart';
import 'package:robot_soft/medidas.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController ipServerController = TextEditingController();
  TextEditingController timerDespacho = TextEditingController();
  TextEditingController widthMenu = TextEditingController();

  bool drawer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ipServerController.dispose();
    timerDespacho.dispose();
    widthMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ipServerController.text = context.watch<Config>().serverIP;
    timerDespacho.text = context.watch<Config>().timerDespacho.toString();
    widthMenu.text = context.watch<Config>().widthMenu.toString();
    drawer = context.watch<Config>().drawerMenu;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración Sistema'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                space20,
                const SizedBox(width: 100, child: Text('Ip Server: ')),
                space10,
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: ipServerController,
                    decoration: const InputDecoration(
                      labelText: 'Ip Server',
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      context.read<Config>().setServerIP(ipServerController.text);
                    },
                    icon: const Icon(Icons.save))
              ],
            ),
            Row(
              //timer despacho
              children: [
                space20,
                const SizedBox(width: 100, child: Text('Timer Despacho: ')),
                space10,
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: timerDespacho,
                    decoration: const InputDecoration(),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      context.read<Config>().setTimerDespacho(int.parse(timerDespacho.text));
                    },
                    icon: const Icon(Icons.save))
              ],
            ),
            space20,
            Row(
              children: [
                space20,
                const SizedBox(width: 100, child: Text('Ancho Menu ')),
                space10,
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: widthMenu,
                    decoration: const InputDecoration(),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      context.read<Config>().setWidthMenu(double.parse(widthMenu.text));
                    },
                    icon: const Icon(Icons.save))
              ],
            ),
            space20,
            Row(
              children: [
                space20,
                const SizedBox(width: 100, child: Text('Drawer ')),
                space10,
                Checkbox(
                    value: drawer,
                    onChanged: (value) {
                      setState(() {
                        drawer = value!;
                      });
                      context.read<Config>().setDrawerMenu(drawer);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
