
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/base/custom_loader.dart';
import 'package:fooddelivery/pages/auth/sign_app_page.dart';
import 'package:fooddelivery/routes/routes_helper.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/app_text_field.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController= TextEditingController();
    var passwordController= TextEditingController();


    void login( AuthController authController){

      String email=emailController.text.trim();
      String password=passwordController.text.trim();
  if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid  email address",title: "valid email address");

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");

      }
      else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: "Password");

      }else{

        authController.login(email , password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }
          else{
             // print("hhhhhhhhh"+status.message);
            showCustomSnackBar(status.message);
          }
        });


      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController){
          return !authController.isLoading? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(

              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //app logo
                SizedBox(
                  height: Dimensions.screenHeight*0.25,
                  child: const Center(
                    child: CircleAvatar(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: Dimensions.font20*3+Dimensions.font20/2,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Sign into your account",
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),

                //your email
                AppTextField(textController: emailController,
                    hintText: "Email",
                    icon: Icons.email),
                SizedBox(height: Dimensions.height20,),
                //password
                AppTextField(textController: passwordController,
                    hintText: "Password",
                    isObsecure: true,
                    icon: Icons.password),
                SizedBox(height: Dimensions.height20,),



                Row(
                  children: [
                    Expanded(child: Container()),
                    RichText(

                        text:TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20
                            )
                        )
                    ),
                    SizedBox(width:  Dimensions.width20,)
                  ],
                ),

                SizedBox(height: Dimensions.screenHeight*0.05,),

                //sign in button
                GestureDetector(
                  onTap: (){
                    login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor
                    ),
                    //sign up button
                    child: Center(
                      child: BigText(
                        text: "Sign In",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,

                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),

                RichText(

                    text:TextSpan(
                        text: "Don\'t have an account?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        ),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(),transition: Transition.fade),
                              text: "Create",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.font20
                              )),
                        ]

                    )
                ),

              ],
            ),
          ):CustomLoader();
        })
      ),
    );
  }
}
