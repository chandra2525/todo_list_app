import 'package:get/get.dart';
import 'package:to_do_list_app/services/api_service.dart';
import 'package:to_do_list_app/models/checklist_model.dart';
import 'dart:convert';

class ChecklistController extends GetxController {
  var isLoading = false.obs;
  var checklistData = <Checklist>[].obs;
  var checklistItems = <ChecklistItem>[].obs;

  final String? token;

  ChecklistController({required this.token});

  @override
  void onInit() {
    super.onInit();
    fetchChecklists();
  }

  Future<void> fetchChecklists() async {
    isLoading(true);
    final response = await ApiService.getRequest('checklist', token: token);
    isLoading(false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      checklistData.value =
          data.map((item) => Checklist.fromJson(item)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load checklists');
    }
  }

  Future<void> createChecklist(String name) async {
    isLoading(true);
    final response =
        await ApiService.postRequest('checklist', {"name": name}, token: token);
    isLoading(false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      final dataMessage = json.decode(response.body)['message'];
      checklistData.add(Checklist.fromJson(data));

      print(dataMessage);
      Get.back();
      Get.snackbar('Success', dataMessage);
    } else {
      Get.snackbar('Error', 'Failed to create checklist');
    }
  }

  Future<void> deleteChecklist(int id) async {
    isLoading(true);
    final response =
        await ApiService.deleteRequest('checklist/$id', token: token);
    isLoading(false);
    final data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      checklistData.removeWhere((checklist) =>
          checklist.id == id); // Remove deleted checklist from the list
      Get.snackbar('Success', data['message']);
    } else {
      Get.snackbar('Error', 'Failed to delete checklist');
    }
  }

  Future<void> fetchChecklistItems(int checklistId) async {
    isLoading(true);
    final response = await ApiService.getRequest('checklist/$checklistId/item',
        token: token);
    isLoading(false);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      checklistItems.value =
          data.map((item) => ChecklistItem.fromJson(item)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load checklist items');
    }
  }
}
