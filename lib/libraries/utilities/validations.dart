import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;

class Validations{

  bool isEmpty(String value){
    return value.isEmpty;
  }

  bool isEquals(String text1, String text2){
    return text1==text2;
  }
  bool isEmail(String email) {
    return RegExp(app_data.expEmail).hasMatch(email);
  }
  bool isPhone(String text) {
    return RegExp(app_data.expPhone).hasMatch(text);
  }

}