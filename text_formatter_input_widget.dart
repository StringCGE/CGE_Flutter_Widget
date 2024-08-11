import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class TextFormatterInputRawWidget extends StatefulWidget {
  final String placeholder;
  //final Color backColor;
  final TextEditingController tec;
  final List<TextInputFormatter> textInputFormatters;
  final Alignment alignment;
  const TextFormatterInputRawWidget({
    super.key,
    required this.tec,
    required this.placeholder,
    required this.textInputFormatters,
    this.alignment = Alignment.centerRight,
  });

  @override
  TextFormatterInputRawWidgetState createState()=>TextFormatterInputRawWidgetState();
}
class TextFormatterInputRawWidgetState extends State<TextFormatterInputRawWidget> {

  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            textF(),
            iconVal(),
          ],
        ),
      ],
    );
  }
  Widget textF(){
    return TextField(
      controller: widget.tec,
      inputFormatters: widget.textInputFormatters,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        border: InputBorder.none,
        alignLabelWithHint: false,
      ),
      onChanged: (text) {
        isValid = validateText(text);
        if(mounted){
          setState(() {});
        }
      },
    );
  }
  Widget iconVal(){
    if (isValid) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    }else {
      return IconButton(
        icon: Icon(Icons.cancel),
        color: Colors.red,
        onPressed: () {
          // Mostrar dialogo con el motivo de no validación
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error de validación"),
                content: Text("Aquí va el motivo por el que no se validó"),
                actions: [
                  TextButton(
                    child: Text("Cerrar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }
  bool validateText(String text) {
    return text.isNotEmpty;
  }
}