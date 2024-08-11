import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onPressed;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(icon, size: 50),
            onPressed: onPressed,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        Text(label),
      ],
    );
  }
}