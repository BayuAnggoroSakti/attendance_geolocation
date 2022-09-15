import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AttendanceController extends GetxController {
  final lokasi = Hive.box('master_lokasi');
  final attendance = Hive.box('attendance');
  List<Map<String, dynamic>> items = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    get_lokasi();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void get_lokasi() {
    final data = lokasi.keys.map((key) {
      final value = lokasi.get(key);
      return {
        "key": key,
        "name": value["name"],
        "latlong": value['latlong'],
        "lat": value['lat'],
        "lon": value['lon']
      };
    }).toList();
    items = data.reversed.toList();
  }

  Future<void> createItem(Map<String, dynamic> newItem) async {
    await attendance.add(newItem);
    Get.snackbar(
      "Success",
      "Berhasil menambahkan attendance baru",
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
    Get.offAllNamed(Routes.ATTENDANCE_LIST);
  }
}
