import 'package:avistador_3/view_app/common/galery/GaleryRowItems.dart';
import 'package:flutter/material.dart';

import 'GaleryItem.dart';

class GaleryRowWidget extends StatelessWidget{
  final GaleryRowItems gri;
  final Widget Function(GaleryItem item) itemWid;
  final double height;
  GaleryRowWidget({
    required this.gri,
    required this.itemWid,
    required this.height,
  }) {
    int count = gri.lItem.length;
    for(int i = count; i<gri.max; i++){
      gri.addNull();
    }
  }

  @override
  Widget build(BuildContext context){
    List<Widget> lWid = [];
    gri.lItem.forEach((item) {
      lWid.add(Expanded(
        flex: 1,
        child: itemWid(item),
      ));
    });
    return Container(
      height: height,
      child: Row(
        children: lWid,
      ),
    );
  }
}