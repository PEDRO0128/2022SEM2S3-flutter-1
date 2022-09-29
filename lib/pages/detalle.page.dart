import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/articulo.model.dart';

class DetallePage extends StatelessWidget {
  DetallePage({super.key, required this.articulo});

  ArticuloModel articulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(articulo.title)),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                articulo.title,
                style: GoogleFonts.newsreader(
                    fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  Text('Publicado por: ', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                      '${articulo.author}, Fecha de publicación: ${articulo.publishedAt.split('T')[0]}'),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              Html(
                data:
                    "<img src=${articulo.urlToImage} alt='&#128247;No image' style='width:100%'/>",
              ),
              Expanded(
                child: Text(
                  articulo.content,
                   style: GoogleFonts.newsreader(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
