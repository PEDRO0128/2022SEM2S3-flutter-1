import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/articulo.model.dart';

class ArticuloProvider {
  Future<List<ArticuloModel>> obtenerArticulos(String q) async {
    List<ArticuloModel> articulos = [];
    var client = http.Client();

    try {
      Map<String, String> parametros = {
        'q': q,
        'from': '2022-09-28',
        'sortBy': 'publishedAt',
        'apiKey': 'cacba66607fb4aee95d6543bde44e0e7',
      };

      var url = Uri.https('newsapi.org', 'v2/everything', parametros);
      var response = await http.get(url);
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      decodedResponse["articles"]
          .forEach((e) => articulos.add(ArticuloModel.fromJson(e)));

      return articulos;
    } finally {
      client.close();
    }
  }
}
