import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list_app/services/api_service.dart';
import 'dart:convert';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final storage = GetStorage();

  Future<void> login(String username, String password) async {
    isLoading(true);
    final response = await ApiService.postRequest('login', {
      "password": password,
      "username": username,
    });
    isLoading(false);
    final data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      if (data['data'] != null && data['data']['token'] != null) {
        String token = data['data']['token'];
        storage.write('token', token);
        Get.snackbar(data['message'], data['errorMessage'] ?? "Berhasil login");
        print(storage.read('token'));
        Get.offAllNamed('/checklists');
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } else {
      Get.snackbar(data['message'], data['errorMessage']);
    }
  }

  Future<void> register(String username, String email, String password) async {
    isLoading(true);
    final response = await ApiService.postRequest('register', {
      "email": email,
      "password": password,
      "username": username,
    });
    isLoading(false);
    final data = json.decode(response.body);
    print(data);

    if (response.statusCode == 200) {
      Get.snackbar(
          data['message'], data['errorMessage'] ?? "Berhasil terdaftar");
      Get.toNamed('/login');
    } else {
      Get.snackbar(data['message'], data['errorMessage']);
    }
  }

  String? getToken() {
    return storage.read('token');
  }
}
