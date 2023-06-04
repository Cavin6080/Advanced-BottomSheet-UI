import 'package:flutter/material.dart';

import '../models/nature_model.dart';

class NatureController extends ChangeNotifier {
  NatureController({required NatureModel natureModel})
      : _natureModel = natureModel;
  NatureModel _natureModel;

  NatureModel get natureModel => _natureModel;
  set natureModel(value) {
    _natureModel = value;
    notifyListeners();
  }
}
