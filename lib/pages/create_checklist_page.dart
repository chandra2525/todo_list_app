import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/controllers/checklist_controller.dart';

class CreateChecklistPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final ChecklistController checklistController =
      Get.find<ChecklistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Checklist Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              return ElevatedButton(
                onPressed: checklistController.isLoading.value
                    ? null
                    : () {
                        final name = nameController.text;
                        if (name.isNotEmpty) {
                          checklistController.createChecklist(name);
                        } else {
                          Get.snackbar(
                              'Error', 'Please enter a checklist name');
                        }
                      },
                child: checklistController.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Create Checklist'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
