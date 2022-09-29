import 'package:flutter/material.dart';
import 'package:newnoticias/models/articulo.model.dart';
import 'package:newnoticias/providers/articulos.provider.dart';
import 'package:newnoticias/widgets/card.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final articuloProvider = ArticuloProvider();
  late Future<List<ArticuloModel>> articulos;
  late TextEditingController searchController;

  @override
  void initState() {
    articulos = articuloProvider.obtenerArticulos('fotos');
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Noticias API"),
      ),
      body: FutureBuilder(
        future: articulos,
        builder: ((context, snapshot) {
          List<Widget> lista = [];
          // ignore: prefer_const_constructors

          if (snapshot.hasData) {
            lista.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Buscador Palabra Clave',
                    fillColor: Colors.white38,
                  ),
                ),
              ),
            );
            lista.add(
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      articulos = articuloProvider
                          .obtenerArticulos(searchController.text);
                    });
                  },
                  child: const Text('Buscar'),
                ),
              ),
            );
            snapshot.data?.forEach((element) => lista.add(CardWidget(
                  articulo: element,
                )));
            return Container(
              // Aquí se cambia el color de fondo de la aplicación.
              color: Color.fromARGB(255, 165, 182, 194),
              child: ListView(
                children: lista,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
