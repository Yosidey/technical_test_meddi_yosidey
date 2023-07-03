
part 'error.g.dart';

class ResponseError {
  final bool ok;
  final int status;
  final DataError data;

  ResponseError({required this.ok, required this.status, required this.data});
  factory ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}

class DataError {
  final String message;

  DataError({required this.message});
  factory DataError.fromJson(Map<String, dynamic> json) => _$DataErrorFromJson(json);

  Map<String, dynamic> toJson() => _$DataErrorToJson(this);

}
