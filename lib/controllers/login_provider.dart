import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_apex/controllers/zoom_provider.dart';
import 'package:job_apex/views/screens/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../services/helpers/auth_helper.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;
  set setObsecureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;
  set setLoader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final loginFormKey = GlobalKey<FormState>();

  void validateAndSave(String model, ZoomNotifier zoomNotifier) {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      login(model, zoomNotifier);
    } else {
      _loader = false;
    }
  }

  login(String model, ZoomNotifier zoomNotifier) {
    AuthHelper.login(model).then((response) {
      if (response == true) {
        setLoader = false;
        getPrefs();
        Get.offAll(() => const Mainscreen());
      } else {
        setLoader = false;
        Get.snackbar('Failed to Login', 'Please check your credentials',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;
  set setEntrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;
  set setLoggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setEntrypoint = prefs.getBool('entrypoint') ?? false;
    setLoggedIn = prefs.getBool('loggedIn') ?? false;
    username = prefs.getString('username') ?? '';
    userUid = prefs.getString('uid') ?? '';
    profile = prefs.getString('profile') ?? '';
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
  }
}
