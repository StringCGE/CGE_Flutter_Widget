import 'package:flutter/material.dart';

class MyPopupMenuButton extends StatefulWidget {
  List<Widget Function(void Function() overClose)> fChildren;
  Widget Function(Key key, void Function() overClose) fChild;
  MyPopupMenuButton({
    super.key,
    required this.fChild,
    required this.fChildren,
  });
  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {

  void initOverlayEntry(BuildContext context){
    if (overlayEntry != null){
      return;
    }else{
      int i = 0;
    }
    overlayEntry = OverlayEntry(
      builder: (context){
        final RenderBox renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox;
        final Offset buttonOffset = renderBox!.localToGlobal(Offset.zero);
        final Size buttonSize = renderBox!.size;
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: aCerrar,
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  menuuu(buttonOffset, buttonSize)
                ],
              )
            )
          ),
        );
      }
    );
  }

  Widget menuuu(Offset buttonOffset, Size buttonSize){
    List<Widget> wid = [];
    for(Widget Function(void Function() overClose) func in widget.fChildren){
      wid.add(func(aCerrar));
    }
    return Positioned(
      left: buttonOffset.dx,
      top: buttonOffset.dy + buttonSize.height,
      //width: 200, // width of the menu
      child: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: wid,
        ),
      )
    );
  }

  final GlobalKey _buttonKey = GlobalKey();
  OverlayEntry? overlayEntry;
  void aCerrar(){
    if (overlayEntry != null){
      overlayEntry!.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.fChild(_buttonKey, (){
      initOverlayEntry(context);
      bool bo = overlayEntry!.mounted;
      if(bo){
        aCerrar();
      }else{
        final overlay = Overlay.of(context);
        overlay.insert(overlayEntry!);
      }
    });
    /*return Center(
      child: RoundedButton(
        key: _buttonKey,
        onPressed: (){
          verItemMenu();
        },
        text: 'Open Menu',
      ),
    );*/
  }
}

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  RoundedButton({
    super.key,
    required this.onPressed,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}