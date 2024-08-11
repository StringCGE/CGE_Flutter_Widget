import 'package:flutter/material.dart';

class FinishFlowWidget extends StatelessWidget{
  String type;
  String msg;
  FinishFlowWidget({
    required this.type,
    required this.msg,
  });
  @override
  Widget build(BuildContext context){
    switch(type){
      case 'errror':
        return buildError(context);
      case 'success':
        return buildSuccess(context);
    }
    return Scaffold(
      backgroundColor: Colors.white, // Fondo verde claro
      body: Center(
        child: Text("Olvido seleccionar el tipo de errror"),
      )
    );
  }
  Widget buildSuccess(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white, // Fondo verde claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green, // Color de fondo del círculo verde
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white, // Color del ícono de check blanco
                size: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              msg,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 128, 0), // Color del texto blanco
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildError(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent, // Fondo rojo claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.red, // Color de fondo del círculo rojo
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: Colors.white, // Color del ícono de error blanco
                size: 80,
              ),
            ),
            SizedBox(height: 20),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, // Color del texto blanco
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}