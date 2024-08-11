import 'package:avistador_3/controller/errror_notify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String nombre;
  final String placeholder;
  final Color backColor;
  final ErrrorNotify? err;

  const TextInputWidget({
    Key? key,
    required this.controller,
    required this.nombre,
    required this.placeholder,
    required this.backColor,
    this.err,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            nombre,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        if(err != null)Text(err!.msg)
      ],
    );
  }
}



class PswInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String nombre;
  final String placeholder;
  final Color backColor;
  final ErrrorNotify? err;

  const PswInputWidget({
    Key? key,
    required this.controller,
    required this.nombre,
    required this.placeholder,
    required this.backColor,
    this.err,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            nombre,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: controller,
              obscureText: true, // Para ocultar los caracteres de la contraseña
              decoration: InputDecoration(
                hintText: placeholder,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        if(err != null)Text(err!.msg)
      ],
    );
  }
}


class ExecButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color color;
  final Color colorText;
  final double borderRadius;
  final double padding;

  const ExecButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.colorText = Colors.black,
    this.borderRadius = 8.0,
    this.padding = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: colorText,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        minimumSize: Size(double.infinity, 50.0),
        side: BorderSide(color: color, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: color, width: 2.0),
        ),
      ),
    );
  }
}


class DateInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String nombre;
  final String placeholder;
  final Color backColor;

  const DateInputWidget({
    Key? key,
    required this.controller,
    required this.nombre,
    required this.placeholder,
    required this.backColor,
  }) : super(key: key);

  @override
  DateInputWidgetState createState() => DateInputWidgetState();
}

class DateInputWidgetState extends State<DateInputWidget> {
  String fecha = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            widget.nombre,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.backColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fecha.isNotEmpty ? fecha : widget.placeholder,
                    /*style: TextStyle(
                      color: fecha.isNotEmpty ? Colors.black : Colors.grey,
                    ),*/
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      setState(() {
        fecha = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'; // Formato de fecha
        widget.controller.text = fecha; // Actualizar el controlador con la fecha
      });
    }
  }
}


class AnioTextField extends StatefulWidget {
  @override
  _AnioTextFieldState createState() => _AnioTextFieldState();
}

class _AnioTextFieldState extends State<AnioTextField> {
  TextEditingController _tec = TextEditingController();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _tec.addListener(() {
      if(mounted){
        setState(() {
          _isValid = _isValidYear(_tec.text);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _tec,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^([0-2]?[0-9]{0,3}|3000)?$')),
      ],
      decoration: InputDecoration(
        labelText: 'Ingrese un año (1900-3000)',
        errorText: _isValid ? null : 'Año debe estar entre 1900 y 3000',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isValid ? Colors.grey : Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _isValid ? Colors.blue : Colors.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  bool _isValidYear(String value) {
    if (value.isEmpty) {
      return true; // No hay error si el campo está vacío
    }
    int? year = int.tryParse(value);
    return year != null && year >= 1900 && year <= 3000;
  }

  @override
  void dispose() {
    _tec.dispose();
    super.dispose();
  }
}
