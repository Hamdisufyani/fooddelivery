import 'package:fooddelivery/controller/auth_controller.dart';
import 'package:fooddelivery/controller/cart_controller.dart';
import 'package:fooddelivery/controller/popular_product_controller.dart';
import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/data/repository/auth_repo.dart';
import 'package:fooddelivery/data/repository/cart_repo.dart';
import 'package:fooddelivery/data/repository/popular_product_repo.dart';
import 'package:fooddelivery/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/recommended_product_controller.dart';
import '../controller/user_controller.dart';
import '../data/repository/recommendede_product_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), ));

//repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

//controllers
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
  Get.lazyPut(()=>UserController(userRepo: Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
