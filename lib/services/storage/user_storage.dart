import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;
import 'package:technical_test_meddi_yosidey/models/user/user_model.dart';

class UserStorage {
  static final UserStorage _instance = UserStorage.internal();

  factory UserStorage() => _instance;

  UserStorage.internal();

  Future<bool> hasToken() async {
    const storage = FlutterSecureStorage();
    return (await storage.read(key: app_data.appSecureUserToken) == null ? false : true);
  }

  Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: app_data.appSecureUserToken) ?? "";
  }

  Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: app_data.appSecureUserToken);
    return;
  }

  Future<void> persistToken(ResponseUserLogin responseUserLogin) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: app_data.appSecureUserToken, value: responseUserLogin.data.jwtToken);
    return;
  }
}
