import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/auth_controller.dart';
import 'package:to_do_list_app/controllers/checklist_controller.dart';

import 'checklist_detail_page.dart';
// import 'package:to_do_list_app/models/checklist_model.dart';

class ChecklistPage extends StatelessWidget {
  final ChecklistController checklistController = Get.put(
      ChecklistController(token: Get.find<AuthController>().getToken()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklists'),
      ),
      body: Obx(() {
        if (checklistController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (checklistController.checklistData.isEmpty) {
          return Center(child: Text('No checklists available'));
        } else {
          return ListView.builder(
            itemCount: checklistController.checklistData.length,
            itemBuilder: (context, index) {
              final checklist = checklistController.checklistData[index];
              return Card(
                child: ListTile(
                  title: Text(checklist.name),
                  subtitle: checklist.items != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: checklist.items!.map((item) {
                            return Text(
                                '${item.name} - ${item.itemCompletionStatus ? "Completed" : "Incomplete"}');
                          }).toList(),
                        )
                      : Text('No items'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, checklist.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          Get.to(
                              ChecklistDetailPage(checklistId: checklist.id));
                        },
                      ),
                      Icon(checklist.checklistCompletionStatus
                          ? Icons.check_circle
                          : Icons.pending),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/create-checklist');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int checklistId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Checklist'),
        content: Text('Are you sure you want to delete this checklist?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              checklistController.deleteChecklist(checklistId);
              Get.back();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
