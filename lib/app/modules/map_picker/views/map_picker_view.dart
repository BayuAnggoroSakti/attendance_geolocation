import 'dart:developer';

import 'package:attendance_record_hashmicro/app/modules/map_picker/controllers/map_picker_controller.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:attendance_record_hashmicro/app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MapPickerView extends GetView<MapPickerController> {
  String googleApikey = "AIzaSyC01QdritczdawT07lVHKRUYWpKvXpAXu8";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  late LocationData currentLocation;
  Location _location = Location();
  LatLng startLocation = LatLng(-6.172271209343214, 106.83018978504026);

  // void _onMapCreated(GoogleMapController _cntlr) {
  //   mapController = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     mapController?.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(),
        appBar: AppBar(
          title: Text("Menambahkan Lokasi"),
          backgroundColor: AppColor.primary,
        ),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            myLocationEnabled: true,
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 10.0, //initial zoom level
            ),
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              mapController = controller;
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              controller.pick_loc_latlong.value = "loading";
              cameraPosition = cameraPositiona; //when map is dragging
            },
            onCameraIdle: () async {
              //when map drag stops
              log(cameraPosition!.target.latitude.toString() +
                  ", " +
                  cameraPosition!.target.longitude.toString());
              List<geo.Placemark> placemarks =
                  await geo.placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude);

              controller.pick_loc_lat.value = cameraPosition!.target.latitude;
              controller.pick_loc_lon.value = cameraPosition!.target.longitude;
              controller.pick_loc_latlong.value =
                  cameraPosition!.target.latitude.toString() +
                      ", " +
                      cameraPosition!.target.longitude.toString();
              controller.pick_loc_name.value =
                  placemarks.first.subAdministrativeArea.toString() +
                      ", " +
                      placemarks.first.street.toString();
            },
          ),
          Center(
            //picker image on google map
            child: Image.asset(
              "assets/images/location.png",
              width: 50,
            ),
          ),
          Positioned(
              //widget to display location name
              bottom: 100,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Container(
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width - 40,
                      child: TextButton(
                        child: Obx(() {
                          final pick_lokasi = controller.pick_loc_latlong.value;

                          if (pick_lokasi == "loading") {
                            return Center(
                              child: SizedBox(
                                height: 16.0,
                                width: 16.0,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                  strokeWidth: 2.0,
                                ),
                              ),
                            );
                          }

                          return Text(
                            'Pilih Lokasi : ' +
                                controller.pick_loc_name.value +
                                ' ' +
                                pick_lokasi,
                            style: Get.textTheme.button!.copyWith(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          );
                        }),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (controller.pick_loc_latlong == "" ||
                              controller.pick_loc_latlong == "loading") {
                            Get.snackbar(
                              "Gagal",
                              "Mohon memilih lokasi terlebih dahulu",
                              icon: Icon(Icons.error, color: Colors.white),
                              backgroundColor: AppColor.error,
                              snackPosition: SnackPosition.TOP,
                              borderRadius: 20,
                              margin: EdgeInsets.all(15),
                              colorText: Colors.white,
                              duration: Duration(seconds: 4),
                              isDismissible: true,
                              forwardAnimationCurve: Curves.easeOutBack,
                            );
                          } else {
                            await controller.createItem({
                              "name": controller.pick_loc_name.value,
                              "latlong": controller.pick_loc_latlong.value,
                              "lat": controller.pick_loc_lat.value,
                              "lon": controller.pick_loc_lon.value
                            });
                          }
                        },
                      )),
                ),
              ))
        ]));
  }
}
