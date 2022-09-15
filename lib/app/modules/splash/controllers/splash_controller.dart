import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  final appVersionName = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _getAppVersion();
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed(Routes.HOME);
    });
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersionName.value = packageInfo.version;
  }
}
