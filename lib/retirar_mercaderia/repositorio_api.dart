import 'package:tester_app/retirar_mercaderia/models/models_getProductos.dart';

import 'package:http/http.dart' as http;

class RepositorioApi {
  static Future<List<ModelGetProductos>?> getProductos({required String dato, required String esferico, required String cilindrico, required String diametro}) async {
    final String dat = dato.replaceAll(" ", ";");

    final String url = 'http://179.42.160.161:8080/rpeapi/api/UbicacionBusqueda?texto=$dat&esferico=$esferico&cilindrico=$cilindrico&diameter=$diametro';

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data = modelGetProductosFromJson(response.body);

      return data.sublist(0, data.length > 100 ? 100 : data.length);
    } else {
      return null;
    }
  }
}
