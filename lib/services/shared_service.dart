import 'dart:convert';
import 'package:get/get.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/login_response_model.dart';

class SharedService {
  //Checks if the user is loggedIn by using 'login_details key using APICacheManager() class.
  static Future<bool> isLoggedIn() async {
    bool isKeyExist =
        await APICacheManager().isAPICacheKeyExist('login_details');
    return isKeyExist;
  }

  //Retrieves the loggedIn details that was previously saved.
  static Future<LoginResponseModel?> loginDetails() async {
    bool isKeyExist =
        await APICacheManager().isAPICacheKeyExist('login_details');
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData('login_details');
      return loginResponseModel(cacheData.syncData);
    }
    return null;
  }

  //Stores the cache data to the local database
  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel = APICacheDBModel(
      key: 'login_details',
      syncData: jsonEncode(model.toJson()),
    );
    //Adding the cache data to local database
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout() async {
    await APICacheManager().deleteCache('login_details');
    Get.offNamedUntil('/', (route) => false);
  }
}
