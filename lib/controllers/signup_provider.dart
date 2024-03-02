import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../services/helpers/auth_helper.dart';
import '../views/screens/auth/login_page.dart';

class SignUpNotifier extends ChangeNotifier {
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

  final signupFormKey = GlobalKey<FormState>();

  void validateAndSave(String model) {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      signUp(model);
    } else {
      _loader = false;
    }
    notifyListeners();
  }

  signUp(String model) {
    AuthHelper.signup(model).then((response) {
      if (response == true) {
        _loader = false;
        Get.offAll(() => const LoginPage());
      } else {
        _loader = false;
        Get.snackbar('Failed to Sign up', 'Email Already Exists!',
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert));
        notifyListeners();
      }
    });
  }
}
