import 'package:avistador_3/model/cls_etiqueta.dart';
import 'package:flutter/material.dart';

class EtiquetaWidget extends StatelessWidget {
  final ClsEtiqueta eti;
  final double altura;
  final double ancho;
  final void Function(ClsEtiqueta value) onPressed;

  const EtiquetaWidget({
    Key? key,
    required this.eti,
    required this.onPressed,
    this.altura = 18.0,
    this.ancho = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5),
          Text(eti.name),
          SizedBox(width: 5),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              onPressed(eti);
            },
          ),
        ],
      ),
    );
  }
}

class EtiquetaDefaultWidget extends StatelessWidget {
  final ClsEtiquetaDefault etiDef;
  final double altura;
  final double ancho;
  final void Function(ClsEtiquetaDefault value) onPressed;

  const EtiquetaDefaultWidget({
    Key? key,
    required this.etiDef,
    required this.onPressed,
    this.altura = 18.0,
    this.ancho = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5),
          Text(etiDef.name),
          SizedBox(width: 5),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onPressed(etiDef);
            },
          ),
        ],
      ),
    );
  }
}

class ViewEtiquetaWidget extends StatelessWidget {
  final ClsEtiqueta eti;
  final double altura;
  final double ancho;
  final void Function(ClsEtiqueta value) onPressed;

  const ViewEtiquetaWidget({
    Key? key,
    required this.eti,
    required this.onPressed,
    this.altura = 18.0,
    this.ancho = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho,
      height: altura,
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(eti.name),
        ],
      ),
    );
  }
}