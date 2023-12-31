import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/utils/app_constant.dart';
import 'package:get/get.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}