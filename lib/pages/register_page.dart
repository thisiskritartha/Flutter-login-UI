import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_nodejs/controllers/login_controller.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../config.dart';
import '../models/register_request_model.dart';
import '../services/api_service.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: ProgressHUD(
          key: UniqueKey(),
          opacity: 0.3,
          inAsyncCall: controller.isApiCallProcess.value,
          child: Form(
            key: controller.globalFormKey,
            child: _registerUI(context),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
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
                  'REGISTER UI',
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
              'REGISTER',
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
              controller.username.value = onSavedVal;
            },
            showPrefixIcon: true,
            backgroundColor: Colors.white,
            prefixIcon: const Icon(Icons.person),
            prefixIconColor: Colors.black,
            borderFocusColor: Colors.green,
            borderColor: Colors.black,
            textColor: Colors.black,
            borderRadius: 10,
            hintColor: Colors.grey,
          ),
          const SizedBox(height: 15),
          FormHelper.inputFieldWidget(
            context,
            'Email',
            'Type your Email',
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Email can\'t be Empty.';
              }
              return null;
            },
            (onSavedVal) {
              controller.email.value = onSavedVal;
            },
            backgroundColor: Colors.white,
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email),
            prefixIconColor: Colors.black,
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
              backgroundColor: Colors.white,
              showPrefixIcon: true,
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
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: FormHelper.submitButton(
              'REGISTER',
              () {
                if (controller.validateAndSave()) {
                  controller.isApiCallProcess.value = true;
                  RegisterRequestModel model = RegisterRequestModel(
                    username: controller.username.value,
                    password: controller.password.value,
                    email: controller.email.value,
                  );
                  ApiService.register(model).then((response) {
                    controller.isApiCallProcess.value = false;
                    if (response.data != null) {
                      Get.offNamed('/home');
                      FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          'Registration Successful. Get to Loin Page',
                          'Okay', () {
                        Get.toNamed('/login');
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                          context, Config.appName, response.message!, 'Okay',
                          () {
                        Get.back();
                      });
                    }
                  });
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
              btnColor: Colors.blue,
              borderColor: Colors.white,
              borderRadius: 10,
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
                        text: 'Already have an account?',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed('/login');
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
