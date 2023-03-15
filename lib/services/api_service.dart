import 'dart:convert';
import 'dart:io';

import 'package:chatgpt/models/base_model.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';

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

  static Future<List<ChatModel>> sendMessage(
    String message,
    String modelId,
    BuildContext context,
  ) async {
    try {
      var response = await http.post(Uri.parse('$BASE_URL/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $BASE_API'
          },
          body: jsonEncode({
            "model": modelId,
            "prompt": message,
            "max_tokens": 500,
            "temperature": 0,
            // "n": 1,
            // "stream": false,
            // "logprobs": null,
          }));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List data = jsonResponse['choices'] as List;
      List<ChatModel> chatList = [];
      if (data.isNotEmpty) {
        chatList = List.generate(
            data.length,
            (index) => ChatModel(
                  msg: data[index]['text'],
                  chatIndex: 1,
                ));
      }
      return chatList;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ));
      ;
      rethrow;
    }
  }
}
