import 'package:get/get.dart';

import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/attendance_list/bindings/attendance_list_binding.dart';
import '../modules/attendance_list/views/attendance_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/map_picker/bindings/map_picker_binding.dart';
import '../modules/map_picker/views/map_picker_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PICKER,
      page: () => MapPickerView(),
      binding: MapPickerBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_LIST,
      page: () => AttendanceListView(),
      binding: AttendanceListBinding(),
    ),
  ];
}
