import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  Widget child;
  double? width;
  double? height;
  MyContainer({
    required this.child,
    this.width = double.infinity,
    this.height = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      //padding: EdgeInsets.only(top: 8, left:8, right: 8),
      margin: EdgeInsets.only(top: 8, left:8, right: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10), // Ajusta el radio según tu necesidad
        ),
        padding: EdgeInsets.only(top: 8, left:8, right: 8, bottom: 8),
        child: Container(
          child: child,
        ),
      ),
    );
  }
}