import 'package:flutter/material.dart';
import 'package:fooddelivery/base/custom_loader.dart';
import 'package:fooddelivery/controller/auth_controller.dart';
import 'package:fooddelivery/controller/cart_controller.dart';
import 'package:fooddelivery/controller/user_controller.dart';
import 'package:fooddelivery/routes/routes_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/account_widget.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: BigText(
              text: "Profile",
              size: 24,
              color: Colors.white,
            ),
          ),
          body: GetBuilder<UserController>(builder: (userControoler) {
            return _userLoggedIn
                ? (userControoler.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              bgColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height45 + Dimensions.height30,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //name
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        bgColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userControoler.userModel.name)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //phone
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        bgColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userControoler.userModel.phone)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //email
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        bgColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userControoler.userModel.email)),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //address
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on_outlined,
                                        bgColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Taiz Yemen ")),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //message
                                  AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message,
                                        bgColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Message ")),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  //message
                                  GestureDetector(
                                    onDoubleTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearShareddata();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout_outlined,
                                          bgColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Logout ")),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                    : const CustomLoader())
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 8,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/signintocontinue.png"))),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 6,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                              child: BigText(
                            text: "Sign in",
                            color: Colors.white,
                            size: Dimensions.font20,
                          )),
                        ),
                      ),
                    ],
                  ));
          })),
    );
  }
}
