import 'package:avistador_3/controller/errror_notify.dart';
import 'package:avistador_3/view_app/common/my_container.dart';
import 'package:flutter/material.dart';

class ViewEditTextWidget extends StatefulWidget {
  final TextEditingController controller;
  final String nombre;
  final String placeholder;
  final Color backColor;
  final ErrrorNotify? err;

  const ViewEditTextWidget({
    Key? key,
    required this.controller,
    required this.nombre,
    required this.placeholder,
    required this.backColor,
    this.err,
  }) : super(key: key);

  @override
  ViewEditTextWidgetState createState() => ViewEditTextWidgetState();
}

class ViewEditTextWidgetState extends State<ViewEditTextWidget> {
  late TextEditingController _controller;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _errorMessage = widget.err?.msg;
  }

  @override
  void didUpdateWidget(covariant ViewEditTextWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller;
    }
    if (widget.err != oldWidget.err) {
      _errorMessage = widget.err?.msg;
    }
  }
  bool estaEditando = false;
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:[
              Expanded(
                child: Text(
                  widget.nombre,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),  // Permite el salto de línea
                  overflow: TextOverflow.visible,  // Muestra el texto en lugar de truncarlo
                  maxLines: null,  // Permite que el texto se expanda a tantas líneas como sea necesario
                ),
              ),
              IconButton(
                icon: Icon(estaEditando?Icons.visibility:Icons.edit),
                onPressed: (){
                  estaEditando = !estaEditando;
                  setState(() {});
                },
              ),
            ]
          ),
          estaEditando?TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              isDense: true,
              //border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 16, // Tamaño del texto ingresado
            ),
          ):Text(
            widget.controller.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,  // Permite el salto de línea
            overflow: TextOverflow.visible,  // Muestra el texto en lugar de truncarlo
            maxLines: null,  // Permite que el texto se expanda a tantas líneas como sea necesario
          ),
        ]
      )
    );
  }
}