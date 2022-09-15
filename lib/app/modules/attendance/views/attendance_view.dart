import 'dart:collection';
import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:attendance_record_hashmicro/app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  Set<Circle> _circles = HashSet<Circle>();
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  Completer<GoogleMapController> _controller = Completer();
  late LocationData currentLocation;
  bool is_ready_location = false;
  int _circleIdCounter = 1;
  @override
  Widget build(BuildContext context) {
    _currentLocation();
    _get_lokasi();
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        title: Text('Attendance Record'),
        backgroundColor: AppColor.primary,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF6F8FA),
        margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                //width: 260.0,
                height: 300.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(16.0),
                  ),
                ),
                child: Center(child: _mapGoogle()),
              ),
            ),
            InkWell(
              onTap: () {
                if (is_ready_location) {
                  var inlocation = false;
                  for (var i = 0; i < controller.items.length; i++) {
                    final currentItem = controller.items[i];
                    double jarak = Geolocator.distanceBetween(
                        currentLocation.latitude!,
                        currentLocation.longitude!,
                        currentItem['lat'],
                        currentItem['lon']);

                    if (jarak < 50) {
                      inlocation = true;
                    }
                  }
                  if (inlocation) {
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    controller.createItem({
                      "datetime": formattedDate,
                      "lat": currentLocation.latitude!,
                      "lon": currentLocation.longitude!
                    });
                  } else {
                    Get.snackbar(
                      "Gagal",
                      "Anda diluar area",
                      icon: Icon(Icons.location_on, color: Colors.white),
                      backgroundColor: AppColor.error,
                      snackPosition: SnackPosition.TOP,
                      borderRadius: 20,
                      margin: EdgeInsets.all(15),
                      colorText: Colors.white,
                      duration: Duration(seconds: 4),
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                  }
                }
              },
              child: new Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 180.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColor.primary,
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(24.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Absence In',
                      style: TextStyle(
                        color: Colors.white,
//                    /fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;

    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      is_ready_location = true;
    } on Exception {
      Get.snackbar(
        "Error",
        "Gagal mendapatkan posisi",
        icon: Icon(Icons.location_on, color: Colors.white),
        backgroundColor: AppColor.error,
        snackPosition: SnackPosition.TOP,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  void _get_lokasi() {
    for (var i = 0; i < controller.items.length; i++) {
      final currentItem = controller.items[i];
      LatLng point = LatLng(currentItem['lat'], currentItem['lon']);
      _setCircles(point, 50);
    }
  }

  void _setCircles(LatLng point, double radius_) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: radius_,
        fillColor: Colors.greenAccent.withOpacity(0.5),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  GoogleMap _mapGoogle() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: _initialcameraposition),
      myLocationEnabled: true,
      circles: _circles,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
