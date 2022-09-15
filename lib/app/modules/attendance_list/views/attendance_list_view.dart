import 'dart:developer';

import 'package:attendance_record_hashmicro/app/controllers/page_index_controller.dart';
import 'package:attendance_record_hashmicro/app/modules/attendance_list/controllers/attendance_list_controller.dart';
import 'package:attendance_record_hashmicro/app/routes/app_pages.dart';
import 'package:attendance_record_hashmicro/app/style/app_color.dart';
import 'package:attendance_record_hashmicro/app/tools/permission_helper.dart';
import 'package:attendance_record_hashmicro/app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AttendanceListView extends GetView<AttendanceListController> {
  final pageIndexController = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0.0,
        title: new Center(
          child: new Text(
            'List Attendance',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: AppColor.primary),
                    SizedBox(width: 8.0),
                    Text('Refresh'),
                  ],
                ),
                value: 0,
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  controller.refresh();
                  break;
              }
            },
          ),
        ],
        leadingWidth: Get.width * 0.25,
      ),
      extendBody: true,
      body: controller.items.isEmpty
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: controller.items.length,
              itemBuilder: (_, index) {
                final currentItem = controller.items[index];
                return Card(
                  color: Colors.orange.shade100,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(currentItem['datetime']),
                    subtitle: Text(currentItem['latlong'].toString()),
                  ),
                );
              }),
    );
  }
}
