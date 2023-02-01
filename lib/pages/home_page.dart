import 'package:flutter/material.dart';
import 'package:login_nodejs/services/api_service.dart';
import 'package:login_nodejs/services/shared_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login using node js'),
        centerTitle: true,
        elevation: 20,
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }

  // Widget userProfile() {
  //   return FutureBuilder(
  //     future: ApiService.getUserProfile(),
  //     builder: (BuildContext context, AsyncSnapshot<String> model) {
  //       if (model.hasData) {
  //         return Center(
  //           child: Text(
  //             model.data!,
  //           ),
  //         );
  //       }
  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
}
