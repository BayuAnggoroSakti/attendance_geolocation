import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color(0xFF6B8EEF),
        Color(0xFF0C2979),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/hashmicro-icon.png',
                    width: Get.width * 0.3,
                  ),
                  SizedBox(height: 4),
                  const Text(
                    'Attendance Record v1.0.0',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SpinKitFadingCircle(
                    color: Colors.white,
                    size: 35.0,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Spacer(),
                      Obx(
                        () => Text(
                          controller.appVersionName.value,
                          textAlign: TextAlign.center,
                          style:
                              Get.textTheme.bodyText2!.copyWith(fontSize: 14.0),
                        ),
                      ),
                      Text('Flutter Developer Test by Bayu Anggoro Sakti',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      SizedBox(width: 2.0),
                      //Text('v1.0.0', style: TextStyle(color: Colors.white)),
                      Spacer()
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(),
                          Image.asset(
                            'assets/images/hashmicro-icon.png',
                            width: Get.width * 0.25,
                            fit: BoxFit.fitHeight,
                          ),
                          const Spacer(),
                          VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/images/hashmicro-icon-1.png',
                            width: Get.width * 0.25,
                            fit: BoxFit.scaleDown,
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
