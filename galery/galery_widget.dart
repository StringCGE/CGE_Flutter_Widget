import 'dart:async';
import 'package:avistador_3/view_app/common/galery/GaleryRowWidget.dart';
import 'package:flutter/material.dart';

import 'GaleryItem.dart';
import 'GaleryRowItems.dart';

class GaleryWidgetIntern extends StatefulWidget{
  final double width;
  final double height;
  final int imgColumns;
  final Widget Function(GaleryItem item) itemWid;
  final Widget? Function(GaleryItem item) separador;
  final Widget Function() notFountData;
  final Future<List<GaleryItem>> Function(int lastIndex, int countData) fech;
  final Color backColor;
  GaleryWidgetIntern({
    required this.width,
    required this.height,
    required this.imgColumns,
    required this.itemWid,
    required this.separador,
    required this.notFountData,
    required this.fech,
    required this.backColor,
  });
  GaleryWidgetInternState createState()=>GaleryWidgetInternState();
}

class GaleryWidgetInternState extends State<GaleryWidgetIntern>{
  late StreamSubscription _subsEstado;
  ScrollController _scrollController = ScrollController();
  final List<GaleryItem> items = [];
  int countData = 30;
  Size imgSize = Size(30,30);
  @override
  void initState() {
    super.initState();
    gri = creaGri();
    myInitState();
  }
  void myInitState() {
    double w = widget.width/widget.imgColumns;
    imgSize = Size(w ,w);
    int rowsImg = (widget.height/w).toInt();
    countData = (rowsImg+1)*widget.imgColumns;
    _scrollController.addListener(_scrollListener);
    fechItems();
  }
  @override
  void didUpdateWidget(covariant GaleryWidgetIntern oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  List<Widget> _row =[];
  GaleryRowItems creaGri(){
    return GaleryRowItems<GaleryItem>(
      max: widget.imgColumns,
      creaNull: () {
        return GaleryItem(id: -1, isNull: true);
      },
    );
  }
  late GaleryRowItems gri;
  void creaRows2(){
    _row.clear();
    gri = creaGri();
    items.forEach((GaleryItem item) {
      lastIndex = item.id;
      Widget? sep = widget.separador(item);
      if(sep != null){
        addInGri();
        _row.add(sep);
      }
      if (!gri.add(item)){
        addInGri();
        gri.add(item);
      }
    });
    addInGri();
  }
  void addInGri(){
    if(gri.isNotEmpty()){
      _row.add(GaleryRowWidget(
        gri: gri,
        itemWid: widget.itemWid,
        height: imgSize.height,
      ));
      gri = creaGri();
    }
  }
  int lastIndex = -1;
  @override
  Widget build(BuildContext context){
    creaRows2();
    if(_row.isEmpty){
      return widget.notFountData();
    }
    return Container(
        color: widget.backColor,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _row.length,
          itemBuilder: (BuildContext context, int index){
            return _row[index];
          },
        )
    );
  }
  void _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fechItems();
    }
  }
  void fechItems() async{
    List<GaleryItem> nuevosDatos = await widget.fech(lastIndex, countData);
    items.addAll(nuevosDatos);
    setState(() {});
  }
}