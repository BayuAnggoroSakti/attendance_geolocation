import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(int index) async {
    pageIndex.value = index;
    switch (index) {
      case 1:
        Get.offAllNamed(Routes.ATTENDANCE);
        break;
      case 2:
        Get.offAllNamed(Routes.ATTENDANCE_LIST);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }
}
