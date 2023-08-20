import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/models/signup_body.dart';
import 'package:fooddelivery/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
});
  
 Future<Response> registration(SignUpBody signUpBody) async{
   return await  apiClient.posData(AppConstants.REGISTRATION_URI, signUpBody.toJson());

  }
  bool userLoggedIn()  {
   return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  Future<Response> login(String email , String password) async{
    return await  apiClient.posData(AppConstants.LOGIN_URI, {"email":email,"password":password});

  }
  Future<bool> saveUserToken(String token) async{
   apiClient.token=token;
  apiClient.updateHeader(token);
  return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUseNumberAndPassword(String number, String password) async{
   try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);


   }catch(e){
     throw e;
   }
  }

  bool clearSharedData(){
   sharedPreferences.remove(AppConstants.TOKEN);
   sharedPreferences.remove(AppConstants.PASSWORD);
   sharedPreferences.remove(AppConstants.PHONE);
   apiClient.token='';
   apiClient.updateHeader('');

   return true;
  }

}