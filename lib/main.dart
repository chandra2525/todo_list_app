import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'pages/checklist_detail_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/checklist_page.dart';
import 'pages/create_checklist_page.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/checklists', page: () => ChecklistPage()),
        GetPage(name: '/create-checklist', page: () => CreateChecklistPage()),
        // GetPage(
        //   name: '/checklist-detail',
        //   page: () => ChecklistDetailPage(
        //       checklistId: Get.arguments), // Pass the argument here
        // ),
        // GetPage(
        //   name: '/checklist-detail/:id',
        //   page: () => ChecklistDetailPage(
        //     checklistId: int.parse(Get.parameters['id']!),
        //   ),
        // ),
      ],
    );
  }
}
