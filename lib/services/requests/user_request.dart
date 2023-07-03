import 'dart:convert';


import 'package:technical_test_meddi_yosidey/services/helpers/apibase_helper.dart';
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';
import 'package:technical_test_meddi_yosidey/libraries/url_data.dart' as url_data;


class UserRequest {
  static final UserRequest _instance = UserRequest.internal();

  factory UserRequest() => _instance;

  UserRequest.internal();

  Future<ResponseUserLogin> loginUser({required UserLogin user}) async {
    ApiService apiServer = ApiService(url_data.authUserLogin);
    var response = await apiServer.apiPostRequest(jsonEncode(user));
    print("userLogin$response");
    var userLogin = ResponseUserLogin.fromJson(response);

    return userLogin;
  }

  Future<ResponseUserCreate> createUser({required UserCreate user}) async {
    ApiService apiServer = ApiService(url_data.authUserCreate);
    var response = await apiServer.apiPostRequest(jsonEncode(user));
    print("userCreate$response");
    var userCreate = ResponseUserCreate.fromJson(response);

    return userCreate;
  }


}
