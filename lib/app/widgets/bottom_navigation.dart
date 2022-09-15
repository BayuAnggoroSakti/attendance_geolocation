import 'package:attendance_record_hashmicro/app/controllers/page_index_controller.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends GetView<PageIndexController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Stack(
        alignment: new FractionalOffset(.5, 1.0),
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.secondaryExtraSoft, width: 1),
                ),
              ),
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(0),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: (controller.pageIndex.value == 0)
                                    ? SvgPicture.asset(
                                        'assets/icons/location_active.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/location_active.svg'),
                                margin: EdgeInsets.only(bottom: 4),
                              ),
                              Text(
                                "Master Lokasi",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      margin: EdgeInsets.only(top: 24),
                      alignment: Alignment.center,
                      child: Text(
                        "Attendance Record",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.changePage(2),
                        child: Container(
                          height: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: (controller.pageIndex.value == 2)
                                    ? SvgPicture.asset(
                                        'assets/icons/profile-active.svg')
                                    : SvgPicture.asset(
                                        'assets/icons/profile.svg'),
                                margin: EdgeInsets.only(bottom: 4),
                              ),
                              Text(
                                "List Attendance",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            child: SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                  onPressed: () => controller.changePage(1),
                  elevation: 0,
                  child: SvgPicture.asset(
                    'assets/icons/qr-code-svgrepo-com.svg',
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
