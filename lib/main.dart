import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_nodejs/bindings/bindings.dart';
import 'package:login_nodejs/pages/home_page.dart';
import 'package:login_nodejs/services/shared_service.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

//Widget _defaultPage = LoginPage();

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // bool result = SharedService.isLoggedIn() as bool;
  // if (result) {
  //   // _defaultPage = const HomePage();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      initialRoute: '/login',
      initialBinding: ControllerBinding(),
      getPages: [
        //GetPage(name: '/', page: () => _defaultPage),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
      ],
    );
  }
}
