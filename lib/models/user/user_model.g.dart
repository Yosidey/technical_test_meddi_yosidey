part of 'user_model.dart';

///UserCreate
UserCreate _$UserCreateFromJson(Map<String, dynamic> json) => UserCreate(
      userName: json['username'] as String,
      password: json['password'] as String?,
      name: json['name'] as String,
      cellPhone: json['cellphone'] as String,
    );

Map<String, dynamic> _$UserCreateToJson(UserCreate instance) => <String, dynamic>{
      "username": instance.userName,
      "password": instance.password,
      "name": instance.name,
      "cellphone": instance.cellPhone,
    };

///ResponseUserCreate
ResponseUserCreate _$ResponseUserCreateFromJson(Map<String, dynamic> json) => ResponseUserCreate(
      ok: json['ok'] as bool,
      status: json['status'] as int,
      data: DataUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseUserCreateToJson(ResponseUserCreate instance) => <String, dynamic>{
      "ok": instance.ok,
      "status": instance.status,
      "data": instance.data,
    };

///DataUser
DataUser _$DataUserFromJson(Map<String, dynamic> json) => DataUser(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataUserToJson(DataUser instance) => <String, dynamic>{
      "user": instance.user,
    };

///User
User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['username'] as String,
      name: json['name'] as String,
      cellPhone: json['cellphone'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      "username": instance.userName,
      "name": instance.name,
      "cellphone": instance.cellPhone,
    };

///UserLogin
UserLogin _$UserLoginFromJson(Map<String, dynamic> json) => UserLogin(
      userName: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      "username": instance.userName,
      "password": instance.password,
    };

///UserResponseLogin
ResponseUserLogin _$UserResponseLoginFromJson(Map<String, dynamic> json) => ResponseUserLogin(
    ok: json['ok'] as bool,
    status: json['status'] as int,
    data: json['dart.message'] is DataError
        ? DataError.fromJson(json['data'] as Map<String, dynamic>)
        : DataToken.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$UserResponseLoginToJson(ResponseUserLogin instance) => <String, dynamic>{

      "ok": instance.ok,
      "status": instance.status,
      "data": instance.data,
    };

///DataToken
DataToken _$DataTokenUserFromJson(Map<String, dynamic> json) => DataToken(
      jwtToken: json['jwtToken'] as String,
    );

Map<String, dynamic> _$DataTokenUserToJson(DataToken instance) => <String, dynamic>{
      "jwtToken": instance.jwtToken,
    };
