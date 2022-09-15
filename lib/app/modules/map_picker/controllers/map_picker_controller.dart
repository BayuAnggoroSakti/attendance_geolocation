import 'dart:developer';

import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';

class MapPickerController extends GetxController {
  final count = 0.obs;
  final pick_loc_name = ''.obs;
  final pick_loc_latlong = ''.obs;
  final pick_loc_lat = 0.0.obs;
  final pick_loc_lon = 0.0.obs;
  LocationData? currentLocation;
  final _lokasi = Hive.box('master_lokasi');
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> createItem(Map<String, dynamic> newItem) async {
    await _lokasi.add(newItem);
    Get.snackbar(
      "Success",
      "Berhasil menambahkan lokasi baru",
      icon: Icon(Icons.location_on, color: Colors.white),
      backgroundColor: AppColor.success,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
    Get.offAllNamed(Routes.HOME);
  }
}
