import 'package:flutter/material.dart';

class SkillsNotifier extends ChangeNotifier {
  bool _addSkills = false;
  bool get addSkills => _addSkills;

  set setSkills(bool newState) {
    _addSkills = newState;
    notifyListeners();
  }

  String _addSkillsId = '';
  String get addSkillsId => _addSkillsId;

  set setSkillsId(String newState) {
    _addSkillsId = newState;
    notifyListeners();
  }

  String _logoURL = '';
  String get addLogoURL => _logoURL;

  set setLogoURL(String newState) {
    _logoURL = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;
  set setLoader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final createJobFormKey = GlobalKey<FormState>();

  void validateAndSave(String model) {
    final form = createJobFormKey.currentState;
    if (form!.validate()) {
      form.save();
    } else {
      _loader = false;
    }
    notifyListeners();
  }
}
