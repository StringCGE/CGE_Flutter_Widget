import 'package:avistador_3/controller/util.dart';
import 'package:avistador_3/model/cls_avistamiento.dart';
import 'package:avistador_3/view_app/logged_in/flow_view_garery/flow_02_view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AvistamientoMarker extends Marker {
  final ClsAvistamiento avistamiento;
  BuildContext context;
  AvistamientoMarker({
    Key? key,
    required this.context,
    required this.avistamiento,
    double width = 90,
    double height = 150,
    Alignment? alignment,
    bool? rotate,
  }) : super(
    key: key,
    point: _calPoint(avistamiento),
    child: _wid(context, avistamiento),
    width: width,
    height: height,
    alignment: alignment,
    rotate: rotate,
  ) {

  }

  static Widget _wid(BuildContext context, ClsAvistamiento avistamiento) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 40,//40 a 70
            child: Icon(Icons.pin_drop, size: 40.0, color: Colors.red),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent, // Color del borde
                      width: 3, // Ancho del borde
                    ),
                  ),
                  child: InkWell(
                    onTap: (){
                      Util.nav(
                          context: context,
                          next: () => ViewPhotoWidget(avistamiento: avistamiento),
                          settingName: 'ViewPhotoWidget',
                          settingArg: null
                      );
                    },
                    child: ClipOval(
                      child: Util.viewPhoto(avistamiento.rutaFoto),
                    ),
                  )
              )
          ),
        ],
      ),
    );
  }

  static LatLng _calPoint(ClsAvistamiento avistamiento) {
    double latitude = 0;
    double longitude = 0;
    if(avistamiento.gps != null){
      latitude = avistamiento.gps!.latitude;
      longitude = avistamiento.gps!.longitude;
    }
    return LatLng(latitude, longitude);
  }
}