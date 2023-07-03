part of 'error.dart';

///ResponseError
ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) => ResponseError(
      ok: json['ok'] as bool,
      status: json['status'] as int,
      data: DataError.fromJson(json['ticket'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) => <String, dynamic>{
      "ok": instance.ok,
      "status": instance.status,
      "data": instance.data,
    };

///DataError
DataError _$DataErrorFromJson(Map<String, dynamic> json) => DataError(
      message: json['message'] as String,
    );

Map<String, dynamic> _$DataErrorToJson(DataError instance) => <String, dynamic>{
      "message": instance.message,
    };
