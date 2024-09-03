import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://94.74.86.174:8080/api/';

  static Future<http.Response> getRequest(String endpoint,
      {String? token}) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.post(
      url,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<http.Response> deleteRequest(String endpoint,
      {String? token}) async {
    final url = Uri.parse(baseUrl + endpoint);
    return await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}
