import 'package:flutter/material.dart';
import 'package:fooddelivery/controller/cart_controller.dart';
import 'package:fooddelivery/controller/popular_product_controller.dart';
import 'package:fooddelivery/pages/home/main_food_page.dart';
import 'package:fooddelivery/routes/routes_helper.dart';
import 'package:fooddelivery/utils/app_constant.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/extandable_text_wedget.dart';
import 'package:get/get.dart';
import '../../widgets/app_column_widget.dart';
import '../../widgets/app_icon.dart';

class PopularFoodDetails extends StatelessWidget {
final  int pageId;
final String page;
   const PopularFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),

          )),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left:  Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
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
                      child:
                      AppIcon(icon: Icons.arrow_back_ios,)
                  ),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalitems>1)
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

              )),
          //introduction of food
          Positioned(
            left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft:  Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduction"),
                    SizedBox(height: Dimensions.height20,),
                     Expanded(child: SingleChildScrollView(child:
                    ExpandabeleTextWidget(text: product.description!,))
                    )
                  ],
                )

          ))
          //expandable text

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
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
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);

                        },child: Icon(Icons.remove,color: AppColors.signcolor,)),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(true);


                        },
                        child: Icon(Icons.add,color: AppColors.signcolor,)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom:  Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                ),
                child: GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                    child: BigText(text: '\$ ${product.price!}     |  Add to cart',color: Colors.white,)),
              )
            ],
          ),
        );
      }),
    );
  }
}
