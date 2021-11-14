// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:login/model/login_model.dart';
import 'package:login/services/shared_service.dart';

class APIService {
  // Customer Login
  static var client = http.Client();
  static String apiUrl = 'https://yourdomain.com';

  static Future<bool> loginCustomer(String username, String password) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    var response = await client.post(
      Uri.parse('$apiUrl/wp-json/jwt-auth/v1/token'),
      headers: requestHeaders,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      LoginResponseModel responseModel = loginResponseFromJson(jsonString);
      if (responseModel.statusCode == 200) {
        SharedService.setLoginDetails(responseModel);
      }
      return responseModel.statusCode == 200 ? true : false;
    }
    return false;
  }
}
