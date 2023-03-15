import 'dart:convert';
import 'dart:io';

import 'package:chatgpt/models/base_model.dart';
import 'package:http/http.dart' as http;

import '../constant/api.dart';

class ApiService {
  static Future<List<BaseModel>> getModel() async {
    try {
      var response = await http.get(
        Uri.parse('$BASE_URL/models'),
        headers: {'Authorization': 'Bearer $BASE_API'},
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List data = jsonResponse['data'] as List;
      return BaseModel.modelsFromSnapshot(data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
