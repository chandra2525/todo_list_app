import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/checklist_controller.dart';

class ChecklistDetailPage extends StatelessWidget {
  final int checklistId;
  final ChecklistController checklistController =
      Get.find<ChecklistController>();

  ChecklistDetailPage({required this.checklistId});

  @override
  Widget build(BuildContext context) {
    checklistController.fetchChecklistItems(
        checklistId); // Fetch checklist items when the page loads

    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist Details'),
      ),
      body: Obx(() {
        if (checklistController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (checklistController.checklistItems.isEmpty) {
          return Center(child: Text('No items available'));
        } else {
          return ListView.builder(
            itemCount: checklistController.checklistItems.length,
            itemBuilder: (context, index) {
              final item = checklistController.checklistItems[index];
              return Card(
                child: ListTile(
                  title: Text(item.name),
                  trailing: Icon(
                    item.itemCompletionStatus
                        ? Icons.check_circle
                        : Icons.pending,
                    color:
                        item.itemCompletionStatus ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
