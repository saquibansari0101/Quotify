import 'dart:async';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiClient {
  static ApiClient _instance;
  static const BASE_URL = "https://zenquotes.io/api/random";

  factory ApiClient() => _instance ??= new ApiClient._();

  ApiClient._();

  Future<http.Response> getMethodWithoutHeader() async {
    log(BASE_URL);
    var response = await http.get(
      Uri.parse(BASE_URL),
    );
    log(response.body);
    return response;
  }
}
