import 'package:json_annotation/json_annotation.dart';
import 'package:technical_test_meddi_yosidey/models/error/error.dart';

part 'user_model.g.dart';

class UserCreate {
  @JsonKey(name: 'username')
  final String userName;
  final String? password;
  final String name;
  @JsonKey(name: 'cellphone')
  final String cellPhone;

  UserCreate({required this.userName, required this.password, required this.name, required this.cellPhone});

  factory UserCreate.fromJson(Map<String, dynamic> json) => _$UserCreateFromJson(json);

  Map<String, dynamic> toJson() => _$UserCreateToJson(this);
}

class ResponseUserCreate {
  final bool ok;
  final int status;
  final DataUser data;

  ResponseUserCreate({required this.ok, required this.status, required this.data});

  factory ResponseUserCreate.fromJson(Map<String, dynamic> json) => _$ResponseUserCreateFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserCreateToJson(this);
}

class DataUser {
  final User user;

  DataUser({required this.user});

  factory DataUser.fromJson(Map<String, dynamic> json) => _$DataUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserToJson(this);
}

class User {
  @JsonKey(name: 'username')
  final String userName;
  final String name;
  @JsonKey(name: 'cellphone')
  final String cellPhone;

  User({required this.userName, required this.name, required this.cellPhone});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class UserLogin {
  @JsonKey(name: 'username')
  final String userName;
  final String password;

  UserLogin({required this.userName, required this.password});

  factory UserLogin.fromJson(Map<String, dynamic> json) => _$UserLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}

class ResponseUserLogin {
  final bool ok;
  final int status;
  final dynamic data;

  ResponseUserLogin({required this.ok, required this.status, required this.data});

  factory ResponseUserLogin.fromJson(Map<String, dynamic> json) => _$UserResponseLoginFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseLoginToJson(this);
}

class DataToken {
  final String jwtToken;

  DataToken({required this.jwtToken});

  factory DataToken.fromJson(Map<String, dynamic> json) => _$DataTokenUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataTokenUserToJson(this);
}
