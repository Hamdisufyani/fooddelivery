import 'package:fooddelivery/pages/auth/sign_in_page.dart';
import 'package:fooddelivery/pages/food/popular_food_details.dart';
import 'package:fooddelivery/pages/food/recommended_food_details.dart';
import 'package:fooddelivery/pages/home/home_page.dart';
import 'package:fooddelivery/pages/home/main_food_page.dart';
import 'package:fooddelivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';

class RouteHelper {
  static const String splashPage="/splash_page";
  static const String initial = "/";
  static const String popularFood = "/populat-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";


  static String  getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId,String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String  getCartPage()=>'$cartPage';
  static String  getSignInPage()=>'$signIn';


  static List<GetPage> routes = [
    GetPage(name: splashPage, page: ()=>const SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(name: signIn,
      page: () => const SignInPage(),
      transition: Transition.fade
    ),

    GetPage(name: popularFood, page: () {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return PopularFoodDetails( pageId:int.parse(pageId!),page: page!,);
    } ,
        transition: Transition.fadeIn

    ),

    GetPage(name: recommendedFood, page: () {
      var pageId=Get.parameters['pageId'];
      var page=Get.parameters["page"];
      return RecommendedFoodDetails(pageId:int.parse(pageId!),page:page!);
    } ,
        transition: Transition.fadeIn

    ),
    GetPage(name: cartPage, page:(){
      return CartPage();
    },transition: Transition.fadeIn)
  ];
}
