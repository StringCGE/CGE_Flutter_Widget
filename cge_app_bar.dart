import 'package:flutter/material.dart';

class CgeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> widLeft;
  final List<Widget> widCenter;
  final List<Widget> widRigth;
  final Color? backColor;
  final Color? shadowColor;
  final void Function() onSeeDrawer;

  const CgeAppBar({
    super.key,
    required this.widLeft,
    required this.widCenter,
    required this.widRigth,
    required this.onSeeDrawer,
    this.backColor,
    this.shadowColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  CgeAppBarState createState() => CgeAppBarState();
}

class CgeAppBarState extends State<CgeAppBar> {
  Color? backColor;
  Color? shadowColor;

  @override
  void initState() {
    super.initState();
    backColor = widget.backColor ?? const Color(0xff00ff00);
    shadowColor = widget.shadowColor ?? const Color(0xff0000ff);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: AppBar(
        titleSpacing: 0,
        toolbarHeight: 100,
        backgroundColor: backColor,
        shadowColor: shadowColor,
        //elevation: 10.0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            widget.onSeeDrawer();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.red), // Establecer el color deseado
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Acción al presionar el icono
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: Row(
                children: widget.widLeft,
              ),
            ),
            Expanded(
              child: Row(
                children: widget.widCenter,
              ),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: Row(
                children: widget.widRigth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}