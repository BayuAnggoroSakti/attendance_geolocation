import 'dart:developer';

import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  final lokasi = Hive.box('master_lokasi');
  List<Map<String, dynamic>> items = [];

  @override
  void onInit() {
    super.onInit();
    refreshItems();
  }

  void refreshItems() {
    final data = lokasi.keys.map((key) {
      final value = lokasi.get(key);
      return {"key": key, "name": value["name"], "latlong": value['latlong']};
    }).toList();
    items = data.reversed.toList();
  }

  void refresh() {
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> deleteItem(int itemKey) async {
    await lokasi.delete(itemKey);
    refresh(); // update the UI

    // Display a snackbar
    Get.snackbar(
      "Success",
      "Berhasil menghapus lokasi",
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
  }
}
