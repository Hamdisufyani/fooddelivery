import 'package:fooddelivery/data/repository/auth_repo.dart';
import 'package:fooddelivery/models/response_model.dart';
import 'package:fooddelivery/models/signup_body.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });
  bool _isLoading =false;
  bool get isLoading=>_isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{
    authRepo.getUserToken();
    _isLoading= true;
    update();
   Response response=await authRepo.registration(signUpBody);
   late ResponseModel responseModel;
   if(response.statusCode==200){
       authRepo.saveUserToken(response.body["token"]);
       responseModel =ResponseModel(true, response.body["token"]);
   }else{
     responseModel =ResponseModel(false, response.statusText!);

   }
    _isLoading= false;
   update();
   return responseModel;
  }


  Future<ResponseModel> login(String email, String password) async{
    _isLoading= true;
    update();
    Response response=await authRepo.login(email,password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel =ResponseModel(true, response.body["token"]);
    }else{
      responseModel =ResponseModel(false, response.statusText!);

    }
    _isLoading= false;
    update();
    return responseModel;
  }

  void saveUseNumberAndPassword(String number, String password) {
  authRepo.saveUseNumberAndPassword(number, password);
  }

  bool userLoggedIn()  {
    return authRepo.userLoggedIn();
  }

  bool clearShareddata(){
    return authRepo.clearSharedData();
  }
}
