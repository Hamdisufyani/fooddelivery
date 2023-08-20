import 'package:flutter/material.dart';
import 'package:fooddelivery/controller/popular_product_controller.dart';
import 'package:fooddelivery/routes/routes_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/app_icon.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/extandable_text_wedget.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../utils/app_constant.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetails extends StatelessWidget {
 final int pageId;
 final String page;

   const RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        if(page=="cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());

                        }else{
                          Get.toNamed(RouteHelper.getInitial());

                        }
                      },
                      child: AppIcon(icon: Icons.clear)),
                //  AppIcon(icon: Icons.shopping_cart_outlined),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalitems>=1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined,),
                          controller.totalitems>=1?
                          Positioned(
                            right:0,
                            top:0,

                              child: AppIcon(icon: Icons.circle,size: 20,
                                iconColor: Colors.transparent,bgColor: AppColors.mainColor,),

                          )
                              :Container(),
                          Get.find<PopularProductController>().totalitems>=1?
                          Positioned(
                              right:5,
                              top:3,
                              child: BigText(text: Get.find<PopularProductController>().totalitems.toString() ,
                                size: 12,color: Colors.white,
                              )
                          )
                              :Container(),

                        ],
                      ),
                    );
                  })
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20))),
                    child: Center(
                        child: BigText(
                      size: Dimensions.font26,
                      text: product.name!,
                    ))),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,

                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandabeleTextWidget(
                        text:product.description!
         ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        icon: Icons.remove,
                        iconSize: Dimensions.iconSize24,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText(text: "\$ ${product.price}  X ${controller.inCartItems}",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                    GestureDetector(
                      onTap: (){
                        controller.setQuantity((true));
                      },
                      child:  AppIcon(
                        icon: Icons.add,
                        iconSize: Dimensions.iconSize24,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(top: Dimensions.height30,bottom:Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20 ),
                decoration: BoxDecoration(
                    color: AppColors.buttonBgColor,
                    borderRadius: BorderRadius.only(

                        topLeft: Radius.circular(Dimensions.radius20*2),
                        topRight:  Radius.circular(Dimensions.radius20*2)
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom:  Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,

                      ) ,
                    ),
                   GestureDetector(
                     onTap: (){
                       controller.addItem(product);
                     },
                     child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom:  Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor
                        ),
                        child: BigText(text: '\$ ${product.price}   |  Add to cart',color: Colors.white,),
                      ),
                   ),

                  ],
                ),
              ),
            ],
          );
        },)
      ),
    );
  }
}
