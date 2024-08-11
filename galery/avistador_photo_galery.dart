import 'dart:io';

import 'package:avistador_3/controller/util.dart';
import 'package:avistador_3/model/cls_avistamiento.dart';
import 'package:avistador_3/view_app/logged_in/flow_view_garery/flow_02_view_photo.dart';
import 'package:flutter/material.dart';

class AvistadorPhotoGalery extends StatelessWidget {
  final ClsAvistamiento avist;

  AvistadorPhotoGalery({required this.avist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Util.nav(
          context: context,
          next: () => ViewPhotoWidget(avistamiento: avist),
          settingName: 'ViewPhotoWidget',
          settingArg: null,
        );
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(avist.rutaFoto),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          if (avist.seSube)Positioned(
            top: 0,
            right: 0,
            child: Icon(
              Icons.cloud,
              size: 25,
              color: Colors.white,
            ),
          ),
          if (avist.seSube)Positioned(
            top: 3,
            right: 3,
            child: Icon(
              (avist.estaSubido)?Icons.cloud_done:Icons.cloud_off,
              size: 20,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}