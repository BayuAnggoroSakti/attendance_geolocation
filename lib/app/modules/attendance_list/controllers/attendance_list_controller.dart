import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AttendanceListController extends GetxController {
  final attendance = Hive.box('attendance');
  List<Map<String, dynamic>> items = [];

  @override
  void onInit() {
    super.onInit();
    refreshItems();
  }

  void refreshItems() {
    final data = attendance.keys.map((key) {
      final value = attendance.get(key);
      return {
        "key": key,
        "datetime": value["datetime"],
        "latlong": value['lat'].toString() + ', ' + value['lon'].toString()
      };
    }).toList();
    items = data.reversed.toList();
  }

  void refresh() {
    Get.offAllNamed(Routes.ATTENDANCE_LIST);
  }
}
