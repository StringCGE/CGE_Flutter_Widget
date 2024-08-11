import 'package:flutter/material.dart';

class HomeMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const HomeMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                icon,
                size: 30.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}