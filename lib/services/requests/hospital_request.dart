import 'dart:convert';

import 'package:technical_test_meddi_yosidey/models/hospital/hospital_model.dart';
import 'package:technical_test_meddi_yosidey/services/helpers/apibase_helper.dart';
import 'package:technical_test_meddi_yosidey/libraries/url_data.dart' as url_data;
import 'package:technical_test_meddi_yosidey/services/storage/user_storage.dart';

class HospitalRequest {
  static final HospitalRequest _instance = HospitalRequest.internal();

  factory HospitalRequest() => _instance;

  HospitalRequest.internal();

  Future<ResponseHospital> getHospitals(int page) async {
    final storage = UserStorage();
    String? token = await storage.getToken();
    String point = url_data.hospitals + page.toString();
    ApiService apiServer = ApiService(point, token: token);
    var response = await apiServer.apiGetRequest();
    var dataProduct = ResponseHospital.fromJson(response);

    return dataProduct;
  }

  Future<void> requestsHospital(RequestHospital hospital) async {
    final storage = UserStorage();
    String? token = await storage.getToken();
    String point = url_data.request;
    ApiService apiServer = ApiService(point, token: token);
    var response = await apiServer.apiPostRequest(jsonEncode(hospital));
    return;
  }
}
