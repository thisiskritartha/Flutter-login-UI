import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isApiCallProcess = false.obs;
  RxBool hidePassword = true.obs;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxString email = ''.obs;

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
