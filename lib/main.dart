import 'package:attendance_record_hashmicro/app/controllers/page_index_controller.dart';
import 'package:attendance_record_hashmicro/app/tools/permission_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final storage = FlutterSecureStorage();
  final hiveEncryptionSecret =
      await storage.read(key: "dfsdgfdgreghdfshdfshjrejhe") ??
          Hive.generateSecureKey().join();
  storage.write(key: "dfsdgfdgreghdfshdfshjrejhe", value: hiveEncryptionSecret);

  // opening box
  final key = hiveEncryptionSecret.split('').map((e) => int.parse(e));
  final cipher = HiveAesCipher(key.take(32).toList());
  await Hive.openBox(
    "master_lokasi",
    encryptionCipher: cipher,
  );
  await Hive.openBox(
    "attendance",
    encryptionCipher: cipher,
  );
  await PermissionHelper.requestLocation();
  Get.put(PageIndexController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
