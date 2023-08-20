
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/controller/auth_controller.dart';
import 'package:fooddelivery/pages/auth/sign_in_page.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimentions.dart';
import 'package:fooddelivery/widgets/app_text_field.dart';
import 'package:fooddelivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../models/signup_body.dart';
import '../../routes/routes_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController= TextEditingController();
    var passwordController= TextEditingController();
    var nameController= TextEditingController();
    var phoneController= TextEditingController();
    var signUpImages=[
      "t.png",
      "f.png",
      "g.png"
    ];
    void registration( AuthController authController){
      String name=nameController.text.trim();
      String phone=phoneController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
     if(name.isEmpty){
       showCustomSnackBar("Type in your name",title: "Name");
     }else if(phone.isEmpty){
       showCustomSnackBar("Type in your phone number",title: "Phone number");

     }else if(email.isEmpty){
       showCustomSnackBar("Type in your email address",title: "Email");

     }
     else if(!GetUtils.isEmail(email)){
       showCustomSnackBar("Type in a valid  email address",title: "valid email address");

     }else if(password.isEmpty){
       showCustomSnackBar("Type in your password",title: "Password");

     }
     else if(password.length<6){
       showCustomSnackBar("Password can not be less than six characters",title: "Password");

     }else{
       showCustomSnackBar("All went well",title: "Perfect");
       SignUpBody signUpBody =SignUpBody(
           name: name,
           phone: phone,
           email: email,
           password: password);
       authController.registration(signUpBody).then((status){
         if(status.isSuccess){
           Get.offNamed(RouteHelper.getInitial());


         }
         else{
         //  print(status.message);
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

                //your email
                AppTextField(textController: emailController,
                    hintText: "Email",
                    icon: Icons.email),
                SizedBox(height: Dimensions.height20,),
                //password
                AppTextField(textController: passwordController,
                    isObsecure: true,
                    hintText: "Password",
                    icon: Icons.password_sharp),
                SizedBox(height: Dimensions.height20,),
                //name
                AppTextField(textController: nameController,
                    hintText: "Name",
                    icon: Icons.person),
                SizedBox(height: Dimensions.height20,),
                //phone number
                AppTextField(textController: phoneController,
                    hintText: "Phone",
                    icon: Icons.phone),
                SizedBox(height: Dimensions.height20,),

                GestureDetector(
                  onTap: (){
                    registration(authController);
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
                        text: "Sign Up",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,

                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                //sign up option
                RichText(

                    text:TextSpan(
                        recognizer:TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignInPage(),transition: Transition.fade),
                        text: "Have an account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    )
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                RichText(

                    text:TextSpan(
                        text: "Sign up using of the following methods",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16
                        )
                    )
                ),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage(
                          "assets/images/"+signUpImages[index]
                      ),
                    ),
                  )),
                )

              ],
            ),
          ):CustomLoader();
        },)
      ),
    );

  }
}
