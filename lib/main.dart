import 'package:flutter/material.dart';
import 'package:fooddelivery/controller/cart_controller.dart';
import 'package:fooddelivery/controller/popular_product_controller.dart';
import 'package:fooddelivery/pages/auth/sign_app_page.dart';
import 'package:fooddelivery/pages/auth/sign_in_page.dart';
import 'package:fooddelivery/pages/food/popular_food_details.dart';
import 'package:fooddelivery/pages/home/food_page_body.dart';
import 'package:fooddelivery/pages/home/main_food_page.dart';
import 'package:fooddelivery/pages/splash/splash_page.dart';
import 'package:fooddelivery/routes/routes_helper.dart';
import 'package:get/get.dart';

import 'controller/recommended_product_controller.dart';
import 'pages/food/recommended_food_details.dart';
import 'helper/dependencies.dart' as dep;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 Get.find<CartController>().getCartData();
     return   GetBuilder<PopularProductController>(builder: (_){
          return GetBuilder<RecommendedProductController>(builder: (_){

            return  GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',

             // home: SignInPage(),
              initialRoute: RouteHelper.getSplashPage(),
             getPages: RouteHelper.routes,
            );
          });
        });
  }
}
