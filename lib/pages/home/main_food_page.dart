import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/home/food_page_body.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:fooddelivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _loadResource,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [

                        BigText(text: 'Yemen',color: AppColors.mainColor,size: 30,),
                        Row(
                          children: [

                            SmallText(text: "Taiz",color: Colors.black54,),
                            const Icon(Icons.arrow_drop_down)

                          ],
                        )

                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.mainColor,
                        ),
                        child:  Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                      ),
                    )
                  ],
                ),
              ),
               Expanded(child: SingleChildScrollView(child: FoodPageBody()),),
            ],
          ),
        ),
      ),
    );
  }
}
