import 'package:chatgpt/models/base_model.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class ModelProvider with ChangeNotifier {
  List<BaseModel> _modelList = [];
  String _currentModel = 'text-davinci-003';

  List<BaseModel> get getModeList => _modelList;
  String get getCurrentModel => _currentModel;

  void setCurrentModel(String newModel) {
    _currentModel = newModel;
    notifyListeners();
  }

  Future<List<BaseModel>> getAllModels() async {
    _modelList = await ApiService.getModel();
    return _modelList;
  }
}
