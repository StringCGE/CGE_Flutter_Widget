import 'dart:async';

import 'package:avistador_3/controller/estado.dart';
import 'package:avistador_3/controller/util.dart';
import 'package:avistador_3/model/cls_avistamiento.dart';
import 'package:avistador_3/model/cls_usuario.dart';
import 'package:avistador_3/view_app/common/map/avistador_marker.dart';
import 'package:avistador_3/view_app/logged_in/flow_take_photo/flow_01_take_photo_widget.dart';
import 'package:avistador_3/view_app/logged_in/flow_view_garery/flow_01_gelery_widget.dart';
import 'package:avistador_3/view_app/logged_in/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatefulWidget{
  ClsAvistamiento? avistActual;
  final String tipoVista;
  final double initialZoom;
  MyMap({
    super.key,
    this.avistActual,
    this.tipoVista = "",
    this.initialZoom = 13.0,
  });

  MyMapState createState()=>MyMapState();
}
class MyMapState extends State<MyMap>{
  MapController _mapC = MapController();
  late StreamSubscription _subsMapC;

  //Posicion predeterminada de la app
  LatLng _posInicial = Util.cerroBlanco;//Cerro blanco
  LatLng get posInicial => _posInicial;
  //Posicion real actual
  DateTime _dtPosActual = DateTime(1995,04,14);
  LatLng? _posActual =  LatLng(-2.186202, -80.017624);
  //Posicion seleccionada en el mapa
  LatLng _posNavActual =     LatLng(-2.186202, -80.017624);
  //Posicion de vista actual
  LatLng _posNav =     LatLng(-2.186202, -80.017624);
  LatLng? _posGPS;

  LatLng get posNavActual => _posNavActual;
  set posNavActual(value){
    _posActual = value;
    //_mapC.move(posActual!, 13);
    setState(() {});
  }

  void navToPosActual(){
    navToPos(_posActual);
  }
  void navToPos(value){
    _mapC.move(value!, 13);
    setState(() {});
  }
  bool _dt_dif_seg(int seg) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(_dtPosActual);
    return difference.inSeconds <= seg;
  }

  LatLng get posActual{
    return _posActual??_posInicial;
  }

  LatLng get posActualInicial{
    if(_dt_dif_seg(15)) return _posActual??_posInicial;
    return _posInicial;
  }

  bool permitePuntoUbica(){
    bool resp = true;
    resp = resp && widget.tipoVista == "";
    return resp;
  }

  @override
  void initState(){
    super.initState();
    if(widget.tipoVista == "ViewInMap"){
      if(widget.avistActual != null){
        _posInicial = widget.avistActual!.gps??posActualInicial;
      }else{
        _posInicial = posActualInicial;
      }
    }else{
      _posInicial = posActualInicial;
    }
    _posActual = _posInicial;
    _subsMapC = _mapC.mapEventStream.listen((event) {
      switch(event.source.name){
        case 'tap':
          MapEventTap met = event as MapEventTap;
          if(widget.tipoVista != "ViewInMap"){
            _posActual = LatLng(met.tapPosition.latitude, met.tapPosition.longitude);
          }
          //navToPosActual();
          setState(() {});
          break;
      }
    });
    myInitState();
  }
  @override
  void didUpdateWidget(covariant MyMap oldWidget){
    super.didUpdateWidget(oldWidget);
    myInitState();
  }

  void myInitState(){
    _posGPS = Estado().gps.getCurrentLocation();
  }
  @override
  void dispose(){
    super.dispose();
    _subsMapC.cancel();
  }


  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: buildMap(context)
                    )
                  )
                ),
                Positioned(
                  bottom: 120,
                  right: 35,
                  child: FloatingActionButton(
                    onPressed: (){
                      navToPosActual();
                    },
                    child: Icon(Icons.location_on),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 35,
                  child: FloatingActionButton(
                    onPressed: (){
                      setPosGPS();
                    },
                    child: Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex:1,
                child: RoundedBoxWithIconAndText(
                  iconData: Icons.camera_alt, text: 'Foto',
                  onTap: (){
                    Util.navDropUpToWidget(
                      context: context,
                      next: ()=>TakePhotoWidget(),
                      settingName: "TakePhotoWidget",
                      settingArg: null,
                      stopWidgetName: 'HomeWidget',
                    );
                  },
                ),
              ),
              Expanded(
                flex:1,
                child:RoundedBoxWithIconAndText(
                  iconData: Icons.photo_library, text: 'Galeria',
                  onTap: (){
                    Util.navDropUpToWidget(
                      context: context,
                      next: ()=>Galery(),
                      settingName: "Galery",
                      settingArg: null,
                      stopWidgetName: 'HomeWidget',
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )
    );
  }


  void internSetPosGPS(){
    _dtPosActual = DateTime.now();
    _posGPS = Estado().gps.getCurrentLocation();
  }

  void setPosGPS() {
    internSetPosGPS();
    if(widget.tipoVista != "ViewInMap"){
      _posActual = _posGPS;
    }
    navToPos(_posGPS);
    if(mounted){
      setState(() {});
    }
  }

  Widget buildMap(BuildContext context){
    return FlutterMap(
      mapController: _mapC,
      options: MapOptions(
        initialCenter: posInicial,
        initialZoom: widget.initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          tileBuilder: (BuildContext c, Widget w, TileImage ti){
            return w;
          },
        ),
        if(widget.avistActual!=null)MarkerLayer(
          rotate: false,
          markers: [AvistamientoMarker(
            context: context,
            avistamiento: widget.avistActual??ClsAvistamiento(
              id:-1,
              rutaFoto: '',
              usuario: Estado().cLogin.sessionData!.clsUsuario,
              fecha: DateTime.now(),
              urlFoto: '',
              gps: LatLng(-2.187202, -80.017624),
              etiquetas: [],
              comentario: '',
              seSube: false,
              estaSubido: false,
              codigo: -1,
            ))],
        ),
        if(posActual != null && permitePuntoUbica())MarkerLayer(
          rotate: false,
          markers: [Util.punto_(posActual!)],
        ),
        if(_posGPS != null)MarkerLayer(
          rotate: false,
          markers: [Util.punto_(_posGPS!)],
        ),
        MarkerLayer(
          markers: [

          ],
        ),
      ],
    );
  }
/*
  Widget flutMap(BuildContext context){


    return FlutterMap(
      options: MapOptions(
        initialCenter: latl!,
        initialZoom: 13.0,
      ),
      mapController: mapCtrl,
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        if(false)PolylineLayer(
          polylines: [
            Polyline(
              points: lll,
              strokeWidth: 5.0,
              color: Colors.blue,
            ),
          ],
        ),
        if(false)MarkerLayer(
          rotate: false,
          markers: [
            for(LatLng sll in lll)puntoNoVisible(sll)
          ],
        ),
        if(latl != null)MarkerLayer(
          rotate: false,
          markers: [punto(latl!)],
        ),
        /*if(true)for(ClsAvistamiento avist in lAvistamiento)MarkerLayer(
          rotate: false,
          markers: [AvistamientoMarker(context: context, avistamiento: avist)],
        ),*/
      ],
    );
  }*/
}


