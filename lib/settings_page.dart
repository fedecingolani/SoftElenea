import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tester_app/config.dart';
import 'package:tester_app/medidas.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController ipServerController = TextEditingController();
  TextEditingController timerDespacho = TextEditingController();
  TextEditingController widthMenu = TextEditingController();
  late SharedPreferences prefs;
  bool drawer = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        ipServerController.text = prefs.getString('ip_server') ?? '';
        widthMenu.text = prefs.getDouble('width_menu').toString();
        drawer = prefs.getBool('drawer') ?? false;
        timerDespacho.text = prefs.getInt('timer_despacho').toString();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    Config.init();
    ipServerController.dispose();
    timerDespacho.dispose();
    widthMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Config.IP_SERVER = ipServerController.text;
                      prefs.setString('ip_server', ipServerController.text);
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
                      prefs.setInt('timer_despacho', int.parse(timerDespacho.text));
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
                      prefs.setDouble('width_menu', double.parse(widthMenu.text));
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
                      prefs.setBool('drawer', value!);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
