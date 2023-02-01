import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_nodejs/controllers/login_controller.dart';
import 'package:login_nodejs/models/login_request_model.dart';
import 'package:login_nodejs/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Obx(
          () => ProgressHUD(
            key: UniqueKey(),
            opacity: 0.3,
            inAsyncCall: controller.isApiCallProcess.value,
            child: Form(
              key: controller.globalFormKey,
              child: _loginUI(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(80),
                  bottomLeft: Radius.circular(80),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(10, 10),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.hive,
                  color: Colors.blueAccent,
                  size: 90,
                ),
                SizedBox(height: 10),
                Text(
                  'LOGIN UI',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    decoration: TextDecoration.overline,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Text(
                    '©KRITARTHA',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 50, bottom: 30),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            'Username',
            'Type your username',
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Username can\'t be Empty.';
              }
              return null;
            },
            (onSavedVal) {
              Obx(
                () => controller.username.value = onSavedVal,
              );
            },
            backgroundColor: Colors.white,
            showPrefixIcon: true,
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            prefixIconColor: Colors.white,
            borderFocusColor: Colors.green,
            borderColor: Colors.black,
            textColor: Colors.black,
            borderRadius: 10,
            hintColor: Colors.grey,
          ),
          const SizedBox(height: 15),
          Obx(
            () => FormHelper.inputFieldWidget(
              context,
              'password',
              'Type your password',
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Password can\'t be Empty.';
                }
                return null;
              },
              (onSavedVal) => {
                controller.password.value = onSavedVal,
              },
              showPrefixIcon: true,
              backgroundColor: Colors.white,
              prefixIcon: const Icon(Icons.password),
              prefixIconColor: Colors.black,
              borderFocusColor: Colors.green,
              borderColor: Colors.black,
              textColor: Colors.black,
              borderRadius: 10,
              hintColor: Colors.grey,
              obscureText: controller.hidePassword.value,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.hidePassword.value =
                      !controller.hidePassword.value;
                },
                icon: Icon(
                  controller.hidePassword.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 25),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Forgot Password?',
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.snackbar(
                              'Contact Admin',
                              '+977-9807585488',
                              colorText: Colors.white,
                              backgroundColor: Colors.blueAccent,
                              duration: const Duration(seconds: 3),
                            );
                          }),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: FormHelper.submitButton(
              'Login',
              () {
                if (controller.validateAndSave()) {
                  controller.isApiCallProcess.value = true;
                  LoginRequestModel model = LoginRequestModel(
                    username: controller.username.value,
                    password: controller.password.value,
                  );
                  ApiService.login(model).then((response) {
                    controller.isApiCallProcess.value = false;
                    if (response) {
                      Get.offNamed('/home');
                    } else {
                      FormHelper.showSimpleAlertDialog(context, Config.appName,
                          'Invalid Email/Password', 'Okay', () {
                        Get.back();
                      });
                    }
                  });
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
              btnColor: Colors.blueAccent,
              borderColor: Colors.white,
              borderRadius: 10,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'OR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 25),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/register');
                          }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
