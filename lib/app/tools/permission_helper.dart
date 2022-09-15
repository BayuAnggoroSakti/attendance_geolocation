import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestLocation() async {
    final permissionStatuses = await [Permission.location].request();

    if (permissionStatuses.values.every((status) => status.isGranted))
      return true;

    return false;
  }
}
